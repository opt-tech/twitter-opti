class TypesController < ApplicationController

  def create

    type = Type.new(name:params[:name])
    if type.save
      @types = Type.all
    else
      redirect_to followers_path, alert: '属性を入力してください'
    end
  end

  def destroy
    Type.destroy(params[:id])
    redirect_to followers_path, notice: '属性を削除しました'
  end
end
