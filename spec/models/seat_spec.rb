require 'rails_helper'

RSpec.describe Seat, type: :model do
  describe 'Validations' do
    it { should validate_presence_of(:row) }
    it { should validate_presence_of(:column) }
    it { should validate_numericality_of(:row) }
    it { should validate_numericality_of(:column) }
  end

  context 'Success cases' do
    let(:seat) { build(:seat) }
    let(:venue) { create(:venue) }

    it 'is created correctly' do
      expect(seat).to_not be_nil
    end

    it 'should return the correct row-letter' do
      seat.row = 3
      expect(seat.row_char).to eq 'c'
    end

    it 'should return the correct Public ID' do
      seat.row = 3
      seat.column = 2
      expect(seat.public_id).to eq 'c2'
    end

    it 'should make the seat available' do
      seat.release!
      expect(seat.available?).to eq true
    end

    it 'should make the seat not available' do
      seat.select!
      expect(seat.available?).to eq false
    end

    it 'Should return the correct position of the row' do
      expect(Seat.find_row('f')).to eq 6
    end
  end

  context 'Failure cases' do
    let(:seat) { create(:seat) }
    let(:venue) { create(:venue) }

    it "shouldn't create a seat with the same row, column" do
      create(:seat, row: 1, column: 1, venue: venue)
      seat_error = build(:seat, row: 1, column: 1, venue: venue)
      seat_error.save
      expect(seat_error.errors).to_not be_empty
    end
  end
end
