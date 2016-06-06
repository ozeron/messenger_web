window.Views.MassMailings ||= {}

class Views.MassMailings.EditView extends Views.ApplicationView
  render: ->
    super()
    Widgets.MassMailings.DataTable.enable()
    array = JSON.parse($("#mass_mailing_nodes_ids").attr('data-ids'))
    _.forEach(array, (id) ->
      $("#node#{id} td:last-child input").click()
    );
    true


  cleanup: ->
    super()
    Widgets.MassMailings.DataTable.cleanup()
