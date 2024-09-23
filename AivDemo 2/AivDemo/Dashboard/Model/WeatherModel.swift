//
//  WeatherModel.swift
//  AivDemo
//
//  Created by Akshay on 23/09/24.
//

import Foundation

struct WeatherResponseModel: Decodable {

	let location: LocationModel?
	let current: CurrentModel?

	private enum CodingKeys: CodingKey {
		case location
		case current
	}

	init(from decoder: any Decoder) throws {
		let container = try? decoder.container(keyedBy: WeatherResponseModel.CodingKeys.self)

		self.location = try? container?.decodeIfPresent(LocationModel.self, forKey: WeatherResponseModel.CodingKeys.location)
		self.current = try? container?.decodeIfPresent(CurrentModel.self, forKey: WeatherResponseModel.CodingKeys.current)

	}

	internal init(location: LocationModel? = nil, current: CurrentModel? = nil) {
		self.location = location
		self.current = current
	}
}

// MARK: - Current
struct CurrentModel: Decodable {

	let lastUpdatedEpoch: Int?
	let lastUpdated: String?
	let tempC, tempF: Double?
	let isDay: Int?
	let condition: ConditionModel?
	let windMph, windKph: Double?
	let windDegree: Int?
	let windDir: String?
	let pressureMB: Int?
	let pressureIn, precipMm, precipIn: Double?
	let humidity, cloud: Int?
	let feelslikeC, feelslikeF, windchillC, windchillF: Double?
	let heatindexC, heatindexF: Double?
	let dewpointC: Int?
	let dewpointF: Double?
	let visKM, visMiles, uv: Int?
	let gustMph, gustKph: Double?

	enum CodingKeys: String, CodingKey {
		case lastUpdatedEpoch = "last_updated_epoch"
		case lastUpdated = "last_updated"
		case tempC = "temp_c"
		case tempF = "temp_f"
		case isDay = "is_day"
		case condition
		case windMph = "wind_mph"
		case windKph = "wind_kph"
		case windDegree = "wind_degree"
		case windDir = "wind_dir"
		case pressureMB = "pressure_mb"
		case pressureIn = "pressure_in"
		case precipMm = "precip_mm"
		case precipIn = "precip_in"
		case humidity, cloud
		case feelslikeC = "feelslike_c"
		case feelslikeF = "feelslike_f"
		case windchillC = "windchill_c"
		case windchillF = "windchill_f"
		case heatindexC = "heatindex_c"
		case heatindexF = "heatindex_f"
		case dewpointC = "dewpoint_c"
		case dewpointF = "dewpoint_f"
		case visKM = "vis_km"
		case visMiles = "vis_miles"
		case uv
		case gustMph = "gust_mph"
		case gustKph = "gust_kph"
	}

	init(from decoder: any Decoder) throws {
		let container = try? decoder.container(keyedBy: CurrentModel.CodingKeys.self)

		self.lastUpdatedEpoch = try? container?.decodeIfPresent(Int.self, forKey: CurrentModel.CodingKeys.lastUpdatedEpoch)
		self.lastUpdated = try? container?.decodeIfPresent(String.self, forKey: CurrentModel.CodingKeys.lastUpdated)
		self.tempC = try? container?.decodeIfPresent(Double.self, forKey: CurrentModel.CodingKeys.tempC)
		self.tempF = try? container?.decodeIfPresent(Double.self, forKey: CurrentModel.CodingKeys.tempF)
		self.isDay = try? container?.decodeIfPresent(Int.self, forKey: CurrentModel.CodingKeys.isDay)
		self.condition = try? container?.decodeIfPresent(ConditionModel.self, forKey: CurrentModel.CodingKeys.condition)
		self.windMph = try? container?.decodeIfPresent(Double.self, forKey: CurrentModel.CodingKeys.windMph)
		self.windKph = try? container?.decodeIfPresent(Double.self, forKey: CurrentModel.CodingKeys.windKph)
		self.windDegree = try? container?.decodeIfPresent(Int.self, forKey: CurrentModel.CodingKeys.windDegree)
		self.windDir = try? container?.decodeIfPresent(String.self, forKey: CurrentModel.CodingKeys.windDir)
		self.pressureMB = try? container?.decodeIfPresent(Int.self, forKey: CurrentModel.CodingKeys.pressureMB)
		self.pressureIn = try? container?.decodeIfPresent(Double.self, forKey: CurrentModel.CodingKeys.pressureIn)
		self.precipMm = try? container?.decodeIfPresent(Double.self, forKey: CurrentModel.CodingKeys.precipMm)
		self.precipIn = try? container?.decodeIfPresent(Double.self, forKey: CurrentModel.CodingKeys.precipIn)
		self.humidity = try? container?.decodeIfPresent(Int.self, forKey: CurrentModel.CodingKeys.humidity)
		self.cloud = try? container?.decodeIfPresent(Int.self, forKey: CurrentModel.CodingKeys.cloud)
		self.feelslikeC = try? container?.decodeIfPresent(Double.self, forKey: CurrentModel.CodingKeys.feelslikeC)
		self.feelslikeF = try? container?.decodeIfPresent(Double.self, forKey: CurrentModel.CodingKeys.feelslikeF)
		self.windchillC = try? container?.decodeIfPresent(Double.self, forKey: CurrentModel.CodingKeys.windchillC)
		self.windchillF = try? container?.decodeIfPresent(Double.self, forKey: CurrentModel.CodingKeys.windchillF)
		self.heatindexC = try? container?.decodeIfPresent(Double.self, forKey: CurrentModel.CodingKeys.heatindexC)
		self.heatindexF = try? container?.decodeIfPresent(Double.self, forKey: CurrentModel.CodingKeys.heatindexF)
		self.dewpointC = try? container?.decodeIfPresent(Int.self, forKey: CurrentModel.CodingKeys.dewpointC)
		self.dewpointF = try? container?.decodeIfPresent(Double.self, forKey: CurrentModel.CodingKeys.dewpointF)
		self.visKM = try? container?.decodeIfPresent(Int.self, forKey: CurrentModel.CodingKeys.visKM)
		self.visMiles = try? container?.decodeIfPresent(Int.self, forKey: CurrentModel.CodingKeys.visMiles)
		self.uv = try? container?.decodeIfPresent(Int.self, forKey: CurrentModel.CodingKeys.uv)
		self.gustMph = try? container?.decodeIfPresent(Double.self, forKey: CurrentModel.CodingKeys.gustMph)
		self.gustKph = try? container?.decodeIfPresent(Double.self, forKey: CurrentModel.CodingKeys.gustKph)

	}
	internal init(lastUpdatedEpoch: Int? = nil, lastUpdated: String? = nil, tempC: Double? = nil, tempF: Double? = nil, isDay: Int? = nil, condition: ConditionModel? = nil, windMph: Double? = nil, windKph: Double? = nil, windDegree: Int? = nil, windDir: String? = nil, pressureMB: Int? = nil, pressureIn: Double? = nil, precipMm: Double? = nil, precipIn: Double? = nil, humidity: Int? = nil, cloud: Int? = nil, feelslikeC: Double? = nil, feelslikeF: Double? = nil, windchillC: Double? = nil, windchillF: Double? = nil, heatindexC: Double? = nil, heatindexF: Double? = nil, dewpointC: Int? = nil, dewpointF: Double? = nil, visKM: Int? = nil, visMiles: Int? = nil, uv: Int? = nil, gustMph: Double? = nil, gustKph: Double? = nil) {
		self.lastUpdatedEpoch = lastUpdatedEpoch
		self.lastUpdated = lastUpdated
		self.tempC = tempC
		self.tempF = tempF
		self.isDay = isDay
		self.condition = condition
		self.windMph = windMph
		self.windKph = windKph
		self.windDegree = windDegree
		self.windDir = windDir
		self.pressureMB = pressureMB
		self.pressureIn = pressureIn
		self.precipMm = precipMm
		self.precipIn = precipIn
		self.humidity = humidity
		self.cloud = cloud
		self.feelslikeC = feelslikeC
		self.feelslikeF = feelslikeF
		self.windchillC = windchillC
		self.windchillF = windchillF
		self.heatindexC = heatindexC
		self.heatindexF = heatindexF
		self.dewpointC = dewpointC
		self.dewpointF = dewpointF
		self.visKM = visKM
		self.visMiles = visMiles
		self.uv = uv
		self.gustMph = gustMph
		self.gustKph = gustKph
	}
}

