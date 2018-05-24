require 'grape'
# require all API modules
Dir['./app/api/**/*.rb'].each {|file| require file }