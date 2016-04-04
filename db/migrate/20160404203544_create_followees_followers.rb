class CreateFolloweesFollowers < ActiveRecord::Migration
  def change
    create_table :followees_followers do |t|
      t.integer :followee_id
      t.integer :follower_id
    end

    add_index :followees_followers, [:followee_id, :follower_id]
  end
end
