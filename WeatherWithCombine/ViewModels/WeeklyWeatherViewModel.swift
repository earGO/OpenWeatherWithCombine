import SwiftUI
import Combine

// 1
class WeeklyWeatherViewModel: ObservableObject, Identifiable {
	// 2
	@Published var city: String = ""
	
	// 3
	@Published var dataSource: [DailyWeatherRowViewModel] = []
	
	private let weatherFetcher: WeatherFetchable
	
	// 4
	private var disposables = Set<AnyCancellable>()
	
	init(weatherFetcher: WeatherFetchable) {
		self.weatherFetcher = weatherFetcher
	}
}
