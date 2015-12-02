window.Views.MassMailings ||= {}

class Views.MassMailings.IndexView extends Views.ApplicationView
  _options = {
    order: [[ 0, "desc" ]],

  }
  render: ->
    super()
    Widgets.Nodes.IndexDataTable.enable()

  cleanup: ->
    super()
    Widgets.Nodes.IndexDataTable.cleanup()
