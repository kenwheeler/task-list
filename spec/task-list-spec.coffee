{WorkspaceView} = require 'atom'
TaskList = require '../lib/task-list'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "TaskList", ->
  activationPromise = null

  beforeEach ->
    atom.workspaceView = new WorkspaceView()
    atom.workspaceView.openSync("script.js")
    activationPromise = atom.packages.activatePackage('task-list')

  describe "when the task-list:toggle event is triggered", ->
    it "attaches and then detaches the view", ->
      expect(atom.workspaceView.find('.task-list')).not.toExist()

      # This is an activation event, triggering it will cause the package to be
      # activated.
      atom.workspaceView.trigger 'task-list:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(atom.workspaceView.find('.task-list')).toExist()
        atom.workspaceView.trigger 'task-list:toggle'
        expect(atom.workspaceView.find('.task-list')).not.toExist()
