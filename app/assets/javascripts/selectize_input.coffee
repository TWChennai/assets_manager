setupSelectize = (container) ->
  defaults =
    plugins: ['remove_button']

  $(container).find('.selectize').each ->
    options = $(@).data('selectize')
    $(@).selectize $.extend(options, defaults)

$ ->
  $(document).on 'has_many_add:after', '.has_many_container', (e, fieldset) ->
    setupSelectize fieldset

  setupSelectize document.body
