mongooseAuth = require('mongoose-auth')

UserSchema = new Schema
  email:
    type: String
    required: true
    index:
      unique: true
  domain:
    type: String
    required: true
    index:
      unique: true
  token:
    type: String
    index:
      unique: true
  created:
    type: Date
    default: Date.now
  updated:
    type: Date
    default: Date.now

UserSchema.set("autoIndex", false)

UserSchema.methods.generateToken = (callback = ()->)->
  @token = require("crypto").createHash("md5").update("#{@_id}#{Date.now()}").digest("hex")
  @save (err, u)->
    callback(u.token)

UserSchema.statics.findByToken = (token, callback = ()->)->
  User.findOne({token: token}).exec (err, user)->
    callback(err, user)

User = mongoose.model("User", UserSchema)
exports = module.exports = User