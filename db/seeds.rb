# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Restaurant.destroy_all

Restaurant.create(name: "Salt", location: "Pearl Street, Boulder", website: "http://saltboulderbistro.com/",
                  dietary_option_list: "gluten free, dairy free" )

Restaurant.create(name: "Shine", location: "Pearl Street, Boulder", website: "http://www.shineboulder.com/",
                  dietary_option_list: "gluten free, dairy free" )



Restaurant.create(name: "Linger", location: "Highlands, Denver", website: "http://lingerdenver.com/",
                  dietary_option_list: "gluten free, dairy free" )

Restaurant.create(name: "Root Down", location: "Highlands, Denver", website: "http://www.rootdowndenver.com/",
                  dietary_option_list: "gluten free, dairy free" )







