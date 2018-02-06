{ CompositeDisposable } = require 'atom'
path = require 'path'

module.exports = Journal =

  config:
    journalFile:
      title: 'Journal File'
      description: 'What file should be used as the journal in each project?'
      type: 'string'
      default: 'JOURNAL.md'

  activate: (state) ->
    @disposables = new CompositeDisposable

    # Register command makes a new journal entry
    @disposables.add atom.commands.add 'atom-workspace',
      'majournal:newEntry': => @newEntry()

  deactivate: ->
    @disposables.dispose()

  getJournalPath: ->
    try
      currentFilePath = atom.workspace.getActivePaneItem().getPath()
      projectRootPath = ''

      # Go through all project root directories to find the correct one
      atom.project.getDirectories().forEach (dir) ->
        if dir.contains(currentFilePath)
          projectRootPath = dir.path

      journalFile = atom.config.get('majournal.journalFile')
      journalPath = path.join projectRootPath, journalFile
      journalPath
    catch e
      console.error('Failed to get the path for the journal', e)
      null

  newEntry: ->
    try
      # Get journal path
      journalPath = @getJournalPath()

      if journalPath == null
        atom.notifications.addError 'Failed to get the journal path',
          detail: 'Try opening another file and running the command again.\nCheck the console for more details.'
        return

      # See if there is a pane open for it already
      # (This will create the file if it doesn't exist)
      atom.workspace.open(journalPath, { searchAllPanes: true }).then (editor) ->
        lastRow = editor.getLastBufferRow()
        editor.setCursorBufferPosition([lastRow, 0])
        editor.moveToEndOfLine()

        # Insert newline only if there isn't already a newline at the end of the file
        if editor.lineTextForBufferRow(lastRow).trim().length > 0
          editor.insertNewline()

        editor.insertNewline()
        editor.insertText("**#{new Date().toLocaleString()}**: ")
        editor.insertNewline()
        editor.moveLeft()

    catch error
      atom.notifications.addError 'Failed to create a new journal entry',
        detail: error.message
        stack: error.stack
