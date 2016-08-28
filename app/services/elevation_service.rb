class ElevationService
  API_URI = URI.parse('http://www4.des.state.nh.us/rivertraksearch/api/Search/')
  FORM_DATA = {
    :stationName      => 'OSSIPEE LK NR W OSSIPEE',
    :measTypeNum      => '40',
    :stationParameter => 'OBSERVED LAKE ELEVATION (HOUR) [FT]'
  }

  def self.fetch(start_date, end_date)
    data = FORM_DATA.merge({
      startDate: start_date.strftime('%D'),
      endDate: end_date.strftime('%D')
    })

    response = Net::HTTP.post_form(API_URI, data)

    self.format_response(response).reverse
  end

  private

  def self.format_response(response)
    JSON.parse(response.body).map { |r| self.parse(r) }
  end

  def self.parse(reading)
    return {
      date: parse_date(reading['Date']),
      timestamp: date_in_miliseconds(reading['Date']),
      value: reading['Observed'].to_f
    }
  end

  def self.parse_date(date)
    DateTime.strptime(date, '%m/%d/%Y %l:%M:%S %p')
  end

  def self.date_in_miliseconds(date)
    parse_date(date).to_time.to_i
  end
end
