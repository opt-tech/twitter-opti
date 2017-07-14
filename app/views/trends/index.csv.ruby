require 'csv'
require 'nkf'

CSV.generate(encoding: Encoding::SJIS, row_sep: "\r\n", force_quotes: true) do |csv|
  csv_column_names = %w(トレンドワード ボリューム)
  csv << csv_column_names
  @hot_trends.each do |key,value|
    csv_column_values = [
      key.encode("Shift_JIS"),
      value
    ]
    csv << csv_column_values
  end
end


