import Foundation
import Combine

func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, WeatherError> {
	let decoder = JSONDecoder()
	decoder.dateDecodingStrategy = .secondsSince1970
	
	//this is a publisher from Combine that can't fail with error.
	return Just(data)
		.decode(type: T.self, decoder: decoder)
		.mapError { error in
			.parsing(description: error.localizedDescription)
		}
		.eraseToAnyPublisher()
}
