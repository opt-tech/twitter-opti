class FollowersController < ApplicationController


  def index
    @types = Type.all
    @followers = Follower.get_disp_handles
  end

  def create
    if params[:handle_id].blank?
      redirect_to followers_path, alert: 'ハンドルのIDを入力してください'
      return
    end
    @followers = Follower.get_followers(params[:handle_id], params[:type][:name])
    if @followers == 'Rate limit exceeded'
      redirect_to followers_path, alert: 'api制限にひっかかりました。15分ほど置いてから再度実行してください'
      return
    end
    redirect_to followers_path, notice: 'ハンドルを登録しました'
  end

  def destroy_handle
    Follower.destroy_all(handle_id: params[:handle_id])
    redirect_to followers_path, notice: 'ハンドルを削除しました'
  end

  def search
    @duplicate_follower_ids = Follower.get_duplicate_user(params[:type][:name], params[:number])
    Temporary.save_temporary(@duplicate_follower_ids)
    @user_count = @duplicate_follower_ids.count
  end

  def export_csv
    @duplicate_followers = Temporary.all
  end

end

