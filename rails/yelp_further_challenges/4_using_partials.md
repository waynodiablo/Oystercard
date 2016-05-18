#### Refactoring using partials

A good rule of thumb is that if you do something twice, you should consider refactoring (if you're doing it three times, *definitely* refactor).

We've used the same form for restaurants twice (in create and edit) – exactly the same code. This is unnecessary duplication, and it also makes life more difficult for us. If we updated our restaurants model – say we wanted it to include an address – then we have two forms to update. If we forgot to do that, things would break.

Much better would be to have the same form abstracted out, and *refer* to it twice. Rails makes this easy with [partials](http://guides.rubyonrails.org/layouts_and_rendering.html#using-partials).

Let's do that now. Create `app/views/restaurants/_form.html.erb` (the prepended `_` indicates this is a partial) and copy and paste the form there.

Now, in both places we refer to the form (`app/views/restaurants/edit.html.erb` and `app/views/restaurants/new.html.erb`), remove the form and type this line instead:

```erb
<%= render "form" %>
```

So much cleaner! Rails knows to refer to the `_form` file we just created and slot it into the layout when the page is rendered.  Commit and :twisted_rightwards_arrows:.
