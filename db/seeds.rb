# Some users
User.delete_all
u = User.create! :name => "Albert", :email => "albert@itnig.net", :password => "password"

# Some facts
Fact.delete_all
10.times.each do |i|
  Fact.create! :title => "Fact #{i}", :description => "Loremipsumital", :user => u
end
