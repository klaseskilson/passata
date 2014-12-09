timerHandle = Meteor.subscribe 'timers'
timerDep = new Deps.Dependency()

tick = ->
  # update our timer every second
  timerDep.changed()

changeCurrent = (current) ->
  opposite = (if current is 'work' then 'pause' else 'work')
  document.title = 'Thinking... – Passata'
  console.log 'changing from ' + current + ' to ' + opposite

  data =
    $set:
      current: opposite
      startTime: new Date()

  Timers.update(_id: Router.current().params._id, data)

Template.Timer.helpers
  loading: ->
    'active' unless timerHandle.ready()

  timer: ->
    return Timers.findOne(_id: Router.current().params._id) if timerHandle.ready()

Template.Clock.created = ->
  @tickInterval = Meteor.setInterval(tick, 1000);
  return
Template.Clock.destroyed = ->
  Meteor.clearInterval @tickInterval

Template.Clock.helpers
  clock: ->
    timerDep.depend()
    return false unless timerHandle.ready()

    now = new Date();
    difference = Math.floor (now - @startTime) / 1000
    countdown = this[@current + 'Duration'] - (difference % this[@current + 'Duration'])

    clock =
      minutes: Math.floor countdown / 60
      seconds: countdown % 60

    clock.minutes = '0' + clock.minutes if clock.minutes < 10
    clock.seconds = '0' + clock.seconds if clock.seconds < 10

    document.title = clock.minutes + ':' + clock.seconds + ' (' + @current + ') – Passata'

    if countdown < 2
      changeCurrent @current

    return clock
