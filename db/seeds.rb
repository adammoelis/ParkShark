ADDRESSES = [["11 Broadway", "New York", "NY", "10001"],
             ["200 West St.", "New York", "NY", "10282"],
             ["350 5th Ave", "New York", "NY", "10118"],
             ["4 Pennsylvania Plaza", "New York", "NY", "10001"],
             ["89 E 42nd St", "New York", "NY", "10017"],
             ["192 E Broadway", "New York", "NY", "10002"],
             ["1111 S Figueroa St", "Los Angeles", "CA", "90015"],
             ["444 N Rexford Dr", "Beverly Hills", "CA" "90210"],
             ["3700 Coldwater Canyon Ave", "Studio City", "CA", "91604"],
             ["563 N Alfred St", "West Hollywood", "CA", "90048"],
             ["1600 Pennsylvania Ave NW", "Washington", "DC" "20500"],
             ["620 Atlantic Ave", "Brooklyn", "NY", "11217"],
             ["3685 W Dublin Granville Rd", "Columbus", "OH", "43235"]
            ]

100.times do
  User.create(
    name: Faker::Name.name,
    avatar: Faker::Avatar.image,
    phone: Faker::PhoneNumber.cell_phone,
    bio: Faker::Lorem.paragraph(6),
    birthday: Faker::Date.between(20.years.ago, Date.today),
    email:Faker::Internet.email,
    password: Faker::Internet.password(8)
  )
end

200.times do
  address_array = ADDRESSES.sample
  spot = Spot.new.tap do |s|
    s.title = Faker::Name.title
    s.address = address_array[0]
    s.available = true
    s.city = address_array[1]
    s.state = address_array[2]
    s.description = Faker::Lorem.paragraph(6)
    s.zip_code = address_array[3]
    s.date = Faker::Date.between(2.days.ago, Date.today)
    s.owner_id = User.all.sample.id
    s.latitude = Faker::Address.latitude
    s.longitude = Faker::Address.longitude
    s.type_of_spot = Spot.types_of_spots.sample
    s.save
  end
  Picture.create(
    picture: File.open(Dir["public/images/seed/*"].sample),
    spot_id: spot.id
  )
end

200.times do
  Listing.create(
    beginning_time:Faker::Date.between(2.days.ago, Date.today),
    ending_time: Faker::Date.forward(23),
    beginning_time_of_day: Listing.time_of_day_options.sample,
    ending_time_of_day: Listing.time_of_day_options.sample,
    available: true,
    spot_id: Spot.all.sample.id,
    price: Faker::Commerce.price
  )
end

200.times do
  beginning_time = Faker::Date.between(Date.today, 2.days.from_now)
  beginning_time_of_day = Listing.time_of_day_options.sample
  Listing.create(
    beginning_time: beginning_time,
    beginning_time_of_day: beginning_time_of_day,
    ending_time: beginning_time,
    ending_time_of_day: beginning_time_of_day,
    available: true,
    spot_id: Spot.all.sample.id,
    price: Faker::Commerce.price
  )
end

200.times do
  Listing.create(
    beginning_time:Faker::Date.between(2.days.ago, Date.today),
    ending_time: Faker::Date.forward(23),
    beginning_time_of_day: Listing.time_of_day_options.sample,
    ending_time_of_day: Listing.time_of_day_options.sample,
    available: true,
    spot_id: Spot.all.sample.id,
    price: Faker::Commerce.price
  )
end

50.times do
  Car.create(
    make: Faker::Company.name,
    model: Faker::Company.name,
    color: Faker::Commerce.color,
    year: Faker::Number.number(4),
    license_plate: Faker::Internet.password(6),
    visitor_id: User.all.sample.id
  )
end

50.times do
  Location.create(
    latitude: Faker::Address.latitude,
    longitude: Faker::Address.longitude,
    address: Faker::Address.street_address
  )
end

200.times do
  spot = Spot.all.sample
  Review.create(
    rating: [0, 1, 2, 3, 4, 5].sample,
    body:Faker::Lorem.paragraph,
    spot_id: spot.id,
    visitor_id: User.all.sample.id
  )
end
