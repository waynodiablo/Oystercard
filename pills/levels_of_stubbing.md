# Stubbing 3rd Party Network APIS

In general you shouldn't be stubbing out behaviour on the object under test.  The two key exceptions are when you have randomness or a 3rd party API.  There are several different levels we can stub out the interaction with a 3rd party API such as Twilio (used for sending SMS messages).  Say that we are using the Twilio gem liks so:

```ruby 
class Takeaway

  def complete_order
    send_text("Thank you for your order: £#{total_price}")
  end

  def send_text(message)
    Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])
      .messages.create(
        from: ENV['TWILIO_PHONE'],
        to: ENV['TWILIO_DESTINATION_PHONE'],
        body: message
      )
  end

  ...
end
```

And test of complete_order will have the side effect of sending an SMS.  

## Stub the Class

The simplest way to avoid this is to stub out like so:

```ruby
describe Takeaway
  subject(:takeaway) { described_class.new }
  it 'sends a payment confirmation text message' do
    expect(takeaway).to receive(:send_text).with("Thank you for your order: £20.93")
    takeaway.complete_order(20.93)
  end
end
```

This ensures that Takeaway#complete_order gets some test coverage and that no SMS will be sent by our tests.  This is acceptable, but we still don't have very good test coverage. 

## Stub the Gem

What alternatives do we have?  One is to use some of RSpec's legacy code features like [`receive_message_chain`](https://relishapp.com/rspec/rspec-mocks/docs/working-with-legacy-code/message-chains):

```ruby
describe Takeaway do

  let(:client) { double :client }
  it "can send text" do
    message = 'order complete'
    twilio_message_body = { from: ENV['TWILIO_PHONE'], to: ENV['TWILIO_DESTINATION_PHONE'], body: message }
    allow(client).to receive_message_chain(:messages, :create).with(twilio_message_body)
    expect(Twilio::REST::Client).to receive(:new).with(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']).and_return(client)
    subject.send_text(message)
  end
end
```

This has the advantage that we have now precisely stubbed out our applications interaction with the Twilio gem, but we've got some really brittle convoluted code here.  As soon as Twilio's gem changes our application will break, but our tests will still pass.  Can we do better?

## Stub the Network with Webmock

