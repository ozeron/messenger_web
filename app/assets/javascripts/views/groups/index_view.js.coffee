window.Views.Groups ||= {}

class Views.Groups.IndexView extends Views.ApplicationView
  render: ->
    super()
    $('table').DataTable({language: window.dataTableLocale(), order: [[ 0, "desc" ]]})

  cleanup: ->
    super()
    $('table').DataTable().destroy();
