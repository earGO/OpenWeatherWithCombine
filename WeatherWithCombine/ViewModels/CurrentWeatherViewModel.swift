import SwiftUI
import Combine

// 1
class CurrentWeatherViewModel: ObservableObject, Identifiable {
	// 2
	@Published var dataSource: CurrentWeatherRowViewModel?
	
	let city: String
	@Inject var weatherFetcher: WeatherFetcher
	private var disposables = Set<AnyCancellable>()
	
	init(city: String) {
		self.city = city
	}
	
	func refresh() {
		weatherFetcher
			.currentWeatherForecast(forCity: city)
			// 3
			.map(CurrentWeatherRowViewModel.init)
			.receive(on: DispatchQueue.main)
			.sink(receiveCompletion: { [weak self] value in
				guard let self = self else { return }
				switch value {
					case .failure:
						self.dataSource = nil
					case .finished:
						break
				}
			}, receiveValue: { [weak self] weather in
				guard let self = self else { return }
				self.dataSource = weather
			})
			.store(in: &disposables)
	}
}
