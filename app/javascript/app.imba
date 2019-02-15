const axios = require('axios')

let movies = []

tag Movie < li

  def self.create movie
    await axios.post('/movies', movie)

  def self.all
    await axios.get('/movies')
  
  def update movie
    axios.put("/movies/{data:id}", movie).then do |res|
      console.log res:statusText

  def delete
    axios.delete("/movies/{data:id}").then do |res|
      console.log res:statusText
      trigger('moviedelete', data)

  def complete
    data:seen = !data:seen
    update data
    
  def render
    <self.seen=(data:seen) data-position=data:position style='display: flex; justify-content: space-between'> 
      <span.title :tap.complete> data:title
      <span.delete :tap.delete>
        <i.fas.fa-times css:color='darkred'>

tag App

  def setup
    let response = await Movie.all
    movies = response:data
    Imba.commit
  
  def onsubmit e
    e.prevent
    let params = { title: @field.value, year: 2000, seen: false }
    let response = await Movie.create(params)
    movies.push(response:data)
    @field.value = ""

  def onmoviedelete e
    movies = movies.filter do |movie| movie:id != e.data:id
    
  def render
    <self>
      <form.header>
        <input@field type='text' placeholder="What to do...">
        <button type='submit'> "Add"
      <ul.grow> for movie in movies
        <Movie id="movie-{movie:id}" data=movie>

Imba.mount(<App>)
