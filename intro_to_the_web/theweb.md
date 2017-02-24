# The Web: An Introduction

[Back to the Challenge Map](README.md)

The World Wide Web is an information space made up of two chief components: resources (mostly stored on **servers**), and the entities that request those resources (usually called **clients**). When you visit a website, such as http://www.google.com, your browser (e.g. Firefox, Chrome, Safari) acts as a _client_. It requests a resource - in this case, the Google homepage - from a _server_. The server returns the requested resource.

The whole Web is built on **client-server** relationships. There are different kinds of **clients** and **servers** but the relationship is roughly the same: the client is dependent on the server for providing and managing information. Anything that can request a resource from a server can be called a client.

In this challenge you will use your command line as a client to interact with a server.

### Learning Objectives covered
- Understand the client-server relationship.

### Challenge setup
This challenge uses [httpie](https://github.com/jkbrzt/httpie), a command line tool useful for making HTTP requests. Install it from the command line with: `brew install httpie`.

### To complete this challenge, you will need to:

- [ ] From the command line, use httpie to make a request to 'http://makersipsum.herokuapp.com'
- [ ] Explain to your partner what you see.
- [ ] Explain to your partner:
  - [ ] what the "client" is in this situation.
  - [ ] what the "server" is in this situation.
- Repeat the same process in a browser.

### Resources

- [httpie usage](https://github.com/jkbrzt/httpie#usage)
- httpie manual: type `man http` from the command line
- [Client-server model](https://en.wikipedia.org/wiki/Client%E2%80%93server_model)

### [Walkthrough](walkthroughs/theweb.md)
