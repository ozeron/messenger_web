# This is a manifest file that'll be compiled into application.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
#
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# compiled file.
#
# Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
# about supported directives.
#
#= require jquery
#= require jquery-ui
#= require jquery_ujs
#= require twitter/bootstrap
#= require dataTables/jquery.dataTables
#= require dataTables/bootstrap/3/jquery.dataTables.bootstrap
#= require turbolinks
#= require lodash
#= require react
#= require react_ujs
#= require components
#= require_tree .

pageLoad = ->
  className = $('body').attr('data-class-name')
  window.applicationView = try
    eval("new #{className}()")
  catch error
    new Views.ApplicationView()
  window.applicationView.render()

head ->
  $ ->
    pageLoad()
    $(document).on 'page:load', pageLoad
    $(document).on 'page:before-change', ->
      console.log('page:before-change')
      window.applicationView.cleanup()
      true
    $(document).on 'page:restore', ->
      console.log('page:restore')
      window.applicationView.cleanup()
      pageLoad()
      true
