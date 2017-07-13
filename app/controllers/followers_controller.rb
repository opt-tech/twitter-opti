class FollowersController < ApplicationController
  def index
  end

  def create
    @followers = Follower.get_followers(params[:handle_id])
    @handle_id = @followers.first.handle_id
  end

  def export_csv
    @followers = Follower.get_followers(params[:handle_id])
  end


  # private
  #
  # def follower_param
  #   params.require(:follower).permit(:handle_id)
  # end
end

