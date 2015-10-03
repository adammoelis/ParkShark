10.times do
  User.create(
    name: Faker::Name.name,
    avatar_file_name: Faker::Avatar.image,
    phone: Faker::PhoneNumber.cell_phone,
    bio: Faker::Lorem.paragraph(6),
    birthday: Faker::Date.between(20.years.ago, Date.today),
    email:Faker::Internet.email,
    password: Faker::Internet.password(8)
  )
end

10.times do
  Spot.create(
    title: Faker::Name.title,
    address: Faker::Address.street_address,
    available: true,
    city: Faker::Address.city,
    state: Faker::Address.state,
    description: Faker::Lorem.paragraph(6),
    zip_code: Faker::Address.zip_code,
    date: Faker::Date.between(2.days.ago, Date.today),
    owner_id: User.all.sample.id,
    latitude: Faker::Address.latitude,
    longitude: Faker::Address.longitude,
  )
end

10.times do
  Car.create(
    make: Faker::Company.name,
    model: Faker::Company.name,
    color: Faker::Commerce.color,
    year: Faker::Number.number(4),
    license_plate: Faker::Internet.password(6),
    visitor_id: User.all.sample.id
  )
end

10.times do
  Review.create(
    rating: Faker::Number.number(1),
    body:Faker::Lorem.paragraph,
    spot_id: Spot.all.sample.id,
    visitor_id: User.all.sample.id,
    owner_id: User.all.sample.id
  )
end

10.times do
  Listing.create(
    beginning_time:Faker::Date.between(2.days.ago, Date.today),
    ending_time: Faker::Date.forward(23),
    available: true,
    spot_id: Spot.all.sample.id,
    price: Faker::Commerce.price
  )
end

10.times do
  Location.create(
    latitude: Faker::Address.latitude,
    longitude: Faker::Address.longitude,
    address: Faker::Address.street_address
  )
end
