window.Views.Nodes ||= {}

class Views.Nodes.EditView extends Views.ApplicationView
  modal_id = '#find-vk-group-modal'
  form = '#new_node_vk'
  cache = {};
  typingTimer = false;
  doneTypingInterval = 500;
  seachInput = "#{modal_id} input#group_query"

  _renderTabLinks = (e)->
    e.preventDefault()
    $(this).tab('show')
    _fill_form_with_data(form, e.data)

  _setFormInputs = (e)->
    $(e.target).closest(modal_id).modal('hide');
    data = e.data
    $("#node_vk_vk_id").val(data.id);
    $("#node_vk_name").val(data.name);
    $("#node_vk_description").val(data.description);
  _buildReactList = (data)->
    # Improve stuff
    el = React.createElement Components.Search.Results,
                             data: data,
                             selectHandler: _setFormInputs
    r = ReactDOM.render el, document.getElementById('list-items')
  _load_groups = (e)->
    term = $(seachInput).val()
    if term in cache
      _buildReactList(cache[term]);
      return;
    $.getJSON "/vk_groups.json", {query: term}, ( data, status, xhr ) ->
      cache[term] = data
      _buildReactList(cache[term])
      return

  render: ->
    super()
    _buildReactList([])
    $('#node_form a[role=tab]').click _renderTabLinks
    $('#search-form').submit (evt) ->
      evt.preventDefault();
      _load_groups();
    $(seachInput).on 'input', (e)->
      clearTimeout(typingTimer);
      if $(seachInput).val()
          typingTimer = setTimeout(_load_groups, doneTypingInterval);

  cleanup: ->
    super()
