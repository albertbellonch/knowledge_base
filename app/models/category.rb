class Category < ActiveRecord::Base
  has_many :facts
  has_many :user_categories
  has_many :users, :through => :users

  validates_presence_of :name
  validates_uniqueness_of :name

  def to_s
    name
  end
end
