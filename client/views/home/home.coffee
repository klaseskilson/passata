Template.Home.events
  'click #new-timer': (event, template) ->
    id = Timers.insert
      workDuration: 20*60
      pauseDuration: 5*60
      longPauseDuration: 15*60
      longPauseLap: 4
      current: 'work'
      startTime: new Date()

    Router.go '/' + id

    return
