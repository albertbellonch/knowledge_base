class Category < ActiveRecord::Base
  has_many :facts
end
