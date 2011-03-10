class ChangeDescriptionTypeToText < ActiveRecord::Migration
  def self.up
    change_column :facts,:description,:text
  end

  def self.down
    change_column :facts,:description,:string
  end
end
