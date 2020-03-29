class SeatSerializer
  include FastJsonapi::ObjectSerializer

  attribute :id do |obj|
    obj.public_id
  end

  attribute :row do |obj|
    obj.row_char
  end

  attribute :column

  attribute :status do |obj|
    obj.available? ? 'AVAILABLE' : 'NOT AVAILABLE'
  end
end
