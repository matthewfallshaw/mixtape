class TapestersController < ApplicationController
  before_filter :authenticate_tapester!, :except => [:index, :show]

  # GET /tapesters
  # GET /tapesters.xml
  def index
    @tapesters = Tapester.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tapesters }
    end
  end

  # GET /tapesters/1
  # GET /tapesters/1.xml
  def show
    @tapester = Tapester.find(params[:id])
    @tapester.tracks.populate
    @tapester.send(:generate_reset_password_token!) if @tapester.orphan?
    @tracks = @tapester.tracks

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tapester }
    end
  end
  
end
