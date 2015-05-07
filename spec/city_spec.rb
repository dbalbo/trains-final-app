require('spec_helper')

describe (City) do

  describe("#name") do
    it("returns the city's name") do
      city = City.new({:name => "Portland", :id => nil})
      expect(city.name()).to(eq("Portland"))
    end
  end

  describe('#id') do
    it('returns the id')do
    city = City.new ({:name => "Portland", :id => 1})
    expect(city.id()).to(eq(1))
    end
  end

  describe(".all") do
    it("starts off empty") do
      expect(City.all()).to(eq([]))
    end
  end

  describe(".find") do
    it("returns a city by its id") do
      test_city = City.new({:name => "Portland", :id => nil})
      test_city.save()
      test_city2 = City.new({:name => "Seattle", :id => nil})
      test_city2.save()
      expect(City.find(test_city2.id())).to(eq(test_city2))
    end
  end

  describe('#==') do
    it('is the same city if it has the same name and id') do
      city = City.new({:name => "Portland", :id => nil })
      city2 = City.new ({:name => "Portland", :id => nil})
      expect(city).to(eq(city2))
    end
  end

  describe('#update') do
    it('lets you update cities in the database') do
      city = City.new({:name => 'Portland', :id => nil})
      city.save()
      city.update({:name => 'Seattle'})
      expect(city.name()).to(eq('Seattle'))
    end
  end

  describe("#delete") do
    it("lets you delete a city from the database") do
      city = City.new({:name => "Portland", :id => nil})
      city.save()
      city2 = City.new({:name => "Seattle", :id => nil})
      city2.save()
      city.delete()
      expect(City.all()).to(eq([city2]))
    end
  end

  describe("#trains") do
    it("returns all the trains that service a city") do
      city = City.new({:name => "Portland", :id => nil })
      city.save()
      blue = Train.new({:name => "Blue Line", :id => nil})
      blue.save()
      yellow = Train.new({:name => "Yellow Line", :id => nil})
      yellow.save()
      city.update({:train_ids => [blue.id(), yellow.id()]})
      expect(city.trains()).to(eq([blue, yellow]))
    end
  end


end
