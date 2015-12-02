window.Widgets.Nodes ||= {}

class window.Widgets.Nodes.IndexDataTable extends window.Widgets.Base
  table = '.table'
  dataTable = undefined;

  _options = () ->
    {
      order: [[ 0, "desc" ]],
      language: window.dataTableLocale(),
      columnDefs: [
        # { "targets": 3, "orderable": false },
        # { "targets": 4, "orderable": false },
        # { "targets": 5, "orderable": false }
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
