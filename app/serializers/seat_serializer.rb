class SeatSerializer
  include FastJsonapi::ObjectSerializer

  attribute :id do |obj|
    obj.public_id
  end

  attribute :row

  attribute :row_char

  attribute :column

  attribute :status do |obj|
    obj.available? ? 'AVAILABLE' : 'NOT AVAILABLE'
  end
end
