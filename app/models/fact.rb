class Fact < ActiveRecord::Base
  validates :title,  :presence => true
  validates :description, :presence => true,
                    :length => { :minimum => 5 }
  validates_presence_of :user

  has_many :fact_tags
  has_many :tags, :through => :fact_tags
  has_many :comments
  belongs_to :user
end
