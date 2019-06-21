class UsersController < ApplicationController
    skip_before_action :check_cookie_expiry, only: [:create_account, :login, :sign_up, :authenticate]

    def create_account 
        new_user = User.new(user_params[:user])
        if new_user.valid?(:create_account)
            new_user.password_hash = new_user.hash_password(new_user.password_hash)
            new_user.save
            session[:user_id] = new_user.id
            session[:expires_at] = Time.current + 5.minutes
            redirect_to "/index/#{new_user.id}"
        else
            flash[:errors] = new_user.errors.messages
            redirect_to "/sign_up"
        end
    end

    def index
        @user = User.find(params[:id])
    end

    def search_other_user_page
        searched_user = User.find_by(username: user_params[:user][:username])
        redirect_to "/index/#{searched_user.id}"
    end

    def login
        if(flash[:errors])
            @errors = flash[:errors]
        else
            @errors = []
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
            session[:expires_at] = Time.current + 5.minutes
            redirect_to "/index/#{user.id}"
        else
            # user.errors.add(:login_errors, "Incorrect Username or Password. Please try again")
            flash[:errors] = ["Incorrect Username or Password. Please try again"]
            redirect_to "/login"
        end
    end

    def logout
        session[:user_id] = nil
        redirect_to "/login"
    end

    def refresh_session
        session[:expires_at] = Time.current + 5.minutes
        puts "Refreshing dat session"
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