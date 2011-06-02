class Comment < ActiveRecord::Base
  belongs_to :fact
  belongs_to :user

  validates_presence_of :text
  validates_presence_of :fact
  validates_presence_of :user
end
