class HomeController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:index]
  skip_before_action :redirect_to_subdomain
  before_action :redirect_to_app_url

  def index
  end
end
