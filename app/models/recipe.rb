class Recipe < ActiveRecord::Base
  belongs_to :baker
  has_many :recipe_categories
  has_many :categories, :through => :recipe_categories
end
