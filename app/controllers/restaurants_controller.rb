class RestaurantsController < ApplicationController

  def index
    if params[:search] && params[:option]
       @restaurants = Restaurant.tagged_with(params[:option].keys).where(location: params[:homepage_location])
    elsif params[:search]
      @restaurants = Restaurant.where(location: params[:homepage_location])
    else
      @restaurants = Restaurant.all
    end
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new
    @restaurant.name = params[:restaurant][:name].capitalize
    if params[:option]
      @restaurant.dietary_option_list = params[:option].keys.join(", ")
    end
    @restaurant.location = params[:restaurant][:location]
    @restaurant.website = params[:restaurant][:website]
    initial_time = Time.now
    if @restaurant.save
      end_time = Time.now
      puts "Time elapsed: #{end_time - initial_time}"
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
    if params[:option]
      @restaurant.dietary_option_list = params[:option].keys.join(", ")
    else
      @restaurant.dietary_option_list = ''
    end
    if @restaurant.save
      redirect_to "/restaurants/#{@restaurant.id}"
    else
      render :edit
    end
  end

  def destroy
    Restaurant.find(params[:id]).destroy
    redirect_to "/restaurants"
  end

end