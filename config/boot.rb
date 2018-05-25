require 'grape'
require 'yaml'
require 'sequel'

db_config = YAML.load_file('./config/database.yml')
DB = Sequel.connect(db_config)
Sequel::Model.plugin :timestamps
Sequel.extension :migration
Sequel::Migrator.run(DB, './db/migrate', use_transactions: true)

Dir['./app/helpers/**/*.rb'].each {|f| require f}
Dir['./app/models/**/*.rb'].each {|f| require f}