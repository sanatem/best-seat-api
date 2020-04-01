require 'rails_helper'

describe 'Venues API', type: :request do
  it 'List all venues' do
    FactoryBot.create_list(:venue, 10)

    get '/api/v1/venues'

    expect(response.status).to eq 200

    # check to make sure the right amount of messages are returned
    expect(json['data'].length).to eq(10)
  end

  let(:venue) { create(:venue) }
  let(:seat) { create(:seat) }

  it 'Retrieves a specific Venue' do
    get "/api/v1/venues/#{venue.id}"

    expect(response.status).to eq 200
    expect(json['data']['id']).to eq(venue.id.to_s)
  end

  it 'Creates a new Venue' do
    body = { venue: { rows: venue.rows, columns: venue.columns } }
    post '/api/v1/venues/', params: body

    expect(response.status).to eq 200
    expect(json['data']['attributes']['rows']).to eq(venue.rows)
    expect(json['data']['attributes']['columns']).to eq(venue.columns)
  end

  it 'Imports a new Venue' do
    post '/api/v1/venues/import', params: { json: json_data(filename: 'valid_venue') }

    expect(response.status).to eq 200
    expect(json['data']['attributes']['rows']).to eq(10)
    expect(json['data']['attributes']['columns']).to eq(50)
  end

  let(:test_venue) { FactoryBot.create(:venue, rows: 2, columns: 2) }

  it 'Select a seat' do
    test_venue.create_seats(true)

    post "/api/v1/venues/#{test_venue.id}/select_seat", params: { row: 'a', column: 1 }

    expect(response.status).to eq 200
    expect(json['data']['attributes']['row']).to eq(1)
    expect(json['data']['attributes']['row_char']).to eq('a')
    expect(json['data']['attributes']['column']).to eq(1)
    expect(json['data']['attributes']['status']).to eq('NOT AVAILABLE')
  end

  it 'Returns the best seat' do
    test_venue.create_seats(true)

    get "/api/v1/venues/#{test_venue.id}/best_seat"

    expect(response.status).to eq 200
    expect(json['data']['attributes']['row']).to eq(1)
    expect(json['data']['attributes']['column']).to eq(1)
  end
end
