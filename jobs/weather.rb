require 'net/http'

CITY_ID = 3459712 # Joinville, SC, Brazil
UNITS   = 'metric'

SCHEDULER.every '10m', :first_in => 0 do |job|
  http = Net::HTTP.new('api.openweathermap.org')
  response = http.request(Net::HTTP::Get.new("/data/2.5/weather?id=#{CITY_ID}&units=#{UNITS}&appid=#{ENV['OPEN_WEATHER_API_KEY']}"))

  next unless '200'.eql? response.code

  weather_data  = JSON.parse(response.body)
  detailed_info = weather_data['weather'].first
  current_temp  = weather_data['main']['temp'].to_f.round

  send_event('weather', { :temp => "#{current_temp} &deg;#{temperature_units}",
                          :condition => detailed_info['main'],
                          :title => weather_data['name'],
                          :color => color_temperature(current_temp),
                          :climacon => climacon_class(detailed_info['id'])})
end


def temperature_units
  'metric'.eql?(UNITS) ? 'C' : 'K'
end

def color_temperature(temp_celsius)
  case temp_celsius.to_i
  when 30..100
    '#FF3300'
  when 25..29
    '#FF6000'
  when 19..24
    '#FF9D00'
  when 5..18
    '#18A9FF'
  else
    '#0065FF'
  end
end

# fun times ;) legend: http://openweathermap.org/weather-conditions
def climacon_class(weather_code)
  case weather_code.to_s
  when /800/
    'sun'
  when /80./
    'cloud'
  when /2.*/
    'lightning'
  when /3.*/
    'drizzle'
  when /5.*/
    'rain'
  when /6.*/
    'snow'
  else
    'sun'
  end
end
