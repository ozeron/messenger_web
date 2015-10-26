window.Views.Nodes ||= {}

class Views.Nodes.IndexView extends Views.ApplicationView
  table = '#nodes'
  dataTable = undefined;

  _options = () ->
    {
      bProcessing: true,
      bServerSide: true,
      sAjaxSource: $(table).data('source'),
      columnDefs: [
        { "targets": 3, "orderable": false },
        { "targets": 4, "orderable": false },
        { "targets": 5, "orderable": false }
      ]
    }

  _renderDataTable = ->
    if !dataTable
      dataTable = $(table).DataTable(_options());
    true

  _destroyDataTable = ->
    if dataTable
      dataTable.destroy();
    dataTable = null
    true

  render: ->
    super()
    _renderDataTable()
  cleanup: ->
    super()
    _destroyDataTable()
