class Container < ActiveRecord::Base
  attr_accessible :name
  belongs_to :sandwich

  validates :name, :presence => true

end
