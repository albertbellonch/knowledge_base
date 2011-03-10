class AddEmailToFacts < ActiveRecord::Migration
  def self.up
    add_column :facts, :email, :string
  end

  def self.down
    remove_column :facts, :email
  end
end
