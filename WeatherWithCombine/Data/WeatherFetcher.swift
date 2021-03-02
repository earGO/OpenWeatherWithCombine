
import Foundation
import Combine
protocol WeatherFetchable {
	func weeklyWeatherForecast(
		forCity city: String
	) -> AnyPublisher<WeeklyForecastResponse, WeatherError>
	
	func currentWeatherForecast(
		forCity city: String
	) -> AnyPublisher<CurrentWeatherForecastResponse, WeatherError>
}

class WeatherFetcher {
	private let session: URLSession
	
	init(session: URLSession = .shared) {
		self.session = session
	}
}

extension WeatherFetcher: WeatherFetchable{
	func weeklyWeatherForecast(forCity city: String) -> AnyPublisher<WeeklyForecastResponse, WeatherError> {
		return forecast(session,with: makeWeeklyForecastComponents(withCity: city))
	}
	
	func currentWeatherForecast(forCity city: String) -> AnyPublisher<CurrentWeatherForecastResponse, WeatherError> {
		return forecast(session,with: makeCurrentDayForecastComponents(withCity: city))
	}
	
	
}

