class UsersController < ApplicationController

  before_action :authenticate_user!
  # before_action :ensure_correct_user, only: [:update]

  def create
    @book = Book.new(book)
   if @book.save
    flash[:success] = "successfully"
    redirect_to book_path(@book.id)

   else
    @books = Book.all
    render :index
   end

   @user.image = "no_image.jpg"
    if @user.save
        flash[:success] = "successfully"
        redirect_to user_path(@user.id)
    else
      flash.now[:danger] = "error"
      render :show
    end

  end


  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def index
    @users = User.all
    @books = Book.all
    @book = Book.new
    @user = current_user
  end

  def edit
    @user = User.find(params[:id])
    unless current_user.id == @user.id
        redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])

   if  @user.update(user_params)
   flash[:notice] ="successfully"
   redirect_to user_path(@user.id)

   else
   flash.now[:danger] = "error"
   render :edit

   end
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction)
  end

  # def ensure_correct_user
  #   @user = User.find(params[:id])
  #   unless @user == current_user
  #     redirect_to user_path(current_user)
  #   end
  # end
end