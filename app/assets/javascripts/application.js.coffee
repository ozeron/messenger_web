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
#= require datatables.js
#= require jquery-ui
#= require jquery_ujs
#= require bootstrap-sprockets

#= require bootstrap.js.coffee
#= require turbolinks
#= require i18n/translations
#= require lodash
#= require react
#= require react_ujs
#= require components
#= require_tree .

pageLoad = ->
  className = $('body').attr('data-class-name')
  I18n.defaultLocale = $('body').attr('data-default-locale')
  I18n.locale = $('body').attr('data-locale')
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
    $(document).on "turbolinks:load", ->
      window.applicationView.cleanup()
      pageLoad()
