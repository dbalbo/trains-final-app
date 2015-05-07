class City
  attr_reader(:name, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    returned_cities = DB.exec("SELECT * FROM cities;")
    cities = []
    returned_cities.each() do |city|
      name = city.fetch('name')
      id = city.fetch('id').to_i()
      cities.push(City.new({:name => name, :id => id}))
      end
      cities
    end

   define_method(:save) do
     result = DB.exec("INSERT INTO cities (name) VALUES ('#{@name}') RETURNING id;")
     @id = result.first().fetch("id").to_i()
   end

   define_singleton_method(:find) do |id|
     @id = id
     result = DB.exec("SELECT * FROM cities WHERE id = #{@id};")
     @name = result.first().fetch('name')
     City.new({:name => @name, :id => @id})
   end

   define_method(:==) do |another_city|
     self.name().==(another_city.name()).&(self.id().==(another_city.id()))
   end

   define_method(:update) do |attributes|
     @name = attributes.fetch(:name, @name)
     DB.exec("UPDATE cities SET name = '#{@name}' WHERE id = #{self.id()};")
     attributes.fetch(:train_ids, []).each() do |train_id|
       DB.exec("INSERT INTO cities_trains(train_id, city_id) VALUES (#{train_id}, #{self.id()});")
     end
   end

   define_method(:trains) do
     city_trains =[]
     results = DB.exec("SELECT train_id FROM cities_trains WHERE city_id = #{self.id()};")
     results.each() do |result|
       train_id = result.fetch("train_id").to_i()
       train = DB.exec("SELECT * FROM trains WHERE id = #{train_id};")
       name = train.first().fetch('name')
       city_trains.push(Train.new({:name => name, :id => train_id}))
     end
     city_trains
   end

   define_method(:delete) do
     DB.exec("DELETE FROM cities WHERE id = #{self.id()};")
   end
 end
