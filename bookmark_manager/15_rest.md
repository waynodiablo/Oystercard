## REST and Resources

[Back to the Challenge Map](00_challenge_map.md)

Our application is starting to look fully-formed: we can create, read, update, and delete links.

However, our route structure is a mess. Right now we've got the following routes:

- `GET '/'`
- `GET '/add-a-new-link'`
- `POST '/create-new-link'`
- `POST '/delete-link'`
- `GET '/update-a-link/:id'`
- `POST '/update-a-link'`

As a new developer looking at this application, these routes are quite complicated. They don't follow a very consistent structure: and that's with only one resource (links). If we add tags to this, it's going to get horrendous. We need some sort of **agreed convention** for structuring these routes.

In this challenge, you will refactor your routes to a **RESTful** route structure.

## Challenge Setup

REST is based around a simple idea: that CRUD applications are all about taking **actions** on **resources**.

## To complete this challenge, you will need to

- [ ] Update your routes to a RESTful convention.

## Resources

* [:pill: REST](../pills/rest.md)

## [Walkthrough](walkthroughs/15.md)
