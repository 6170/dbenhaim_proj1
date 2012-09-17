class HomeController < ApplicationController
	before_filter :get_user, :only => [:index]
	before_filter :authenticate_user!
	def get_user
    	@current_user = current_user
  	end
	def index
	end
end
