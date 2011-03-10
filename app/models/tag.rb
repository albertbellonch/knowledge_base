class Tag < ActiveRecord::Base
  has_many :fact_tags
end
