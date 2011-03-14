class Tag < ActiveRecord::Base
  has_many :fact_tags
  has_many :facts, :through => :fact_tags
end
