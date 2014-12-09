Router.configure
  layoutTemplate: 'ApplicationLayout'

Router.route '/', ->
  this.render 'Home'
  return
Router.route '/:_id', ->
  this.render 'Timer'
  return
