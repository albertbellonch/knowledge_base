class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :category_ids

  has_many :facts
  has_many :comments
  has_many :authentications
  has_many :user_categories
  has_many :categories, :through => :user_categories

  validates_presence_of :name
  validates_uniqueness_of :name

  after_create :assign_all_categories
  after_save :set_facts_delta_flag

  def apply_omniauth(omniauth)
    self.name = omniauth['user_info']['name'] if name.blank?
    self.email = omniauth['user_info']['email'] if email.blank?
    authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
  end

  def password_required?
    (authentications.empty? || !password.blank?) && super
  end

  def to_s
    name
  end

  private

  def assign_all_categories
    Category.all.each do |category|
      UserCategory.create! :user => self, :category => category
    end
  end

  def set_facts_delta_flag
    if name_changed? || email_changed?
      facts.each do |fact|
        fact.delta = true
        fact.save
      end
    end
  end
end
