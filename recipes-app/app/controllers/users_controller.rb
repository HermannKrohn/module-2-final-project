class UsersController < ApplicationController

    def create_account #DONT FORGET TO VALIDATE INPUTS
        # byebug
        new_user = User.new(user_params[:user])
        new_user.password_hash = BCrypt::Password.create(new_user.password_hash)
        new_user.save
        redirect_to "/index/#{new_user.id}"
    end

    def index
        @user = User.find(params[:id])
    end

    def user_params
        params.permit(
            user: [
                :username,
                :first_name,
                :last_name,
                :age,
                :password_hash
            ]
        )
    end

end