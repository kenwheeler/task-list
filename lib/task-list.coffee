TaskListView = require './task-list-view'

module.exports =
  taskListView: null

  activate: (state) ->
    return new TaskListView()
