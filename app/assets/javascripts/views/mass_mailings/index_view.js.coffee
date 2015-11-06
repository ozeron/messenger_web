window.Views.MassMailings ||= {}

class Views.MassMailings.IndexView extends Views.ApplicationView
  _options = {
    order: [[ 0, "desc" ]]
  }
  render: ->
    super()
    $('.table').DataTable(_options)
