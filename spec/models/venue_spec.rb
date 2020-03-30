require 'rails_helper'

RSpec.describe Venue, type: :model do
  let(:venue) { build(:venue) }

  describe 'Validations' do
    it { should validate_presence_of(:rows) }
    it { should validate_presence_of(:columns) }
    it { should validate_numericality_of(:rows) }
    it { should validate_numericality_of(:columns) }
  end

  context 'Success cases' do
    it 'is created correctly' do
      expect(venue).to_not be_nil
    end

    it 'should return the correct treshold' do
      venue.columns = 20
      expect(venue.treshold).to eq 10
    end

    it 'should find the best seat' do
      venue.rows = 10
      venue.columns = 12
      venue.create_seats(true)
      best_seat = venue.find_best_seat
      expect(best_seat.public_id).to eq 'a6'
      best_seat.select!
      new_best_seat = venue.find_best_seat
      expect(new_best_seat.public_id).to eq 'a5'
    end
  end

  context 'Failure cases' do
    it "shouldn't create a venue with more than MAX_ROWS" do
      venue = build(:venue, rows: 28, columns: 15)
      venue.save
      expect(venue.errors).to_not be_empty
    end
  end
end
