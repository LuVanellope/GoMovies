class Movie < ApplicationRecord

  validates :name, :description, :url_image, :begin_date, :end_date, presence: true
  validates :name, uniqueness: true
end
