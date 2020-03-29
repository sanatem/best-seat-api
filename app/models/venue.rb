class Venue < ApplicationRecord
  has_many :seats

  MAX_ROW = 27

  def treshold(n_value = 2)
    (columns / n_value.to_f).ceil
  end

  def find_best_seat
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

  def create_seats
    (1..rows).each do |row|
      (1..columns).each do |col|
        seats << Seat.new(row: row, column: col, available: false)
      end
    end
  end
end
