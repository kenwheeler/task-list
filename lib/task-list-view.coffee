{SelectListView,$$} = require 'atom'

module.exports =

class TaskListView extends SelectListView
  initialize: ->
    super
    @addClass('overlay from-top task-list')
    return atom.workspaceView.command 'task-list:toggle', =>
      return @.toggle()

  attach: ->
    editor = atom.workspaceView.getActivePaneItem()
    ebuffer = editor.buffer
    matcher = /TODO: (.*)/g
    finder = /TODO: (.*)/
    todos = []
    if ebuffer.cachedText
      if ebuffer.cachedText.match(matcher)
        for match in ebuffer.cachedText.match(matcher)
          todos.push(finder.exec(match)[1])
          @setItems(todos)
      else
        @setItems(['No Tasks Found'])
    else
      @setItems(['No Tasks Found'])
    atom.workspaceView.append(this)
    @focusFilterEditor()
  viewForItem: (item) ->
    $$ ->
      @li =>
        @raw item
  confirmed: (item) ->
    editor = atom.workspaceView.getActivePaneItem()
    ebuffer = editor.buffer
    if item != "No Tasks Found"
      itemIndex = ebuffer.cachedText.indexOf(item)
      bufferP = ebuffer.positionForCharacterIndex(itemIndex)
      editor.setCursorBufferPosition(bufferP)
    this.cancel()

  toggle: ->
    if @.hasParent()
      @.cancel()
    else
      @.attach()