// MARK: - Condition
struct ConditionModel: Decodable {


	let text, icon: String?
	let code: Int?

	var imageUrl: URL? {
		return URL(string: icon ?? "")
	}

	private enum CodingKeys: CodingKey {
		case text
		case icon
		case code
	}

	init(from decoder: any Decoder) throws {
		let container = try? decoder.container(keyedBy: ConditionModel.CodingKeys.self)

		self.text = try? container?.decodeIfPresent(String.self, forKey: ConditionModel.CodingKeys.text)
		self.icon = try? container?.decodeIfPresent(String.self, forKey: ConditionModel.CodingKeys.icon)
		self.code = try? container?.decodeIfPresent(Int.self, forKey: ConditionModel.CodingKeys.code)

	}
	internal init(text: String? = nil, icon: String? = nil, code: Int? = nil) {
		self.text = text
		self.icon = icon
		self.code = code
	}
}

// MARK: - Location
struct LocationModel: Decodable {


	let name, region, country: String?
	let lat, lon: Double?
	let tzID: String?
	let localtimeEpoch: Int?
	let localtime: String?

	enum CodingKeys: String, CodingKey {
		case name, region, country, lat, lon
		case tzID = "tz_id"
		case localtimeEpoch = "localtime_epoch"
		case localtime
	}

	init(from decoder: any Decoder) throws {
		let container = try? decoder.container(keyedBy: LocationModel.CodingKeys.self)

		self.name = try? container?.decodeIfPresent(String.self, forKey: LocationModel.CodingKeys.name)
		self.region = try? container?.decodeIfPresent(String.self, forKey: LocationModel.CodingKeys.region)
		self.country = try? container?.decodeIfPresent(String.self, forKey: LocationModel.CodingKeys.country)
		self.lat = try? container?.decodeIfPresent(Double.self, forKey: LocationModel.CodingKeys.lat)
		self.lon = try? container?.decodeIfPresent(Double.self, forKey: LocationModel.CodingKeys.lon)
		self.tzID = try? container?.decodeIfPresent(String.self, forKey: LocationModel.CodingKeys.tzID)
		self.localtimeEpoch = try? container?.decodeIfPresent(Int.self, forKey: LocationModel.CodingKeys.localtimeEpoch)
		self.localtime = try? container?.decodeIfPresent(String.self, forKey: LocationModel.CodingKeys.localtime)

	}
	internal init(name: String? = nil, region: String? = nil, country: String? = nil, lat: Double? = nil, lon: Double? = nil, tzID: String? = nil, localtimeEpoch: Int? = nil, localtime: String? = nil) {
		self.name = name
		self.region = region
		self.country = country
		self.lat = lat
		self.lon = lon
		self.tzID = tzID
		self.localtimeEpoch = localtimeEpoch
		self.localtime = localtime
	}
}
