class PlacesController < ApplicationController

  def index
    @places = Place.all
  end

  def show
    @place = Place.find_by({ "id" => params["id"] })

    if @current_user != nil
      @entries = Entry.where({
        "place_id" => @place["id"],
        "user_id" => @current_user["id"]
      })
    else
      @entries = []
    end
  end

  def new
    if @current_user == nil
      redirect_to "/login"
      return
    end
  end

  def create
    if @current_user == nil
      redirect_to "/login"
      return
    end

    @place = Place.new
    @place["name"] = params["name"]
    @place.save

    redirect_to "/places"
  end

end