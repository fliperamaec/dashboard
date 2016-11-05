class Dashing.GoogleCalendar extends Dashing.Widget

  onData: (data) =>
    event = rest = null
    getEvents = (first, others...) ->
      event = first
      rest = others

    getEvents data.events.items...

    start = moment(event.start.date_time)
    end = moment(event.end.date_time)

    @set('event',event)
    @set('event_date', start.format('dddd Do MMMM'))
    @set('event_times', start.format('HH:mm') + " - " + end.format('HH:mm'))

    next_events = []
    for next_event in rest
      start = moment(next_event.start.date_time)
      start_date = start.format('ddd Do MMM')
      start_time = start.format('HH:mm')

      next_events.push { summary: next_event.summary, start_date: start_date, start_time: start_time }
    @set('next_events', next_events)
