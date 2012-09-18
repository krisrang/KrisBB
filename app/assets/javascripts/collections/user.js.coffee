'use strict';

class Users extends Backbone.Collection
  url: '/users'
  model: KrisBB.models.User

window.KrisBB.collections.Users = new Users()
