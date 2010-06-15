class TracksController < ApplicationController
  before_filter :authenticate_tapester!

  # GET /tracks
  # GET /tracks.xml
  def index
    @tracks = Track.where(:tapester_id => current_tapester.id).all
    @other_tracks_count = Track.count - @tracks.size

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tracks }
    end
  end

  # GET /tracks/1
  # GET /tracks/1.xml
  def show
    @track = Track.find(params[:id])

    redirect_to tracks_path and return unless at_home?

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @track }
    end
  end

  # POST /tracks
  # POST /tracks.xml
  def create
    @track = Track.new(params[:track])

    redirect_to tracks_path and return unless at_home?

    respond_to do |format|
      if @track.save
        format.html { redirect_to(current_tapester, :notice => 'Track was successfully created.') }
        format.xml  { render :xml => @track, :status => :created, :location => @track }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @track.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tracks/1
  # PUT /tracks/1.xml
  def update
    @track = Track.find(params[:id])

    redirect_to tracks_path and return unless at_home?

    respond_to do |format|
      if @track.update_attributes(params[:track])
        format.html { redirect_to(current_tapester, :notice => 'Track was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @track.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tracks/1
  # DELETE /tracks/1.xml
  def destroy
    @track = Track.find(params[:id])

    redirect_to tracks_path and return unless at_home?

    @track.destroy

    respond_to do |format|
      format.html { redirect_to(tracks_url) }
      format.xml  { head :ok }
    end
  end

  protected

  def at_home?
    current_tapester == @track.tapester
  end
end
