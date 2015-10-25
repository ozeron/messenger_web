


window.url = (method, parameters=false, access_token = false) ->
  url = "https://api.vk.com/method/#{method}"
  if parameters
    url = "#{url}?#{$.param(parameters)}"
  if access_token
    url = "#{url}&access_token=#{access_token}"
  url
