
import Foundation

// MARK: - RelativeChannel
struct RelativeChannel: Codable {
    let data: [Datums]?
    let pagination: Pagination?
    let meta: Meta?
}

// MARK: - Datum
struct Datums: Codable,CommonData {
    var gifID_      : String? { "\(id ?? 0)"          }
    var gifURL_     : String? { user?.avatarURL ?? "" }
    var displayName_: String? { displayName     ?? "" }
    var bannerURL   : String? { user?.bannerURL ?? "" }
    var imageURL    : String? { user?.avatarURL ?? "" }
    var userName    : String? { user?.username  ?? "" }
    
    let id: Int?
    let displayName: String?
    let parent: String? //
    let slug: String?
    let type: String? //
    let contentType: String?
    let shortDisplayName, description: String?
    let hasChildren: Bool?
    let featuredGIF: FeaturedGIF?
    let bannerImage: String?
    let user: User?
    let ancestors: [String]? //
    let tags: [Tag]?
    let analyticsResponsePayload: String?

    enum CodingKeys: String, CodingKey {
        case id
        case displayName = "display_name"
        case parent, slug, type
        case contentType = "content_type"
        case shortDisplayName = "short_display_name"
        case description
        case hasChildren = "has_children"
        case featuredGIF = "featured_gif"
        case bannerImage = "banner_image"
        case user, ancestors, tags
        case analyticsResponsePayload = "analytics_response_payload"
    }
}


// MARK: - FeaturedGIF
struct FeaturedGIF: Codable {
    let type: String?
    let id: String?
    let url: String?
    let slug: String?
    let bitlyGIFURL, bitlyURL: String?
    let embedURL: String?
    let username: String?
    let source: String?
    let title: String?
    let rating: String?
    let contentURL: String?
    let sourceTLD: String?
    let sourcePostURL: String?
    let isSticker: Int?
    let importDatetime, trendingDatetime: String?
    let images: Images2?
    let user: User?

    enum CodingKeys: String, CodingKey {
        case type, id, url, slug
        case bitlyGIFURL = "bitly_gif_url"
        case bitlyURL = "bitly_url"
        case embedURL = "embed_url"
        case username, source, title, rating
        case contentURL = "content_url"
        case sourceTLD = "source_tld"
        case sourcePostURL = "source_post_url"
        case isSticker = "is_sticker"
        case importDatetime = "import_datetime"
        case trendingDatetime = "trending_datetime"
        case images, user
    }
}

// MARK: - Images
struct Images2: Codable {
//    let fixedWidthStill, previewGIF: The480_WStill?
//    let fixedHeightDownsampled: FixedHeight?
//    let preview: DownsizedSmall?
//    let fixedHeightSmall: FixedHeight?
//    let downsized: The480_WStill?
//    let fixedWidthDownsampled, fixedWidth: FixedHeight?
//    let downsizedStill, downsizedMedium: The480_WStill?
//    let originalMp4: DownsizedSmall?
//    let downsizedLarge, previewWebp: The480_WStill?
    let original: FixedHeight?
//    let originalStill, fixedHeightSmallStill: The480_WStill?
//    let fixedWidthSmall: FixedHeight?
//    let looping: Looping?
//    let downsizedSmall: DownsizedSmall?
//    let fixedWidthSmallStill, fixedHeightStill: The480_WStill?
//    let fixedHeight: FixedHeight?
//    let the480WStill: The480_WStill?
//    let hd: DownsizedSmall?

    enum CodingKeys: String, CodingKey {
//        case fixedWidthStill = "fixed_width_still"
//        case previewGIF = "preview_gif"
//        case fixedHeightDownsampled = "fixed_height_downsampled"
//        case preview
//        case fixedHeightSmall = "fixed_height_small"
//        case downsized
//        case fixedWidthDownsampled = "fixed_width_downsampled"
//        case fixedWidth = "fixed_width"
//        case downsizedStill = "downsized_still"
//        case downsizedMedium = "downsized_medium"
//        case originalMp4 = "original_mp4"
//        case downsizedLarge = "downsized_large"
//        case previewWebp = "preview_webp"
        case original
//        case originalStill = "original_still"
//        case fixedHeightSmallStill = "fixed_height_small_still"
//        case fixedWidthSmall = "fixed_width_small"
//        case looping
//        case downsizedSmall = "downsized_small"
//        case fixedWidthSmallStill = "fixed_width_small_still"
//        case fixedHeightStill = "fixed_height_still"
//        case fixedHeight = "fixed_height"
//        case the480WStill = "480w_still"
//        case hd
    }
}

// MARK: - The480_WStill
//struct The480_WStill: Codable {
//    let url: String?
//    let width, height, size: String?
//}

// MARK: - DownsizedSmall
//struct DownsizedSmall: Codable {
//    let height: String?
//    let mp4: String?
//    let mp4Size, width: String?
//
//    enum CodingKeys: String, CodingKey {
//        case height, mp4
//        case mp4Size = "mp4_size"
//        case width
//    }
//}

// MARK: - FixedHeight
//struct FixedHeight: Codable {
//    let height: String?
//    let mp4: String?
//    let mp4Size, size: String?
//    let url: String?
//    let webp: String?
//    let webpSize, width, frames, hash: String?
//
//    enum CodingKeys: String, CodingKey {
//        case height, mp4
//        case mp4Size = "mp4_size"
//        case size, url, webp
//        case webpSize = "webp_size"
//        case width, frames, hash
//    }
//}

// MARK: - Looping
struct Looping: Codable {
    let mp4: String?
    let mp4Size: String?

    enum CodingKeys: String, CodingKey {
        case mp4
        case mp4Size = "mp4_size"
    }
}



//// MARK: - User
//struct User: Codable {
//    let avatarURL: String?
//    let bannerImage, bannerURL: String?
//    let profileURL: String?
//    let username, displayName, description: String?
//    let isVerified: Bool?
//    let websiteURL: String?
//    let instagramURL: String?
//
//    enum CodingKeys: String, CodingKey {
//        case avatarURL = "avatar_url"
//        case bannerImage = "banner_image"
//        case bannerURL = "banner_url"
//        case profileURL = "profile_url"
//        case username
//        case displayName = "display_name"
//        case description
//        case isVerified = "is_verified"
//        case websiteURL = "website_url"
//        case instagramURL = "instagram_url"
//    }
//}

// MARK: - Tag
struct Tag: Codable {
    let tag: String?
    let rank: Int?
}



// MARK: - Meta
//struct Meta: Codable {
//    let msg: String?
//    let status: Int?
//    let responseID: String?
//
//    enum CodingKeys: String, CodingKey {
//        case msg, status
//        case responseID = "response_id"
//    }
//}

// MARK: - Pagination
struct Pagination: Codable {
    let totalCount, count, offset: Int?

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case count, offset
    }
}

