class RestaurantsController < ApplicationController

  def index
    if params[:search]
       @restaurants = Restaurant.tagged_with(params[:option].keys).where(location: params[:homepage_location])
       return @restaurants
    else
      @restaurants = Restaurant.all
    end
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new
    @restaurant.name = params[:restaurant][:name]
    puts ">>>>>>>>>>>>>>>>>>>>>"
    p params[:option]
    if params[:option]
      @restaurant.dietary_option_list = params[:option].keys.join(", ")
    end
    @restaurant.location = params[:restaurant][:location]
    @restaurant.website = params[:restaurant][:website]
    if @restaurant.save
      redirect_to "/restaurants/#{@restaurant.id}"
    else
      render restaurants_new_path
    end
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    @restaurant.name = params[:restaurant][:name]
    @restaurant.location = params[:restaurant][:location]
    @restaurant.website = params[:restaurant][:website]
    @restaurant.dietary_option_list = params[:option].keys.join(", ")
    @restaurant.save
    redirect_to "/restaurants/#{@restaurant.id}"
  end

  def destroy
    Restaurant.find(params[:id]).destroy
    redirect_to "/restaurants"
  end

end