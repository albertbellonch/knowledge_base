# Utils
def random_text (min,max,type)
  n = min + rand(max-min+1)
  Lorem::Base.new(type,n).output
end

# Some users
puts "Adding Itnigers..."
User.delete_all
User.create! :name => "Albert", :email => "albert@itnig.net", :password => "password"
User.create! :name => "Roger", :email => "roger@itnig.net", :password => "password"
User.create! :name => "Bernat", :email => "bernat@itnig.net", :password => "password"
User.create! :name => "Sergi", :email => "sergi@itnig.net", :password => "password"
User.create! :name => "Dulce", :email => "dulce@itnig.net", :password => "password"
User.create! :name => "Dani", :email => "dani@itnig.net", :password => "password"

# Some tags
puts "Adding tags..."
Tag.delete_all
Tag.create! :name => "Technology"
Tag.create! :name => "Ruby"
Tag.create! :name => "Rails"
Tag.create! :name => "Design"
Tag.create! :name => "SEO"
Tag.create! :name => "Marketing"
Tag.create! :name => "Others"
Tag.create! :name => "Cucamonga"

# Some facts
puts "Adding facts and comments..."
Fact.delete_all
100.times.each_with_index do |f,i| # facts
  puts "  Creating fact #{i+1}..."
  f = Fact.create! :title => random_text(2,5,"words"), :description => random_text(2,5,"paragraphs"), :user => User.all.sample
  puts "    Linking to some tags..."
  f.tags << Tag.all.sample(1+rand(Tag.all.size))
  (rand(10)+1).times.each_with_index do |c,j| # from 1 to 10 random comments
    puts "    Creating comment #{j+1}..."
    Comment.create! :text => random_text(1,3,"paragraphs"), :user => User.all.sample, :fact => f
  end
end
