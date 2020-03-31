puts 'Populating Venue with seats..'
venue = Venue.create(rows: 2, columns: 5)

puts 'Populating seats..'
venue.create_seats(true)
