window.Views.Groups ||= {}

class Views.Groups.ShowView extends Views.ApplicationView
  render: ->
    super()
    Widgets.Groups.DataTable.enable()

  cleanup: ->
    super()
    Widgets.MassMailings.DataTable.cleanup()
