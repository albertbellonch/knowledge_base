class AddCategoryToFacts < ActiveRecord::Migration
  def self.up
    add_column :facts, :category, :string
    Fact.all.each do |fact|
      fact.category = Fact::CATEGORIES.first
      fact.save
    end
  end

  def self.down
    remove_column :facts, :category
  end
end
