class AddDeltaToFact < ActiveRecord::Migration
  def self.up
    add_column :facts, :delta, :boolean, :default => true, :null => false
  end

  def self.down
    remove_column :facts, :delta
  end
end
