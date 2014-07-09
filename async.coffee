async = require "async"
User = require "./models/user"

updateUser = (user, cb)->
  user.username = user.username.toUpperCase()
  user.save().success cb

User.findAll().success (users)->
  async.mapSeries users, updateUser, (err, result)->
    console.log arguments
