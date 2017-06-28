class CreateTrends < ActiveRecord::Migration[5.0]
  def change
    create_table :trends do |t|
      t.string :region
      t.string :trend_word

      t.timestamps
    end
  end
end
