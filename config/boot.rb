require 'grape'
require 'sequel'

DB = Sequel.connect(adapter: 'postgresql', user: 'postgres', password: '1234', database: 'the_shop_db')
Sequel::Model.plugin :timestamps
Sequel.extension :migration
Sequel::Migrator.run(DB, './db/migrate', use_transactions: true)

Dir['./app/helpers/**/*.rb'].each {|f| require f}
Dir['./app/models/**/*.rb'].each {|f| require f}