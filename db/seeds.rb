# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

movies = [
  {
    title: 'Star Wars',
    year: 1977,
    seen: false
  },
  {
    title: 'Mad Max',
    year: 1972,
    seen: true
  },
  {
    title: 'Solo',
    year: 2018,
    seen: false
  }
]

Movie.create movies
