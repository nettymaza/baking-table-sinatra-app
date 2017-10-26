class Recipe < ActiveRecord::Base
  belongs_to :baker
  belongs_to :category
end
