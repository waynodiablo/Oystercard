# Capybara

**What is Capybara?**

Capybara is a ruby gem that allows you to easily test the user experience of a web-based application. It provides methods that can mimic the actions a user would make in the browser, and test the outcomes of those actions in terms of what the user should be able to see. These methods can be used in conjunction with RSpec or Cucumber (or other test frameworks such as minitest, which are not covered in this course).

**How do I use capybara?**

Firstly, install capybara for your chosen feature test framework (usually RSpec or Cucumber), following the instructions in the [documentation](https://github.com/jnicklas/capybara). This then allows the capybara methods to be used from within your tests.

RSpec

```
feature 'Home Page' do
  scenario 'view the welcome message' do
    visit '/'
    expect(page).to have_content('Welcome!')
  end
end
```

Cucumber (within homepage_steps.rb)
```
When /^(?:|I )go to (.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^(?:|I )press "([^\"]*)"(?: within "([^\"]*)")?$/ do |button, selector|
  with_scope(selector) do
    click_button(button)
  end
end
```

**What methods are provided?**

Capybara methods can be broadly broken down into categories as follows:

1. Navigation - methods that navigate to a page, i.e. `visit '/'`
2. Clicking - methods that click something on a page, i.e. `click_button 'Submit'`
3. Interacting - methods that mimic the user entering form data, i.e. `fill_in('name', with: 'dave')`
4. Matching - methods that test expectations, i.e. `expect('#blog-post').to have_content('News')`
5. Scoping - methods that target a specific area of the page, i.e. `within('#blog-post') do`
6. Other - Other user actions such as checking check boxes, selecting select options or attaching files.

An excellent list of the primary capybara methods can be found in this [cheat sheet](http://www.cheatography.com/ddovii/cheat-sheets/capybara-cheat-sheet/).
