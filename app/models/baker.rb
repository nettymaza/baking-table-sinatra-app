class Baker < ActiveRecord::Base
  has_secure_password
  has_many :recipes
  has_many :categories, through: :recipes

  validates :email, :username, presence: true
  validates :email, :username, uniqueness: true
end
