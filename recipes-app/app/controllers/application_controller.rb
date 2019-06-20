class ApplicationController < ActionController::Base
    before_action :check_cookie_expiry

    def check_cookie_expiry
        # puts session[:user_id]
        if session[:user_id] != nil
            # puts session[:expires_at]
            # puts Time.current
            if session[:expires_at] < Time.current
                session[:user_id] = nil
                # Make flash to let user know session expired
                # puts 'REDIRECTTIINNNNNNNNGGGGGG SESSION EXPIRED'
                redirect_to "/login"
            else
                # puts 'INCREASING SESSION TIME'
                session[:expires_at] = Time.current + 5.minutes
            end
        else
            # Flash message to let user know they have not logged in
            # puts 'YOUR NOT LOGGED IN! PLEASE LOG IN'
            redirect_to "/login"
        end
    end
end
