class ApplicationController < ActionController::Base
    before_action :check_cookie_expiry

    def check_cookie_expiry
        if session[:user_id] != nil
            if session[:expires_at] < Time.current
                session[:user_id] = nil
                redirect_to "/login"
            else
                session[:expires_at] = Time.current + 5.minutes
            end
        else
            redirect_to "/login"
        end
    end
end
