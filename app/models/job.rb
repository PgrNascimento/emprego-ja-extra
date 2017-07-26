class Job < ApplicationRecord
  validates :title, :location, :description, :category, :user, presence: true
  belongs_to :company
  belongs_to :category
  belongs_to :user

  def expired?
    created_at <= 90.days.ago
  end

  def new?
    (created_at.to_date - 5.days.ago.to_date).to_i >= 0
  end
end
