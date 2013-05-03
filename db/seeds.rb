# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

areas  = Area.create( { name: 'North America', code: 'north_america' } )
cities = City.create([{ name: 'New York', country_code: 'US' }, { name: 'Chicago', country_code: 'US' }])

