# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

regions = ["Global", "APAC", "EMEA", "LATAM", "NA"]

folders = [{title:"culture", description:"Cultural Implications in Education Globally"}, {title:"industry", description:"Programmatic Emerging Market Trends"}, {title:"education", description:"Technology’s Role in Education’s Scale"}, {title:"talent", description:"The Future of Digital Talent"}]

Region.destroy_all
Folder.destroy_all

regions.each { |r| Region.create({name: r}) }
folders.each { |r| Folder.create({title: r[:title], description: r[:description]}) }