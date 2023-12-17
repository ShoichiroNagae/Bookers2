class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @book = Book.new
    @tmp = Book.all
  end

  def edit
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user.id)
    end
    # URLから取得されたIDを使用してUserモデルを取得
    @user = User.find(params[:id])
  end

  # フレンド一覧機能
  def index
    @users = User.all
    @user = current_user
    @book = Book.new
  end

  def update
    # URLから取得されたIDを使用してUserモデルを取得
    @user = User.find(params[:id])

    # ユーザーの情報を更新
    if @user.update(user_params)
      # 更新が成功した場合
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user)
    else
      # 更新が失敗した場合、編集画面に戻る
      
      render :edit
    end
  end


  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

end
