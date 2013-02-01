class Sandwich < ActiveRecord::Base
  # attr_accessible :title, :body
  has_one :containers
  has_many :ingredients
  belongs_to :order
end
