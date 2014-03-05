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
    if editor
      ebuffer = editor.buffer
      if ebuffer
        matcher = /TODO: (.*)|FIXME: (.*)/g
        todoFinder = /TODO: (.*)/
        fixmeFinder = /FIXME: (.*)/
        todos = []
        if ebuffer.cachedText
          if ebuffer.cachedText.match(matcher)
            for match in ebuffer.cachedText.match(matcher)
              if todoFinder.exec(match)
                todos.push({message: todoFinder.exec(match)[1], type: 'TODO'})
              else
                todos.push({message: fixmeFinder.exec(match)[1], type: 'FIXME'})
            @setItems(todos)
          else
            @setItems([{message: 'No Tasks Found' , type: ''}])
        else
          @setItems([{message: 'No Tasks Found' , type: ''}])
        atom.workspaceView.append(this)
        @focusFilterEditor()
  viewForItem: (item) ->
    if item.type == 'TODO'
      markerClass = 'task-status status text-success'
    else if item.type == 'FIXME'
      markerClass = 'task-status status text-error'
    else
      markerClass = 'task-status status text-error'
    $$ ->
      @li =>
        @div class: 'pull-right', =>
          @div class: markerClass , item.type
        @div class: 'task-item', item.message
  confirmed: (item) ->
    editor = atom.workspaceView.getActivePaneItem()
    ebuffer = editor.buffer
    if item != "No Tasks Found"
      itemIndex = ebuffer.cachedText.indexOf(item.message)
      bufferP = ebuffer.positionForCharacterIndex(itemIndex)
      editor.setCursorBufferPosition(bufferP)
    this.cancel()

  toggle: ->
    if @.hasParent()
      @.cancel()
    else
      @.attach()
