# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
15.times do
  guest_attributes = {
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.unique.email
  }

  guest = Guest.create!(guest_attributes)
  reservation_attributes = {
    code: Faker::Alphanumeric.unique.alphanumeric(number: 11),
    description: Faker::Company.bs,
    end_date: '17-Oct-2024',
    host_currency: 'AUD',
    number_of_adults: 2,
    number_of_children: 0,
    number_of_guests: 2,
    number_of_infants: 0,
    number_of_nights: 7,
    payout_price: 10_000,
    security_price: 10_000,
    start_date: '10-Oct-2024',
    status: 'accepted',
    total_price: 20_000,
    guest_id: guest.id,
  }
  Reservation.create!(reservation_attributes)
end
