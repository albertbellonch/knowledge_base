class Fact < ActiveRecord::Base
  validates :title,  :presence => true
  validates :description, :presence => true,
                    :length => { :minimum => 5 }
  validates_presence_of :user

  has_many :fact_tags
  has_many :tags, :through => :fact_tags
  has_many :comments
  belongs_to :user

  default_scope order("created_at DESC")

  # All posts for that tag (remember a tag name is unique)
  scope :for_tag, lambda {|tag_name| joins(:tags).where(:tags => {:name => tag_name}) }

  def to_s
    title
  end
end
