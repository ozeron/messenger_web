window.Views.MassMailings ||= {}

class Views.MassMailings.EditView extends Views.ApplicationView
  render: ->
    super()
    Widgets.MassMailings.DataTable.enable()

  cleanup: ->
    super()
    Widgets.MassMailings.DataTable.cleanup()
