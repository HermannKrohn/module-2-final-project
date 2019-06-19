class ApplicationController < ActionController::Base
    before_action :check_cookie_expiry

    def check_cookie_expiry
        if session[:user_id] != nil
            if session[:expires_at] < Time.current
                session[:user_id] = nil
            else
                session[:expires_at] = Time.current + 5.minutes
            end
        end
    end
end
