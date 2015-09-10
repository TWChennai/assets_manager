setupSelectizeAutocomplete = (container) ->
  defaults =
    create: false
    searchField: 'name'
    valueField: 'id'
    labelField: 'name'
    searchField: 'name'
    plugins: ['remove_button']
    load: (query, callback) ->
      return callback unless query.length
      $.ajax
        url: this.settings.url
        type: 'get'
        data: { q: query }
        error: -> callback()
        success: (res) -> callback(res)

  $(container).find('.selectize-autocomplete').each ->
    options = $(@).data('selectize')
    $(@).selectize $.extend(options, defaults)

$ ->
  $(document).on 'has_many_add:after', '.has_many_container', (e, fieldset) ->
    setupSelectizeAutocomplete fieldset

  setupSelectizeAutocomplete document.body
