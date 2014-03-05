{WorkspaceView} = require 'atom'
TaskListView = require '../lib/task-list-view'

describe "TaskListView", ->

  beforeEach ->
    atom.workspaceView = new WorkspaceView()
    atom.workspaceView.openSync("script.js")

  describe "when the task-list:toggle event is triggered", ->

    it "parses TODO comments and adds them to the list", ->

      taskView = new TaskListView()
      taskView.attach()

      expect(
        atom.workspaceView.find(
          '.task-list ol.list-group li.selected .task-item'
        ).text()).toBe("Test Comment")

    it "displays No Tasks Found if there are not comments", ->

      atom.workspaceView.getActivePaneItem().setText("")
      taskView = new TaskListView()
      taskView.attach()

      expect(
        atom.workspaceView.find(
          '.task-list ol.list-group li.selected'
        ).text()).toBe("No Tasks Found")
