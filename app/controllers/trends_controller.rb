
class TrendsController < ApplicationController
  def index
    latest_two_created_at = Trend.pluck(:created_at).uniq.last(2)
    @trends = Trend.get_disp_trend(latest_two_created_at)
    @latest_created_at = latest_two_created_at.last.strftime("%Y年%m月%d日 %H時%M分")
    @hot_trends = Trend.where(region:'東京').group(:trend_word).order('count_trend_word desc').limit(50).count(:trend_word)
  end

  def history
    @history = Trend.get_history(params[:region])
    @region = params[:region]
  end

end
