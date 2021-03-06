require 'faraday'
require 'json'

class PlacesSearch

  def initialize(key, restaurant_name, location)
    @key = key
    @api_root = "https://maps.googleapis.com/maps/api/"
    @restaurant_name = restaurant_name
    @location = location
  end

  def neighborhoods
    {"Pearl Street, Boulder" => "1942 Broadway St, Boulder, CO 80302", "Highlands, Denver" => "2030 W. 30th Ave., Denver, CO 80211"}
  end

  def get_json_restaurant_data
    @restaurant_data ||= begin
      address = neighborhoods[@location]
      response = Faraday.get "#{@api_root}geocode/json?address=#{address}{&sensor=false&key=#{@key}"
      json_location_data = JSON.parse(response.body)["results"].first["geometry"]["location"]
      latitude = json_location_data["lat"]
      longitude = json_location_data["lng"]
      response = Faraday.get "#{@api_root}place/nearbysearch/json?location=#{latitude},#{longitude}&radius=1000&types=food&name=#{@restaurant_name}&sensor=false&key=#{@key}"
     # if you can call results on it, then there is something there, otherwise return false??

      JSON.parse(response.body)["results"].first
    end
  end

  def get_address
    get_json_restaurant_data["vicinity"]
  end

  def get_rating
    get_json_restaurant_data["rating"]
  end

  def get_photo
    photo_reference = get_json_restaurant_data["photos"].first["photo_reference"]
    response = Faraday.get "#{@api_root}place/photo?maxwidth=400&photoreference=#{photo_reference}&sensor=false&key=#{@key}"
    json_data = response.body
    match = json_data.scan /<A\sHREF.+">/
    match.first
  end

  def get_website
    place_reference = get_json_restaurant_data["reference"]
    response = Faraday.get "#{@api_root}place/details/json?reference=#{place_reference}&sensor=true&key=#{@key}"
    json_data = response.body
    @website = JSON.parse(json_data)["result"]["website"]
  end

  def get_name
    get_json_restaurant_data["name"]
  end

  def matches?
    if get_json_restaurant_data
      true
    else
      false
    end
  end

end