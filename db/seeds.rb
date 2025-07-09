owner_email = ENV.fetch('OWNER_EMAIL')
unless User.exists?(email: owner_email)
  user = User.create!(
    first_name: "Mkhanyiseli",
    last_name: "Landu",
    email: owner_email,
    password: ENV.fetch('OWNER_PASSWORD'),
    password_confirmation: ENV.fetch('OWNER_PASSWORD'),
    role: :owner
  )
  puts "#{user.first_name} #{user.last_name} created as the #{user.role}"
end

Category.create!(name: "Men") unless Category.exists?(name: "Men")
Category.create!(name: "Tops", parent: Category.find_by(name: "Men")) unless Category.exists?(name: "Tops")
