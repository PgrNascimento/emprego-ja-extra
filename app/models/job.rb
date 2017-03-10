class Job < ApplicationRecord
  validates :title, :location, :description, :category, presence: true
  belongs_to :company
  belongs_to :category

  def expired?
    self.created_at <= -90.days.from_now
  end
end
