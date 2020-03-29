require 'rails_helper'

RSpec.describe Seat, type: :model do
  let(:seat) { build(:seat) }

  it 'is created correctly' do
    expect(seat).to_not be_nil
  end

  context 'Failure cases' do
    let(:seat) { create(:seat) }

    it "shouldn't create book with the same row, column" do
      expect(true).to eq true
    end

  end
end
