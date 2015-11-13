window.Widgets.Groups ||= {}

class window.Widgets.Groups.DataTable extends window.Widgets.Base
  table = '#mass_mailing_nodes'
  dataTable = undefined;
  rows_selected = []


  updateDataTableSelectAllCtrl = (dataTable) ->
    $table = dataTable.table().node()
    $chkbox_all = $('tbody input[type="checkbox"]', $table)
    $chkbox_checked = $('tbody input[type="checkbox"]:checked', $table)
    chkbox_select_all = $('thead input[name="select_all"]', $table).get(0)
    # If none of the checkboxes are checked
    if $chkbox_checked.length == 0
      chkbox_select_all.checked = false
      if 'indeterminate' of chkbox_select_all
        chkbox_select_all.indeterminate = false
      # If all of the checkboxes are checked
    else if $chkbox_checked.length == $chkbox_all.length
      chkbox_select_all.checked = true
      if 'indeterminate' of chkbox_select_all
        chkbox_select_all.indeterminate = false
      # If some of the checkboxes are checked
    else
      chkbox_select_all.checked = true
      if 'indeterminate' of chkbox_select_all
        chkbox_select_all.indeterminate = true
    return

  _initializeCheckboxes = (e) ->
    _.forEach rows_selected, (id)->
      _hiddenInputsAdd(id)
    return

  _checkBoxClickHandler = (e) ->
    $row = $(this).closest('tr')
    # Get row data
    data = dataTable.row($row).data()
    # Get row ID
    rowId = data[0]
    # Determine whether row ID is in the list of selected row IDs
    index = $.inArray(rowId, rows_selected)
    # If checkbox is checked and row ID is not in list of selected row IDs
    if @checked and index == -1
      rows_selected.push rowId
      _hiddenInputsAdd(rowId)
      # Otherwise, if checkbox is not checked and row ID is in list of selected row IDs
    else if !@checked and index != -1
      _hiddenInputsRemove(rowId)
      rows_selected.splice index, 1
    if @checked
      $row.addClass 'selected'
    else
      $row.removeClass 'selected'
    # Update state of "Select all" control
    updateDataTableSelectAllCtrl dataTable
    # Prevent click event from propagating to parent
    e.stopPropagation()
    return

  _rowClickHandler = (e)->
    $(this).parent().find('input[type="checkbox"]').trigger('click')

  _selectAllClickHandler = (e)->
    if @checked
      $("#{table} tbody input[type=\"checkbox\"]:not(:checked)").trigger 'click'
    else
      $("#{table} tbody input[type=\"checkbox\"]:checked").trigger 'click'
    # Prevent click event from propagating to parent
    e.stopPropagation()

  _tableDrawEventHandler = ()->
    updateDataTableSelectAllCtrl(dataTable);

  _new_lement = (id, key, value) ->
    "<input class='string required form-control' type='hidden' name='mass_mailing[mass_mailing_nodes_attributes][#{id}][#{key}]' id='mass_mailing_mass_mailing_nodes_attributes_#{id}_#{key}' value='#{value}' />"

  _hiddenInputsAdd = (id) ->
    if ($("#mass_mailing_mass_mailing_nodes_attributes_#{id}__destroy").length > 0)
      $("#mass_mailing_mass_mailing_nodes_attributes_#{id}__destroy").attr('value', 0)

    if !($("#mass_mailing_mass_mailing_nodes_attributes_#{id}_node_id").length > 0)
      $('.form-group.required.mass_mailing_nodes_node_id').append(_new_lement(id, 'node_id', id))
    return

  _hiddenInputsRemove = (id) ->
    if ($("#mass_mailing_mass_mailing_nodes_attributes_#{id}__destroy").length > 0)
      $("#mass_mailing_mass_mailing_nodes_attributes_#{id}__destroy").attr('value', 1)
    else if $("#mass_mailing_mass_mailing_nodes_attributes_#{id}_node_id").length > 0
      $("#mass_mailing_mass_mailing_nodes_attributes_#{id}_node_id").after(_new_lement(id, '_destroy', 1))
    else
      $('.form-group.required.mass_mailing_nodes_node_id').append(_new_lement(id, 'node_id', id))
      $('.form-group.required.mass_mailing_nodes_node_id').append(_new_lement(id, '_destroy', 1))
    return

  _options = () ->
    {
      pagingType: "full_numbers",
      order: [[ 0, "desc" ]],
      columnDefs: [
        { targets: 3, orderable: false, searchable: false }
      ]
    }

  _renderDataTable = ->
    if !dataTable
      dataTable = $(table).DataTable(_options());
      # columnDefs:
      #   [{ "targets": 3, "orderable": false },
      #   {
      #    'targets': 4,
      #    'searchable': false,
      #    'orderable': false,
      #    'className': 'dt-body-center',
      #    'render': ((data, type, full, meta) ->
      #       '<input type="checkbox">')
      #  }]
      # order: [[1, 'asc']],
      # drawCallback: _initializeCheckboxes,
      # rowCallback: (row, data, dataIndex) ->
      #   # Get row ID
      #   rowId = data[0]
      #   # If row ID is in the list of selected row IDs
      #   if $.inArray(rowId, rows_selected) != -1
      #     $(row).find('input[type="checkbox"]').prop 'checked', true
      #     $(row).addClass 'selected'
      #   return



  _renderDataTable = ->
    if !dataTable
      rows_selected = rows_selected.concat(JSON.parse($('#mass_mailing_nodes_ids').attr('data-ids')))
      $('#mass_mailing_nodes_ids').data('ids',[])
      dataTable = $(table).DataTable(_options());
      $("#{table} tbody").on 'click', 'input[type="checkbox"]', _checkBoxClickHandler
      $(table).on 'click', 'tbody td, thead th:first-child', _rowClickHandler
      $("#{table} thead input[name=\"select_all\"]").click(_selectAllClickHandler)
      dataTable.on('draw', _tableDrawEventHandler)
      _initializeCheckboxes()

      #$(table).closest('form').on('submit', _formSubmissionHandler)
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
