class Category < ActiveRecord::Base
  has_many :recipes
  has_many :bakers, :through => :recipes
end
