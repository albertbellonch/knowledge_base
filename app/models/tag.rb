class Tag < ActiveRecord::Base
  has_many :fact_tags, :dependent => :destroy
  has_many :facts, :through => :fact_tags

  validates_presence_of :name
end
