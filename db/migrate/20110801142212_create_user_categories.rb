class CreateUserCategories < ActiveRecord::Migration
  def self.up
    create_table :user_categories do |t|
      t.integer :user_id
      t.integer :category_id

      t.timestamps
    end

    # By default, bind all categories to every user
    User.all.each do |user|
      Category.all.each do |category|
        UserCategory.create! :user => user, :category => category
      end
    end
  end

  def self.down
    drop_table :user_categories
  end
end
