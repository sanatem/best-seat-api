require 'rails_helper'

RSpec.describe Venue, type: :model do
  let(:venue) { build(:venue) }

  it 'is created correctly' do
    expect(venue).to_not be_nil
  end

  context 'Failure cases' do
  end
end
