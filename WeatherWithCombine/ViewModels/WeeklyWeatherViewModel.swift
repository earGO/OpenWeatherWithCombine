import SwiftUI
import Combine

// 1
class WeeklyWeatherViewModel: ObservableObject, Identifiable {
	// 2
	@Published var city: String = ""
	
	// 3
	@Published var dataSource: [DailyWeatherRowViewModel] = []
	
	@Inject var weatherFetcher: WeatherFetcher
	
	// 4
	private var disposables = Set<AnyCancellable>()
	
	init(
		scheduler: DispatchQueue = DispatchQueue(label: "WeatherViewModel")
	) {
		
		// 2 - since $city is 2-way binded value, here we have $city as a
		// stream of values from a text field at the top of the WeaklyWeatherView
		$city
			// 3 - since first value in a stream will be an empty string
			// (it'l come when the WeeklyWeatherView will be rendered for the first time)
			// we're dropping it to save empty HTTPS request
			.dropFirst(1)
			// 4 - wait for 0.5 second after the user will stop typing
			.debounce(for: .seconds(0.5), scheduler: scheduler)
			// 5
			.sink(receiveValue: fetchWeather(forCity:))
			// 6
			.store(in: &disposables)
	}
	
	func fetchWeather(forCity city: String) {
		weatherFetcher.weeklyWeatherForecast(forCity: city)
			.map { response in
				response.list.map(DailyWeatherRowViewModel.init)
			}
			.map(Array.removeDuplicates)
			.receive(on: DispatchQueue.main)
			.sink(
				receiveCompletion: { [weak self] value in
					guard let self = self else { return }
					switch value {
						case .failure:
							self.dataSource = []
						case .finished:
							break
					}
				},
				receiveValue: { [weak self] forecast in
					guard let self = self else { return }
					self.dataSource = forecast
				})
			.store(in: &disposables)
	}
}
