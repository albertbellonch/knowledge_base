class RemoveEmailFromComment < ActiveRecord::Migration
  def self.up
    remove_column :comments, :email
  end

  def self.down
    add_column :comments, :email, :string
  end
end
