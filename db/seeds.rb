require 'faker'

puts "Seeding users and posts..."

5.times do
  begin
    user = User.create!(
      first_name: Faker::Name.first_name, # Dodano
      last_name: Faker::Name.last_name,   # Dodano
      email: Faker::Internet.unique.email,
      password: "password",
      password_confirmation: "password"
    )

    puts "Created user: #{user.first_name} #{user.last_name} (#{user.email})"

    20.times do
      begin
        post = user.posts.create!(
          title: Faker::Book.title,
          short_description: Faker::Lorem.sentence(word_count: 10),
          content: Faker::Lorem.paragraphs(number: 3).join("\n\n"),
          publication_date: Faker::Date.between(from: 2.years.ago, to: Date.today),
          public: [true, false].sample,
          published: [true, false].sample
        )
        puts " - Created post: #{post.title}"
      rescue ActiveRecord::RecordInvalid => e
        puts "Error creating post: #{e.record.errors.full_messages.join(", ")}"
      end
    end
  rescue ActiveRecord::RecordInvalid => e
    puts "Error creating user: #{e.record.errors.full_messages.join(", ")}"
  end
end

puts "Seeding completed!"
