class Wish < ActiveRecord::Base
  belongs_to :user
  attr_accessible :name, :position
end
