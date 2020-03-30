class Venue < ApplicationRecord
  has_many :seats

  MAX_ROWS = 27

  # Validations
  validates :rows, :columns, presence: true
  validates :rows, numericality: { less_than_or_equal_to: MAX_ROWS, only_integer: true }
  validates :rows, :columns, numericality: { greater_than: 0, only_integer: true }

  def treshold(n_value = 2)
    (columns / n_value.to_f).ceil
  end

  def find_best_seat
    return false if available_seats.empty?

    # Closest row
    closest_row = available_seats.group_by(&:row).min[1]
    # Closest seat to treshold = Best seat
    closest_row.sort_by(&:column).min_by{ |x| (x.column - treshold).abs }
  end

  def available_seats
    seats.select(&:available)
  end

  def select_seat(seat)
    seat.select!
  end

  def create_seats(available = false)
    (1..rows).each do |row|
      (1..columns).each do |col|
        seats << Seat.new(row: row, column: col, available: available)
      end
    end
  end
end
