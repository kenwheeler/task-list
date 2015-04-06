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

    it "finds various forms of TODO", ->

      taskView = new TaskListView()
      taskView.attach()
      tasks = atom.workspaceView.find('.task-list ol.list-group .task-item')
      expect(tasks[0].innerText).toBe("Test Comment");
      expect(tasks[1].innerText).toBe("Test Comment 2");
      expect(tasks[2].innerText).toBe("Test Comment 3");
      expect(tasks[3].innerText).toBe("Test Comment 4");
      expect(tasks[4].innerText).toBe("Test Comment 5");
      expect(tasks[5].innerText).toBe("Test Comment 6");
      expect(tasks[6].innerText).toBe("Test Comment 7");
      expect(tasks[7].innerText).toBe("Test Comment 8");
      expect(tasks[8].innerText).toBe("Test Comment 9");
      expect(tasks[9].innerText).toBe("Test Comment 10");
      expect(tasks[10].innerText).toBe("Test Comment 11");
      expect(tasks[11].innerText).toBe("block comment");
      expect(tasks[12].innerText).toBe("task at end of line");
      expect(tasks[13].innerText).toBe("block comment line 1");
      expect(tasks[14].innerText).toBe("block comment line 2");

    it "displays No Tasks Found if there are no TODO comments", ->

      atom.workspaceView.getActivePaneItem().setText("")
      taskView = new TaskListView()
      taskView.attach()

      expect(
        atom.workspaceView.find(
          '.task-list ol.list-group li.selected'
        ).text()).toBe("No Tasks Found")
