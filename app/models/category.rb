class Category < ApplicationRecord
  validates :name, presence: true
  has_many :jobs
  belongs_to :user
end
