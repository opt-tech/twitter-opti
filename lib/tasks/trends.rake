namespace :trends do
  desc "get trend words"
  task :get_trends => :environment do
    begin
      Trend.get_trend
      Rails.logger.info("success get trends!!")
    rescue => e
      Rails.logger.error("fail get trends.#{e.message}")
    end
  end
end
