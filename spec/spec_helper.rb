require('rspec')
require('pg')
require('city')
require('train')
require('pry')

DB = PG.connect({:dbname => 'train_schedule_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec('DELETE FROM cities *;')
    DB.exec("DELETE FROM trains *;")

  end
end
