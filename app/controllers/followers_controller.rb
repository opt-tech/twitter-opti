class FollowersController < ApplicationController
  def index
  end

  def create
    @followers = Follower.get_followers(params[:handle_id])
    @handle_id = @followers.first.handle_id
  end

  def export_csv
    respond_to do |format|
      format.html do
        @followers = @users.page params[:page]
      end
      format.csv do
        send_data render_to_string, filename: "users-#{Time.now.to_date.to_s}.csv", type: :csv
      end
    end
  end


  # private
  #
  # def follower_param
  #   params.require(:follower).permit(:handle_id)
  # end
end

