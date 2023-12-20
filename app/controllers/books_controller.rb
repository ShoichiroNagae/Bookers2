class BooksController < ApplicationController
  def new
    @books = Book.new
  end

  # 以下を追加
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      @user = current_user
      render :index
    end
  end

  def index
    @user = current_user
    @books = Book.all
    @book = Book.new
  end

  def show
    @tmp = Book.find(params[:id])
    @user = @tmp.user
    @book = Book.new
    @book_comment = BookComment.new
  end

  def edit
    @book = Book.find(params[:id])
    # 他人の投稿を編集しようとしたらリダイレクト
    if @book.user == current_user
    else
      redirect_to books_path
    end
  end

  def update
    # URLから取得されたIDを使用してbookモデルを取得
    @book = Book.find(params[:id])

    # ユーザーの情報を更新
    if @book.update(book_params)
      # 更新が成功した場合
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book)
    else
      # 更新が失敗した場合、編集画面に戻る
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])  # データ（レコード）を1件取得
    book.destroy  # データ（レコード）を削除
    redirect_to '/books'  # 投稿一覧画面へリダイレクト
  end

  private

  # ストロングパラメータ
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
