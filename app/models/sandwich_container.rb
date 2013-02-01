class SandwichContainer < ActiveRecord::Base
  belongs_to :sandwich
  belongs_to :container
end
