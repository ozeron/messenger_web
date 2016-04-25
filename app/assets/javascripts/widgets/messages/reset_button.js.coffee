window.Widgets.Messages ||= {}

class window.Widgets.Messages.ResetButton extends window.Widgets.Base
  @enable: (source_button, target_input)->
    $(source_button).on 'click', (e) ->
      e.preventDefault()
      $el = $(target_input).val('')
      # $el.wrap('<form>').closest('form').get(0).reset()
      # $el.unwrap()
      return
    true
   @cleanup: (source_button)->
     $(source_button).unbind('click')
