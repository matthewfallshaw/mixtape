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
    @tracks = @tapester.tracks

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tapester }
    end
  end

  # PUT /tapesters/1
  # PUT /tapesters/1.xml
  def update
    @tapester = Tapester.find(params[:id])

    respond_to do |format|
      if @tapester.update_attributes(params[:tapester])
        format.html { redirect_to(@tapester, :notice => 'Tapester was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @track.errors, :status => :unprocessable_entity }
      end
    end
  end
  
end
