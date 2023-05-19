
import Foundation

// MARK: - RelativeSuggestion
struct RelativeSuggestion: Codable {
    let data: [Datumm]?
    let meta: Metaa?
}

// MARK: - Datum
struct Datumm: Codable {
    let name, analyticsResponsePayload: String?

    enum CodingKeys: String, CodingKey {
        case name
        case analyticsResponsePayload = "analytics_response_payload"
    }
}

// MARK: - Meta
struct Metaa: Codable {
    let msg: String?
    let status: Int?
    let responseID: String?

    enum CodingKeys: String, CodingKey {
        case msg, status
        case responseID = "response_id"
    }
}
