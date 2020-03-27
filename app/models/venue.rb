class Venue < ApplicationRecord
  has_many :seats

  def initialize(params = {})
    super

  end

end
