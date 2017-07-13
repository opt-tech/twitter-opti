
CSV.generate do |csv|
  csv_column_names = %w(follower_id)
  csv << csv_column_names
  @followers.each do |follower|
    csv_column_values = [
      follower.follower_id
    ]
    csv << csv_column_values
  end
end