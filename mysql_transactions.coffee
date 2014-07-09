Payment = require "../models/payment"
wallet  = Wallet.build()

GLOBAL.db.sequelize.transaction (mysqlTransaction)->
  Payment.create(data, {transaction: mysqlTransaction}).complete (err, payment)->
    if err
      return mysqlTransaction.rollback().success ()->
        callback err
    wallet.increment({balance: newBalance}, {transaction: mysqlTransaction}).complete (err)->
      if err
        return mysqlTransaction.rollback().success ()->
          callback err
      mysqlTransaction.commit().success ()->
        callback null, payment
