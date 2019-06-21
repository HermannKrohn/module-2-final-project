class HomepageController < ApplicationController
    skip_before_action :check_cookie_expiry, only: [:index]
end