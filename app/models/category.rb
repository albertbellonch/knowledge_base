class Category < ActiveRecord::Base
  has_many :facts
  has_many :user_categories
  has_many :users, :through => :users

  def to_s
    name
  end
end
