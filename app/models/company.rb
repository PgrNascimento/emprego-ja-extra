class Company < ApplicationRecord
  validates :name, :mail, :location, :phone, presence: true
  has_many :jobs
  belongs_to :user

  def premium?
    jobs.count >= 5
  end
end
