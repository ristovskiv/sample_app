class UsersController < ApplicationController
  before_action :signed_in_user, only:[:index,:edit,:update,:destroy]
  before_action :correct_user, only:[:edit,:update]
  before_action :admin_user, only: [:destroy]
  before_action :for_not_signed_in_user, only:[:new,:create]

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
  	@user = User.find(params[:id])
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
      sign_in @user
  		flash[:success] = "Welcome to the Sample App!"
  		redirect_to @user # same as "/users/#{@user.id]" or user_path(@user) 
  	else
  		render "new"
  	end
  end

  def edit
    @user = User.find(params[:id]) #nema potreba da se izvrsuva bidejki correct_user ja sodrzi istata linija kod
                                    # a toj metod se izvrsuva i pred edit i pred update
  end

  def update
    @user = User.find(params[:id]) #istiot slucaj i so edit, nema potreba od ovaa linija kod
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
      else
        render "edit"
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted" 
    redirect_to users_path
  end

  	private
  		def user_params
  			params.require(:user).permit(:name,:email,:password,:password_confirmation)
  		end

      def signed_in_user
        unless signed_in?
          store_location
          redirect_to signin_path, notice: "Please sign in"
        end  
      end

      def correct_user
        @user = User.find(params[:id])
        redirect_to root_path unless current_user?(@user)
      end

      def admin_user
        redirect_to root_path unless current_user.admin?
      end

      def for_not_signed_in_user
          redirect_to root_path if signed_in?
      end
end
