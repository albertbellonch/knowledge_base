class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.string :name

      t.timestamps
    end

    add_column :facts, :category_id, :integer
    remove_column :facts, :category

    # Create default category and update facts
    c = Category.create! :name => "Uncategorized"
    Fact.all.each do |fact|
      fact.category = c
      fact.save
    end
  end

  def self.down
    add_column :facts, :category, :string
    remove_column :facts, :category_id

    drop_table :categories
  end
end
