class UserCategory < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

  validates_presence_of :user
  validates_presence_of :category
end
