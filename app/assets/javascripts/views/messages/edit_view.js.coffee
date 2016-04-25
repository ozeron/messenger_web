window.Views.Messages ||= {}

class Views.Messages.EditView extends Views.ApplicationView
  render: ->
    super()
    window.Widgets.Messages.ResetButton.enable('#btn-reset-picture', '#message_pic1')
    window.Widgets.Messages.ResetButton.enable('#btn-reset-file', '#message_doc1')

  cleanup: ->
    super()
    window.Widgets.Messages.ResetButton.cleanup('#btn-reset-picture', '#message_pic1')
    window.Widgets.Messages.ResetButton.cleanup('#btn-reset-file', '#message_doc1')
