class LinkUsersWithFactsAndComments < ActiveRecord::Migration
  def self.up
    add_column :facts, :user_id, :integer
    remove_column :facts, :email
    add_column :comments, :user_id, :integer
  end

  def self.down
    remove_column :comments, :user_id
    add_column :facts, :email, :string
    remove_column :facts, :user_id
  end
end
