require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
#require('spec_helper')
require('./lib/train')
require('./lib/city')
require('pg')

DB = PG.connect({:dbname => "train_schedule_test"})

get("/") do
  erb(:index)
end

get("/trains") do
  @trains = Train.all()
  erb(:trains)
end

get("/cities") do
  @cities = City.all()
  erb(:cities)
end

get("/trains/:id") do
  @train =Train.find(params.fetch("id").to_i())
  @trains = Train.all()
  erb(:train)
end

patch("/t_update/:id") do
  train_id = params.fetch("id").to_i()
  @train = Train.find(train_id)
  city_ids = params.fetch("city_ids")
  @train.update({:city_ids => city_ids})
  @cities = City.all()
  erb(:train)
end

get("/trains/new") do
  erb(:trains_form)
end

post("/trains") do
  name = params.fetch("name")
  train = Train.new({:name => name, :id => nil})
  train.save()
  @trains = Train.all()
  erb(:trains)
end

get("/cities/new") do
  erb(:cities_form)
end

post("/cities") do
  name = params.fetch("name")
  city = City.new({:name => name, :id => nil})
  city.save()
  @cities = City.all()
  erb(:cities)
end

get("/cities/:id") do
  @city = City.find(params.fetch("id").to_i())
  erb(:city)
end

patch("/c_update/:id") do
  city_id = params.fetch("id").to_i()
  @city = City.find(city_id)
  train_ids = params.fetch("train_ids")
  @city.update({:train_ids => train_ids})
  @trains = Train.all()
  erb(:city)
end
