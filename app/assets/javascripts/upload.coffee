readURL = (input) ->
  if input.files and input.files[0]
    $('#file').show()
    reader = new FileReader

    reader.onload = (e) ->
      $('#file').attr 'src', e.target.result
      return

    reader.readAsDataURL input.files[0]
    return


ready = ->
  $('#team_image').change ->
    readURL this
    return

  $('#result_image').change ->
    readURL this
    return

$(document).ready(ready)
$(document).on('page:load', ready)
