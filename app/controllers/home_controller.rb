class HomeController < ApplicationController
  def index
    @tapes = Tape.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end
end
