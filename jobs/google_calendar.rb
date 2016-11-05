require 'google/apis/calendar_v3'
require 'googleauth'

SCOPES = ['https://www.googleapis.com/auth/calendar.readonly']

SCHEDULER.every '15m', :first_in => 4 do |job|
  service = Google::Apis::CalendarV3::CalendarService.new
  service.authorization = Google::Auth.get_application_default(SCOPES)

  result = service.list_events(
    ENV['GOOGLE_CALENDAR_ID'],
    max_results: 6,
    single_events: true,
    order_by: 'startTime',
    time_min: Time.now.iso8601
  )

  send_event('google_calendar', { events: result.to_h })
end
