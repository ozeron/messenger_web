window.Views.MassMailings ||= {}

class Views.MassMailings.ShowView extends Views.ApplicationView
  _options = {
    order: [[ 0, "desc" ]],

  }
  render: ->
    super()
    if $('#header').data('reload')
      window.setTimeout (()->
        document.location.reload(true)), 5000

  cleanup: ->
    super()
