# Your init script
#
# Atom will evaluate this file each time a new window is opened. It is run
# after packages are loaded/activated and after the previous editor state
# has been restored.
#
# An example hack to log to the console when each text editor is saved.
#
# atom.workspace.observeTextEditors (editor) ->
#   editor.onDidSave ->
#     console.log "Saved! #{editor.getPath()}"

atom.commands.add 'atom-workspace', 'custom:refresh-git-status', ->
    atom.project.repositories.forEach (repo) ->
      repo.refreshStatus()

atom.commands.add 'atom-workspace', 'custom:collapse-tree', ->
    document.querySelectorAll('.directory.project-root.expanded').forEach (e) ->
      e.click()

atom.commands.add 'atom-workspace', 'custom:expand-tree', ->
    document.querySelectorAll('.directory.project-root.collapsed').forEach (e) ->
      e.click()

# sort tree view
arrayEqual = (a, b) ->
  a.length is b.length and a.every (elem, i) -> elem is b[i]

sortPaths = (projectPaths) ->
    paths = atom.project.getPaths()
    paths.sort()
    if not arrayEqual(paths, projectPaths)
        atom.project.setPaths(paths)

sortPaths([])

atom.project.onDidChangePaths(sortPaths)
