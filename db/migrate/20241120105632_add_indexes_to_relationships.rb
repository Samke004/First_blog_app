class AddIndexesToRelationships < ActiveRecord::Migration[7.2]
  def change
    add_index :relationships, :follower_id
    add_index :relationships, :followed_id
  end
end
