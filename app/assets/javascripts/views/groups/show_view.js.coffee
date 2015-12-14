window.Views.Groups ||= {}

class Views.Groups.ShowView extends Views.ApplicationView
  render: ->
    super()
    $('table').DataTable({language: window.dataTableLocale(), order: [[ 0, "desc" ]]})

  cleanup: ->
    super()
    $('table').DataTable().destroy();
