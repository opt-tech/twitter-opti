require 'csv'
require 'nkf'

csv_data = CSV.generate(encoding: Encoding::SJIS, row_sep: "\r\n", force_quotes: true) do |csv|
  csv << %w(follower_id)
  @duplicate_followers.each do |duplicate_follower|
    row = []
    row << duplicate_follower.follower_id
    csv << row
  end
end


NKF::nkf('--sjis -Lw', csv_data)