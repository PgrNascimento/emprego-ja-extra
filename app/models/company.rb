class Company < ApplicationRecord
  validates :name, :mail, :location, :phone, presence: true
  has_many :jobs

  def premium?
    jobs.count >= 5
  end
end
