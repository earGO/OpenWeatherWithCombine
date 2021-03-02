

import Foundation

class DIContainer {
	private let weatherFetcher:WeatherFetcher;
	
	init(){
		self.weatherFetcher = WeatherFetcher();
		addDependencies();
	}
	
	private func addDependencies(){
		let resolver = Resolver.shared;
		resolver.add(weatherFetcher);
	}
}