Rather than stubbing at the level of the Twilio gem we can go one level lower and stub the network interface using [webmock](https://github.com/bblimke/webmock).  See the webmock README and the [relish docs](https://www.relishapp.com/webmock/webmock/docs/stubbing/stubbing-requests) for more details, but now we can have code like this in our tests:

```ruby
describe Takeaway do
  it "can send text" do
    message = 'order complete'
    host = "#{ENV['TWILIO_ACCOUNT_SID']}: #{ENV['TWILIO_AUTH_TOKEN']}@api.twilio.com"
    stub_request(:post, "#{host}/2010-04-01/Accounts/#{ENV['TWILIO_ACCOUNT_SID']}/Messages.json").
      with(:body => {:data => {'From' => ENV['TWILIO_PHONE'], 'To' => ENV['TWILIO_DESTINATION_PHONE'], 'Body' => message}})
    subject.send_text(message)
  end
end
```

We are no longer dependent on the specifics of how the Twilio gem happens to arrange its interface, but this is still a little convoluted and requires us to understand exactly which URL endpoints the Twilio gem is hitting in order to communicate with the remote Twilio API over HTTP.

## Manage Your Network Stubbing with VCR

We can make management of all this a little easier with a gem like [VCR](https://github.com/vcr/vcr).  This requires more setup, but VCR operates so that it records all the network interactions that your application has in yaml files.  Full details of operation in [VCR](https://github.com/vcr/vcr)'s README, but here's a taste:

```ruby
  it "receives a text message after the order is placed" do
    VCR.use_cassette('twilio') do
      takeaway.complete_order(20.93)
    end
  end
```

configure in spec_helper like so:

```ruby
require 'vcr'
require 'webmock'

TWILIO_VARS = []
TWILIO_VARS << 'TWILIO_ACCOUNT_SID'
TWILIO_VARS << 'TWILIO_AUTH_TOKEN'
TWILIO_VARS << 'TWILIO_PHONE'
TWILIO_VARS << 'TWILIO_DESTINATION_PHONE'

VCR.configure do |config|
  config.cassette_library_dir = "fixtures/vcr_cassettes"
  config.hook_into :webmock 
  TWILIO_VARS.each do |var|
    config.filter_sensitive_data("<#{var}>") { ENV[var] }
  end
end
```

and when you first run the test it will generate a YAML file `fixtures/vcr_cassettes/twilio.yml` with contents like the following:

```yml
---
http_interactions:
- request:
    method: post
    uri: https://<TWILIO_ACCOUNT_SID>:<TWILIO_AUTH_TOKEN>@api.twilio.com/2010-04-01/Accounts/<TWILIO_ACCOUNT_SID>/Messages.json
    body:
      encoding: US-ASCII
      string: From=%2B441244470174&To=%2B447964143662&Body=Thank+you%21+Your+order+was+placed+and+will+be+delivered+by+08%3A25
    headers:
      Accept:
      - application/json
      Accept-Charset:
      - utf-8
      User-Agent:
      - twilio-ruby/4.3.0 (ruby/x86_64-darwin14 2.2.3-p173)
      Accept-Encoding:
      - gzip;q=1.0,deflate;q=0.6,identity;q=0.3
      Content-Type:
      - application/x-www-form-urlencoded
  response:
    status:
      code: 201
      message: CREATED
    headers:
      Access-Control-Allow-Credentials:
      - 'true'
      Access-Control-Allow-Headers:
      - Accept, Authorization, Content-Type, If-Match, If-Modified-Since, If-None-Match,
        If-Unmodified-Since
      Access-Control-Allow-Methods:
      - GET, POST, DELETE, OPTIONS
      Access-Control-Allow-Origin:
      - "*"
      Access-Control-Expose-Headers:
      - ETag
      Content-Type:
      - application/json; charset=utf-8
      Date:
      - Fri, 16 Oct 2015 06:25:50 GMT
      Strict-Transport-Security:
      - max-age=15768000
      Twilio-Request-Duration:
      - '0.401'
      Twilio-Request-Id:
      - RQ6d0be67f2f364bc18fd18d7908f60015
      X-Powered-By:
      - AT-5000
      X-Shenanigans:
      - none
      Content-Length:
      - '798'
      Connection:
      - keep-alive
    body:
      encoding: UTF-8
      string: '{"sid": "SMcc9851310a374cfc9bc18a58209dda82", "date_created": "Fri,
        16 Oct 2015 06:25:50 +0000", "date_updated": "Fri, 16 Oct 2015 06:25:50 +0000",
        "date_sent": null, "account_sid": "<TWILIO_ACCOUNT_SID>", "to": "<TWILIO_DESTINATION_PHONE>",
        "from": "<TWILIO_PHONE>", "body": "Thank you! Your order was placed and will
        be delivered by 08:25", "status": "queued", "num_segments": "1", "num_media":
        "0", "direction": "outbound-api", "api_version": "2010-04-01", "price": null,
        "price_unit": "USD", "error_code": null, "error_message": null, "uri": "/2010-04-01/Accounts/<TWILIO_ACCOUNT_SID>/Messages/SMcc9851310a374cfc9bc18a58209dda82.json",
        "subresource_uris": {"media": "/2010-04-01/Accounts/<TWILIO_ACCOUNT_SID>/Messages/SMcc9851310a374cfc9bc18a58209dda82/Media.json"}}'
    http_version: 
  recorded_at: Fri, 16 Oct 2015 06:25:50 GMT
recorded_with: VCR 2.9.3
```

Note that on first operation the text message will be sent, but on second and subsequent usage no text message will be sent and the full stack of your app and the Twilio gem all the way down to the network layer will be exercised.  If the Twilio API or gem changes, just delete the file and re-record.

Note also that with this VCR configuration we are replacing any sensitive data in the YAML file such as our Twilio authentication ids etc.

Checking this file into version control ensures that automated CI systems will avoid sending unwanted SMS messages (in this case) and prevent unwanted network interactions from your app (in general).  In fact all the solutions have the same overall effect and it is a matter of taste about the particular level at which you stub interactions with 3rd party services over the network.  The higher level stubbing makes more sense for unit tests (class level stubbing, stubbing the gem), where the lower level stubbing (webmock, vcr) make more sense in feature tests.
