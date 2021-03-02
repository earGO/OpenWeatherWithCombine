import SwiftUI
import Combine

// 1
class WeeklyWeatherViewModel: ObservableObject, Identifiable {

	@Published var city: String = ""

	@Published var dataSource: [DailyWeatherRowViewModel] = []
	
	@Inject var weatherFetcher: WeatherFetcher

	private var disposables = Set<AnyCancellable>()
	
	init(
		scheduler: DispatchQueue = DispatchQueue(label: "WeatherViewModel")
	) {
		/* this is a handler for the city property, binded to the textfield,
		that's invoked every time user types something */
		$city
			.dropFirst(1) //city emits its first value the moment we've created the observation; application doesn't need this value
			.debounce(for: .seconds(0.5), scheduler: scheduler)
			.sink(receiveValue: fetchWeather(forCity:))
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

extension WeeklyWeatherViewModel {
	var currentWeatherView: some View {
		return WeeklyWeatherBuilder.makeCurrentWeatherView(
			withCity: city
		)
	}
}
