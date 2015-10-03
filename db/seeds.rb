drive_way_urls = [
  "http://www.stonepatiosva.com/wp-content/uploads/2013/03/Nice-Driveway-VA.jpg",
  "http://www.eliteconcreterestoration.com/blog/wp-content/uploads/concrete-driveway-resurface.jpg",
  "http://www.stonepatiosva.com/wp-content/uploads/2013/02/brick-patio-design-and-construction-process-traditional-brick-pavers-style-in-northern-va-with-gate-and-side-garden-plus-chair-and-brick-house.jpeg",
  "http://content.angieslist.com/2012/2/8/3196672d-d712-4cc0-8dae-156df809aba3.JPG",
  "http://www.tampaconcretestaining.com/wp-content/gallery/concrete-driveways/driveway-garage.jpg",
  "http://dings-n-things.com/wp-content/uploads/2013/07/driveway-oil-stain-removal-before.jpg",
  "http://www.premierpatiosmn.com/wp-content/uploads/2013/01/Driveway.jpg",
  "http://static.concretenetwork.com/photo-gallery/images/1200x625Exact/concrete-driveways_8/stamped-concrete-driveway-d-e-contreras-construction_61246.jpg",
  "http://oppconcretewichita.com/files/2013/06/Triple-Driveway-Approach.jpg",
  "http://content.angieslist.com/2010/2/16/c0c1cae9-a090-4bc8-a19a-ccbfcb9b71b2.jpg"
]

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
    picture_file_name: drive_way_urls.sample
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
