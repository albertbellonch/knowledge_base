class Fact < ActiveRecord::Base
  validates :title,  :presence => true
  validates :description, :presence => true,
                    :length => { :minimum => 5 }
  has_many :fact_tags
  has_many :comments
  belongs_to :user
end
