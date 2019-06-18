class UsersController < ApplicationController

    def create_account #DONT FORGET TO VALIDATE INPUTS
        new_user = User.new(user_params[:user])
        new_user.password_hash = new_user.hash_password(new_user.password_hash)
        new_user.save
        redirect_to "/index/#{new_user.id}"
    end

    def index
        @user = User.find(params[:id])
    end

    def authenticate
        user = User.find_by(username: user_params[:user][:username])
        if user != nil && user.authenticate(user_params[:user][:password_hash])
            session[:user_id] = user.id
            redirect_to "/index/#{user.id}"
        end
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