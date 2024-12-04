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
        post = user.posts.create!(
          title: Faker::Book.title,
          short_description: Faker::Lorem.sentence(word_count: 10),
          content: Faker::Lorem.paragraphs(number: 3).join("\n\n"),
          publication_date: Faker::Date.between(from: 2.years.ago, to: Date.today),
          public: [true, false].sample,
          published: [true, false].sample
        )

        # Attach an image to the post
        image_path = Rails.root.join('app/assets/images/placeholder.jpg') # Path to a placeholder image in your app
        if File.exist?(image_path)
          post.image.attach(
            io: File.open(image_path),
            filename: 'placeholder.jpg',
            content_type: 'image/jpeg'
          )
          puts " - Created post with image: #{post.title}"
        else
          puts " - Created post without image (placeholder not found): #{post.title}"
        end
      rescue ActiveRecord::RecordInvalid => e
        puts "Error creating post: #{e.record.errors.full_messages.join(", ")}"
      end
    end
  rescue ActiveRecord::RecordInvalid => e
    puts "Error creating user: #{e.record.errors.full_messages.join(", ")}"
  end
end

puts "Seeding completed!"
