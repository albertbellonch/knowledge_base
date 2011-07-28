class Category < ActiveRecord::Base
  has_many :facts

  def to_s
    name
  end
end
