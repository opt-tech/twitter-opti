class CreateTemporaries < ActiveRecord::Migration[5.0]
  def change
    create_table :temporaries do |t|
      t.string :follower_id

      t.timestamps
    end
  end
end
