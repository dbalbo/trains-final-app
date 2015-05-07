require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/train')
require('./lib/city')
require('pg')

DB = PG.connect({:dbname => "train_schedule"})

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
  @train = Train.find(params.fetch("id").to_i())
  @cities = City.all()
  erb(:train)
end

get("/cities/:id") do
  @city = City.find(params.fetch("id").to_i())
  @trains = Train.all()
  erb(:city)
end

post("/trains") do
  name = params.fetch("name")
  train = Train.new({:name => name, :id => nil})
  train.save()
  @trains = Train.all()
  erb(:trains)
end

post("/cities") do
  name = params.fetch("name")
  city = City.new({:name => name, :id => nil})
  city.save()
  @cities = City.all()
  erb(:cities)
end

patch("/trains/:id") do
  train_id = params.fetch("id").to_i()
  @train = Train.find(train_id)
  city_ids = params.fetch("city_ids", [])
  @train.update({:city_ids => city_ids})
  @cities = City.all()
  erb(:train)
end

patch("/cities/:id") do
  city_id = params.fetch("id").to_i()
  @city = City.find(city_id)
  train_ids = params.fetch("train_ids", [])
  @city.update({:train_ids => train_ids})
  @trains = Train.all()
  erb(:city)
end

delete("/cities/:id") do
  @train = Train.all()
  @city = City.find(params.fetch("id").to_i())
  @city.delete()
  @cities = City.all()
  erb(:index)
end

delete("/trains/:id") do
  @city = City.all()
  @train = Train.find(params.fetch("id").to_i())
  @train.delete()
  @trains = Train.all()
  erb(:index)
end
