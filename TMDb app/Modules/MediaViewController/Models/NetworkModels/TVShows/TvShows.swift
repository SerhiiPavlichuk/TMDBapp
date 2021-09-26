import Foundation

struct TvShow : Codable {
	let firstAirDate : String?
	let backdropPath : String?
	let genreIds : [Int]?
	let voteCount : Int?
	let originalLanguage : String?
	let voteAverage : Double?
	let posterPath : String?
	let originalName : String?
	let originCountry : [String]?
	let id : Int?
	let name : String?
	let overview : String?
	let popularity : Double?
	let mediaType : String?

	enum CodingKeys: String, CodingKey {

		case firstAirDate = "first_air_date"
		case backdropPath = "backdrop_path"
		case genreIds = "genre_ids"
		case voteCount = "vote_count"
		case originalLanguage = "original_language"
		case voteAverage = "vote_average"
		case posterPath = "poster_path"
		case originalName = "original_name"
		case originCountry = "origin_country"
		case id = "id"
		case name = "name"
		case overview = "overview"
		case popularity = "popularity"
		case mediaType = "media_type"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
        firstAirDate = try values.decodeIfPresent(String.self, forKey: .firstAirDate)
        backdropPath = try values.decodeIfPresent(String.self, forKey: .backdropPath)
        genreIds = try values.decodeIfPresent([Int].self, forKey: .genreIds)
        voteCount = try values.decodeIfPresent(Int.self, forKey: .voteCount)
        originalLanguage = try values.decodeIfPresent(String.self, forKey: .originalLanguage)
        voteAverage = try values.decodeIfPresent(Double.self, forKey: .voteAverage)
        posterPath = try values.decodeIfPresent(String.self, forKey: .posterPath)
        originalName = try values.decodeIfPresent(String.self, forKey: .originalName)
        originCountry = try values.decodeIfPresent([String].self, forKey: .originCountry)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		overview = try values.decodeIfPresent(String.self, forKey: .overview)
		popularity = try values.decodeIfPresent(Double.self, forKey: .popularity)
        mediaType = try values.decodeIfPresent(String.self, forKey: .mediaType)
	}

}
