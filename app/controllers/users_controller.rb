class UsersController < ApplicationController

  # ログインしていない状態でアクセスされた場合は、ログイン画面へリダイレクト
  before_action :authenticate_user!, only: [:show]
  before_action :correct_user, only: [:edit, :update]


  def show
  	@user = User.find(params[:id])
  	@fire_engines = @user.fire_engines.page(params[:page]).reverse_order
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "successfully created."
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end


  private
  def user_params
    params.require(:user).permit(:name, :profile_image)
  end

# ログインしていない場合にユーザー関連のURLにアクセスできず、ログイン画面に飛ばす
   def correct_user
    user = User.find(params[:id])
     if current_user != user
      redirect_to new_user_session_path
     end
  end
end
