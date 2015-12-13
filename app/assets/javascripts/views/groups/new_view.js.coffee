window.Views.Groups ||= {}

class Views.Groups.NewView extends Views.Groups.EditView
  render: ->
    super()
    Widgets.Groups.DataTable.enable()

  cleanup: ->
    super()
    Widgets.MassMailings.DataTable.cleanup()
