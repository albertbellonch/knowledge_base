class Fact < ActiveRecord::Base
  CATEGORIES = ["Enginyeria","Màrqueting","Disseny"]

  validates :title,  :presence => true
  validates_uniqueness_of :title
  validates :description, :presence => true,
                    :length => { :minimum => 5 }
  validates_presence_of :user
  validates_presence_of :category

  has_many :fact_tags
  has_many :tags, :through => :fact_tags
  has_many :comments
  belongs_to :user
  belongs_to :category

  before_save :calculate_title_url

  default_scope order("created_at DESC")

  # All facts for that tag (remember a tag name is unique)
  scope :for_tag, lambda {|tag_name| joins(:tags).where(:tags => {:name => tag_name}) }

  # All facts for that user name (remember a user name is also unique!)
  scope :for_user, lambda {|user_name| joins(:user).where(:users => {:name => user_name}) }

  # All facts filtered by one or more categories
  scope :for_category, lambda {|category_name| joins(:category).where(:categories => {:name => category_name}) }
  scope :for_categories, lambda {|categories| where(:category_id => categories) }

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
    indexes category.name

    # attributes
    has created_at

    # delta indexing
    set_property :delta => true
  end
end
