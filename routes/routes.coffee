Router.configure
  layoutTemplate: 'ApplicationLayout'

Router.route '/', ->
  this.render 'Home'
  return
Router.route '/:_id', ->
  this.render 'Timer',
    data: ->
      Timers.findOne(
          _id: this.params._id
        )
  return
