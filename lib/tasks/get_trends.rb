namespace :get_trends do
  namespace :get_trends do
    task :get_trends => :environment do
      Trend.get
    end
  end
end
