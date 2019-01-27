class Todo
  prop title
  prop done

  def initialize title
    @title = title
    @done  = no

tag App
  prop todos

  def addTodo
    @todos.push Todo.new(@title)
    @title = ''

  def render
    <self>
      <form.header :submit.prevent.addTodo>
        <input[@title] placeholder='Add...'>
        <button type='submit'> 'Add item'
      <ul> for todo in @todos
        <li> todo.title

Imba.mount <App.vbox todos=[]>, Imba.document:body
