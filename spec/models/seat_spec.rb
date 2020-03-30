require 'rails_helper'

RSpec.describe Seat, type: :model do
  let(:seat) { build(:seat) }

  it 'is created correctly' do
    expect(seat).to_not be_nil
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
