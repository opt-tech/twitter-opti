class AddTypeIdToFollower < ActiveRecord::Migration[5.0]
  def change
    add_column :followers, :type_id, :integer
  end
end
