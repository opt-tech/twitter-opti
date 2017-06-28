class CreateFollowers < ActiveRecord::Migration[5.0]
  def change
    create_table :followers do |t|
      t.string :handle_id
      t.string :follower_id

      t.timestamps
    end
  end
end
