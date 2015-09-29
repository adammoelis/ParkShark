
10.times do
  User.create(
    name: Faker::Name.name,
    image_url: Faker::Avatar.image,
    phone: Faker::PhoneNumber.cell_phone,
    email:Faker::Internet.email,
    password: Faker::Internet.password(8)
  )
end

10.times do
  Spot.create(
    title: Faker::Name.title,
    address: Faker::Address.street_address,
    available: true,
    price: Faker::Number.number(3),
    image_url: Faker::Avatar.image,
    owner_id: Faker::Number.number(1),
    city: Faker::Address.city,
    state: Faker::Address.state,
    zip_code: Faker::Address.zip_code,
    beginning_time: Faker::Date.between(2.days.ago, Date.today),
    ending_time: Faker::Date.forward(23)
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
  Message.create(
    body:Faker::Lorem.paragraph,
    author_id: User.all.sample.id,
    recipient_id: User.all.sample.id
  )
end

10.times do
  Review.create(
    rating: Faker::Number.number(1),
    body:Faker::Lorem.paragraph,
    spot_id: Spot.all.sample.id,
    visitor_id: User.all.sample.id
  )
end
