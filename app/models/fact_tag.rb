class FactTag < ActiveRecord::Base
  belongs_to :fact
  belongs_to :tag
end
