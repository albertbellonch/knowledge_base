class CreateFactTags < ActiveRecord::Migration
  def self.up
    create_table :fact_tags do |t|
      t.integer :fact_id
      t.integer :tag_id

      t.timestamps
    end
  end

  def self.down
    drop_table :fact_tags
  end
end
