class CreatePosts < ActiveRecord::Migration[7.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :short_description
      t.text :content
      t.date :publication_date
      t.boolean :public
      t.boolean :published
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
