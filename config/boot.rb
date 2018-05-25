require 'grape'
require 'yaml'
require 'sequel'

db_config = YAML.load_file('./config/database.yml')
begin
  DB = Sequel.connect(db_config.merge(logger: Logger.new(STDOUT)))
rescue Sequel::DatabaseConnectionError => e
  # Creating db if not exists
  if e.message.include?("database \"#{db_config['database']}\" does not exist")
    Sequel.connect(db_config.merge(database: 'postgres')).execute("CREATE DATABASE #{db_config['database']};")
    p "INFO: New DB (#{db_config['database']}) CREATED"
    DB = Sequel.connect(db_config.merge(logger: Logger.new(STDOUT)))
  else
    raise
  end
end
Sequel::Model.plugin :timestamps, create: :created_at, update: :updated_at, update_on_create: true

Sequel.extension :migration
Sequel::Migrator.run(DB, './db/migrate', use_transactions: true)

Dir['./app/helpers/**/*.rb'].each {|f| require f}
Dir['./app/models/**/*.rb'].each {|f| require f}