# Walkthrough

[Back to Challenge](../10_creating_a_modular_sinatra_app.md)

We're failing our feature test because we haven't built an application that serves `/links`. Let's do that now:

```ruby
# in app/app.rb
require 'sinatra/base'

class BookmarkManager < Sinatra::Base
end
```

Let's run our feature test again:

```
Failures:

 1) Viewing links I can see existing links on the links page
    Failure/Error: expect(page.status_code).to eq 200

      expected: 200
           got: 404

      (compared using ==)
    # ./spec/features/listing_all_links_spec.rb:6:in `block (2 levels) in <top (required)>'

Finished in 0.02297 seconds (files took 0.693 seconds to load)
1 example, 1 failure
```

We're seeing this error because we've built a Sinatra application, but we haven't provided the `/links` route yet. That gives us a status code of 404.

Let's add the `/links` route, and use DataMapper's `.all` method to fetch all `Links` before we render the view:

```ruby
# /app/app.rb
require 'sinatra/base'
# We're gonna need our Link model
require_relative 'models/link'

class BookmarkManager < Sinatra::Base
  get '/links' do
    # This uses DataMapper's .all method to fetch all
    # data pertaining to this class from the database
    @links = Link.all
    erb :'links/index'
  end
end
```

We'll use the `@links` data inside our `views/links/index.erb` view:

```html
<!-- in views/links/index.erb -->
<h1> Links </h1>

<ul id='links'>
  <% @links.each do |link| %>
    <li>
      Title: <%= link.title %>
      URL:   <%= link.url   %>
    </li>
  <% end %>
</ul>
```

Finally, we need to tell RSpec how to run our app in the feature tests:

```ruby
# in spec/spec_helper.rb

require 'capybara/rspec'
require './app/app'
Capybara.app = BookmarkManager
```

Let's run our feature test again. It passes! We rock! Take a break.

[To the Next Challenge](../11_creating_links.md)
