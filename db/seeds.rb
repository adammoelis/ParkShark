10.times do
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

10.times do
  spot = Spot.new.tap do |s|
    s.title = Faker::Name.title
    s.address = Faker::Address.street_address
    s.available = true
    s.city = Faker::Address.city
    s.state = Faker::Address.state
    s.description = Faker::Lorem.paragraph(6)
    s.zip_code = Faker::Address.zip_code
    s.date = Faker::Date.between(2.days.ago, Date.today)
    s.owner_id = User.all.sample.id
    s.latitude = Faker::Address.latitude
    s.longitude = Faker::Address.longitude
    s.save
  end
  Picture.create(
    picture: File.open(Dir["public/images/seed/*"].sample),
    spot_id: spot.id
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
