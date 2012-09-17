class HomeController < ApplicationController
	before_filter :get_user, :only => [:index]
	before_filter :authenticate_user!
	def get_user
    	@current_user = current_user
  	end
	def index
	end
	def set_cors_headers
		headers["Access-Control-Allow-Origin"] = "*"
		headers["Access-Control-Allow-Methods"] = "POST, GET, OPTIONS"
		headers["Access-Control-Allow-Headers"] = "Content-Type, Origin, Referer, User-Agent"
		headers["Access-Control-Max-Age"] = "3600"
	end

	def resource_preflight
		set_cors_headers
		render :text => "", :content_type => "text/plain"
	end

	def resource
		set_cors_headers
		render :text => "OK here is your restricted resource!"
	end
end
