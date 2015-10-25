# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  modal_id = '#find-vk-group-modal'
  setFormInputs = (e)->
    $(e.target).closest(modal_id).modal('hide');
    data = e.data
    $("#node_vk_vk_id").val(data.id);
    $("#node_vk_name").val(data.name);
    $("#node_vk_description").val(data.description);

  form = '#new_node_vk'
  $('#node_form a[role=tab]').click  (e)->
    e.preventDefault()
    $(this).tab('show')
    fill_form_with_data(form, e.data)
  $(window).load ()->
    buildReactList([])
  cache = {};
  data = $("#list-items").data('param')
  buildReactList = (data)->
    # Improve stuff
    el = React.createElement Components.Search.Results, data: data, selectHandler: setFormInputs
    r = ReactDOM.render el, document.getElementById('list-items')
  typingTimer = false;
  doneTypingInterval = 500;
  seachInput = "#{modal_id} input#group_query"
  load_groups = (e)->
    term = $(seachInput).val()
    if term in cache
      buildReactList(cache[term]);
      return;
    $.getJSON "/vk_groups.json", {query: term}, ( data, status, xhr ) ->
      cache[term] = data
      buildReactList(cache[term])
      return

  $(seachInput).on 'input', (e)->
    clearTimeout(typingTimer);
    if $(seachInput).val()
        typingTimer = setTimeout(load_groups, doneTypingInterval);

  $('#search-form').submit (evt) ->
    evt.preventDefault();
    load_groups();
  console.log('binding')

  return
