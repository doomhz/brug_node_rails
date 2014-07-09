module.exports = (sequelize, DataTypes) ->

  User = sequelize.define "User",
      uuid:
        type: DataTypes.UUID
        defaultValue: DataTypes.UUIDV4
        allowNull: false
        unique: true
        validate:
          isUUID: 4
      email:
        type: DataTypes.STRING
        allowNull: false
        unique: true
        validate:
          isEmail: true
      password:
        type: DataTypes.STRING
        allowNull: false
        validate:
          len: [5, 500]
      username:
        type: DataTypes.STRING
        allowNull: false
        unique: true
        validate:
          isAlphanumericAndUnderscore: (value)->
            message = "The username can have letters, numbers and underscores and should be longer than 4 characters and shorter than 16."
            throw new Error message  if not /^[a-zA-Z0-9_]{4,15}$/.test(value)
      email_verified:
        type: DataTypes.BOOLEAN
        allowNull: false
        defaultValue: false
    ,
      tableName: "users"
      classMethods:
        
        findById: (id, callback = ()->)->
          User.find(id).complete callback

        findByEmail: (email, callback = ()->)->
          User.find({where:{email: email}}).complete callback

      instanceMethods:
        
        isValidPassword: (password)->
          @password is User.hashPassword(password)

  User