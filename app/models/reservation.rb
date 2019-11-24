class Reservation < ApplicationRecord
  validates :document, :email, :name, :reservation_date, presence: true
  validate :reservation_count
  belongs_to :movie

  def reservation_count
    current_reservation_count = Reservation.where(movie_id: movie_id, reservation_date: reservation_date).count

    if current_reservation_count >= 10
      errors.add(:base, "All reservations taken")
    end
  end
end
