class UsersController < ApplicationController

    def create_account 
        new_user = User.new(user_params[:user])
        if new_user.valid?(:create_account)
            new_user.password_hash = new_user.hash_password(new_user.password_hash)
            new_user.save
            session[:user_id] = new_user.id
            redirect_to "/index/#{new_user.id}"
        else
            flash[:errors] = new_user.errors.messages
            redirect_to "/sign_up"
        end
    end

    def index
        @user = User.find(params[:id])
    end

    def login
        if(flash[:errors])
            @errors = flash[:errors]
        else
            @errors = {
                "login_errors" => []
            }
        end
    end

    def sign_up
        if(flash[:errors])
            @errors = flash[:errors]
        else
            @errors = {
                "username_length" => [],
                "username_digits" => [],
                "first_name_digits" => [],
                "last_name_digits" => [],
                "age" => [],
                "password_length" => [],
                "password_digits" => []
            }
        end
    end

    def authenticate
        user = User.find_by(username: user_params[:user][:username])
        if user != nil && user.authenticate(user_params[:user][:password_hash])
            session[:user_id] = user.id
            redirect_to "/index/#{user.id}"
        else
            user.errors.add(:login_errors, "Incorrect Username or Password. Please try again")
            flash[:errors] = user.errors.messages
            redirect_to "/login"
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