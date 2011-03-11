class Comment < ActiveRecord::Base
  belongs_to :fact
  belongs_to :user
end
