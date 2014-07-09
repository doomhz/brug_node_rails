option "-e", "--email [EMAIL]", "User email"
option "-u", "--user [ID]", "User ID"
option "-o", "--order [ID]", "Order ID"

task "show_options", "Show given options", (opts)->
  console.log opts

task "db:migrate", "Run pending database migrations", ()->
  migrator = GLOBAL.db.sequelize.getMigrator
    path:        "#{process.cwd()}/models/migrations"
    filesFilter: /\.coffee$/
    coffee: true
  migrator.migrate().success ()->
    console.log "Database migrations finished."
