$ ->
  $('#banch-delete-pokemons').on('ajax:beforeSend', (e, xhr, settings) ->
    e.preventDefault()
    pokemonsElements = document.getElementsByName("pokemon_id[]")
    pokemonsArrayElements = []

    $.map pokemonsElements , (el) ->
      if $(el).is(':checked')
        pokemonsArrayElements.push $(el).val()
      return

    handleDeleteRequest(this.href, 'DELETE', {ids: pokemonsArrayElements})
  );

  $('#banch-fetchdata-offsite-pokemons').on('ajax:beforeSend', (e, xhr, settings) ->
    e.preventDefault()
    pokemonsElements = document.getElementsByName("pokemon_id[]")
    pokemonsArrayElements = []

    $.map pokemonsElements , (el) ->
      if $(el).is(':checked')
        pokemonsArrayElements.push $(el).val()
      return

    handleFetchDataRequest(this.href, 'GET', {ids: pokemonsArrayElements})
  );


handleDeleteRequest = (hrefRequest, typeRequest, dataParams) ->
  $.ajax
    url: hrefRequest
    data: dataParams
    cache: false
    type: 'DELETE'
    dataType: 'script'
    success: (response) ->
      table_tr_items = $('#list-pokemons').find('tr')
      $.map table_tr_items , (el) ->
        if (_.includes(dataParams.ids.map(Number), $(el).data('id')))
          $(el).hide()
    error: (xhr) ->
      console.log 'Errors!'
    complete: ->


handleFetchDataRequest = (hrefRequest, typeRequest, dataParams) ->
  $.ajax
    url: hrefRequest
    data: dataParams
    cache: false
    type: typeRequest
    dataType: 'script'
    success: (response) ->
      table_tr_items = $('#list-pokemons').find('tr')
#      $.map table_tr_items , (el) ->
#        if (_.includes(dataParams.ids.map(Number), $(el).data('id')))
#          $(el).hide()
    error: (xhr) ->
      console.log 'Errors!'
    complete: ->
