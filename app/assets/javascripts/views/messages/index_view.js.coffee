window.Views.Messages ||= {}

class Views.Messages.IndexView extends Views.ApplicationView

  render: ->
    super()
    Widgets.Nodes.DataTable.enable()
  cleanup: ->
    super()
    Widgets.Nodes.DataTable.cleanup()
