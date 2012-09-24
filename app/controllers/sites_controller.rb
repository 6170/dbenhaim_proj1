require 'uri'

class SitesController < ApplicationController
  before_filter :get_user, :only => [:index,:new,:edit]
  def get_user
    @current_user = current_user
  end

  # GET /sites
  # GET /sites.json
  # phase 1 standard display of sites visited/# of visits
  def index
    get_user
    @sites = Site.find_by_user_id(@current_user.id)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sites }
    end
  end

  # GET /sites/1
  # GET /sites/1.json
  def show
    @site = Site.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @site }
    end
  end

  # GET /sites/new
  # GET /sites/new.json
  def new
    @site = Site.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @site }
    end
  end

  # GET /sites/1/edit
  def edit
    @site = Site.find(params[:id])
  end

  # POST /sites
  # POST /sites.json
  def create
    @site = Site.new(params[:site])

    respond_to do |format|
      if @site.save
        format.html { redirect_to @site, notice: 'Site was successfully created.' }
        format.json { render json: @site, status: :created, location: @site }
      else
        format.html { render action: "new" }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sites/1
  # PUT /sites/1.json
  def update
    @site = Site.find(params[:id])

    respond_to do |format|
      if @site.update_attributes(params[:site])
        format.html { redirect_to @site, notice: 'Site was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @site.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sites/1
  # DELETE /sites/1.json
  def destroy
    @site = Site.find(params[:id])
    @site.destroy

    respond_to do |format|
      format.html { redirect_to sites_url }
      format.json { head :no_content }
    end
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

  def check_geo(ip_address)
    require 'net/http'
    require 'json'

    url = URI.parse('http://freegeoip.net/json/'+ip_address)
    req = Net::HTTP::Get.new(url.path)
    res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
    }
    @output = JSON(res.body)
    @output
  end

  #phase 1 "visit" method
  # finds site by name in db (or creates it) and increments visited counter
  def visited
    set_cors_headers
    geo = check_geo(request.remote_ip)
    location = geo['city']+', '+geo['region_code']
    referer = URI(request.referer)
    @site = Site.find_by_name_and_user_id(referer.host, params[:id])
    if @site
      @visitor = Visitor.find_by_name_and_site_id(params[:visitor], @site.id)
      if !@visitor
        @visitor = Visitor.new(:site_id => @site.id, :name => params[:visitor])
        @visitor.save
      end
      @visit = Visit.new(:visitor_id => @visitor.id, :url => referer.path, :ip_address => request.remote_ip, :location => location, :event => params[:event], :data => params[:data])
      @visit.save
    else
      user_id = params[:id]
      @site = Site.new(:name => referer.host, :user_id => user_id)
      @site.save
      @visitor = Visitor.new(:site_id => @site.id, :name => params[:visitor])
      @visitor.save
      @visit = Visit.new(:visitor_id => @visitor.id, :url => referer.path,:ip_address => request.remote_ip, :location => location, :event => params[:event], :data => params[:data])
      @visit.save
    end
    render :text => "visit recorded", :content_type => "text/plain"
  end
end
