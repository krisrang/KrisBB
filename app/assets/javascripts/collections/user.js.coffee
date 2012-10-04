'use strict';

class Users extends Backbone.Collection
  url: '/users'
  model: KrisBB.Models.User

window.KrisBB.Collections.Users = new Users()
