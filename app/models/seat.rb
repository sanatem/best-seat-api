class Seat < ApplicationRecord
  belongs_to :venue

  validates :row, uniqueness: { scope: [:column, :venue] }

  ALPH = ('a'..'z').to_a

  def row_char
    ALPH[row - 1]
  end

  def public_id
    "#{row_char}#{column}"
  end

  def select!
    self.available = false
    save!
  end

  def release!
    self.available = true
    save!
  end

  def self.find_row(row)
    Seat::ALPH.find_index { |char| char == row } + 1
  end
end
