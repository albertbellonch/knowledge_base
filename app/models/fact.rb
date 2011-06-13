class Fact < ActiveRecord::Base
  validates :title,  :presence => true
  validates_uniqueness_of :title
  validates :description, :presence => true,
                    :length => { :minimum => 5 }
  validates_presence_of :user

  has_many :fact_tags
  has_many :tags, :through => :fact_tags
  has_many :comments
  belongs_to :user

  before_save :calculate_title_url

  default_scope order("created_at DESC")

  # All posts for that tag (remember a tag name is unique)
  scope :for_tag, lambda {|tag_name| joins(:tags).where(:tags => {:name => tag_name}) }

  def to_s
    title
  end

  def to_param
    title_url
  end

  def calculate_title_url
    self.title_url = title.downcase.to_ascii.gsub(/[^[:alnum:]]/,'-')
  end

  # Sphinx
  define_index do
    # fields
    indexes title
    indexes title_url
    indexes description
    indexes user.name
    indexes user.email
    indexes tags.name

    # attributes
    has created_at
  end
end
