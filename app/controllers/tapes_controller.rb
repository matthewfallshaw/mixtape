class TapesController < ApplicationController
  # GET /tapes
  # GET /tapes.xml
  def index
    @tapes = Tape.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tapes }
    end
  end

  # GET /tapes/1
  # GET /tapes/1.xml
  def show
    @tape = Tape.find(params[:id])
    if @tape.uncommitted_tapesters.include?(current_tapester)
      @track = Track.new(:tapester => current_tapester, :tape => @tape)
    end

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tape }
    end
  end
end
