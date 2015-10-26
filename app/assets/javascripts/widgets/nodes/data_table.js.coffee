window.Widgets.Nodes ||= {}

class window.Widgets.Nodes.DataTable extends window.Widgets.Base
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

  @enable:  ->
    _renderDataTable()
    true
  @cleanup: ->
    _destroyDataTable()
    true
