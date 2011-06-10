class AddTitleUrlToFacts < ActiveRecord::Migration
  def self.up
    add_column :facts, :title_url, :string
    Fact.all.each do |fact|
      fact.title_url = fact.title.downcase.to_ascii.gsub(/[^[:alnum:]]/,'-')
      fact.save
    end
  end

  def self.down
    remove_column :facts, :title_url
  end
end
