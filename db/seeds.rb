require 'faker'

puts "Seeding admin user..."

admin_email = "admin@example.com"
unless Admin.exists?(email: admin_email)
  Admin.create!(
    first_name: "Admin",
    last_name: "User",
    email: admin_email,
    password: "password",
    password_confirmation: "password"
  )

  puts "Created admin user: #{admin_email}"
else
  puts "Admin user already exists: #{admin_email}"
end




puts "Seeding users and posts with images..."

5.times do
  begin
    # Create a user
    user = User.create!(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.unique.email,
      password: "password",
      password_confirmation: "password"
    )

    puts "Created user: #{user.first_name} #{user.last_name} (#{user.email})"

    # Create 20 posts for the user
    20.times do
      begin
        image_path = Rails.root.join('app/assets/images/placeholder.jpg')

        post = user.posts.create!(
          title: Faker::Book.title,
          short_description: Faker::Lorem.sentence(word_count: 10),
          content: Faker::Lorem.paragraphs(number: 3).join("\n\n"),
          publication_date: Faker::Date.between(from: 2.years.ago, to: Date.today),
          public: [true, false].sample,
          published: [true, false].sample,
          image: File.exist?(image_path) ? File.open(image_path) : nil
        )

        puts " - Created post with image: #{post.title}" if post.image.present?
        puts " - Created post without image: #{post.title}" if post.image.blank?
      rescue ActiveRecord::RecordInvalid => e
        puts "Error creating post: #{e.record.errors.full_messages.join(", ")}"
      end
    end
  rescue ActiveRecord::RecordInvalid => e
    puts "Error creating user: #{e.record.errors.full_messages.join(", ")}"
  end
end

puts "Seeding completed!"
require 'faker'

puts "Seeding users and posts with images..."

5.times do
  begin
    # Create a user
    user = User.create!(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.unique.email,
      password: "password",
      password_confirmation: "password"
    )

    puts "Created user: #{user.first_name} #{user.last_name} (#{user.email})"

    # Create 20 posts for the user
    20.times do
      begin
        image_path = Rails.root.join('app/assets/images/placeholder.jpg')

        post = user.posts.create!(
          title: Faker::Book.title,
          short_description: Faker::Lorem.sentence(word_count: 10),
          content: Faker::Lorem.paragraphs(number: 3).join("\n\n"),
          publication_date: Faker::Date.between(from: 2.years.ago, to: Date.today),
          public: [true, false].sample,
          published: [true, false].sample,
          image: File.exist?(image_path) ? File.open(image_path) : nil
        )

        puts " - Created post with image: #{post.title}" if post.image.present?
        puts " - Created post without image: #{post.title}" if post.image.blank?
      rescue ActiveRecord::RecordInvalid => e
        puts "Error creating post: #{e.record.errors.full_messages.join(", ")}"
      end
    end
  rescue ActiveRecord::RecordInvalid => e
    puts "Error creating user: #{e.record.errors.full_messages.join(", ")}"
  end
end

puts "Seeding completed!"
