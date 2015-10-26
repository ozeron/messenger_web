window.Views.Nodes ||= {}

class Views.Nodes.IndexView extends Views.ApplicationView
  render: ->
    super()
    Widgets.Nodes.DataTable.enable()
  cleanup: ->
    super()
    Widgets.Nodes.DataTable.cleanup()
