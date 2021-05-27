//
//  News.swift
//  VK Client
//
//  Created by Анастасия Живаева on 23.05.2021.
//

import Foundation

// MARK: - NewsList
struct NewsList: Codable {
    let response: NewsResponse
}

// MARK: - NewsResponse
struct NewsResponse: Codable {
    let items: [News]
    let groups: [Group]
    let profiles: [Profile]?
    let nextFrom: String

    enum CodingKeys: String, CodingKey {
        case items, groups, profiles
        case nextFrom = "next_from"
    }
}

// MARK: - News
struct News: Codable {
    let comments: Comments?
    let likes: PhotoLikes
    let reposts: Reposts
    let type, postType: String
    let date: Date
    let sourceID: Int
    let text: String
    let attachments: [Attachment]?
    let postID, markedAsAds: Int

    enum CodingKeys: String, CodingKey {
        case comments, type, likes, reposts
        case postType = "post_type"
        case date
        case sourceID = "source_id"
        case text
        case attachments
        case postID = "post_id"
        case markedAsAds = "marked_as_ads"
    }
}

// MARK: - Comments
struct Comments: Codable {
    let count, canPost: Int

    enum CodingKeys: String, CodingKey {
        case count
        case canPost = "can_post"
    }
}

// MARK: - Attachment
struct Attachment: Codable {
    let type: String
    let photo: PhotoNews?
    let audio: Audio?
    let video: Video?
}

// MARK: - Video
struct Video: Codable {
    let accessKey: String
    let canComment, canLike, canRepost, canSubscribe: Int
    let canAddToFaves, comments, date: Int?
    let videoDescription: String
    let duration: Int?
    let photo130, photo320, photo800, photo1280: String?
    let firstFrame130, firstFrame160, firstFrame320, firstFrame800: String?
    let firstFrame1280: String?
    let width, height: Int?
    let id, ownerID: Int
    let title, trackCode: String
    let views: Int

   enum CodingKeys: String, CodingKey {
       case accessKey = "access_key"
       case canComment = "can_comment"
       case canLike = "can_like"
       case canRepost = "can_repost"
       case canSubscribe = "can_subscribe"
       case canAddToFaves = "can_add_to_faves"
       case comments, date
       case videoDescription = "description"
       case duration
       case photo130 = "photo_130"
       case photo320 = "photo_320"
       case photo800 = "photo_800"
       case photo1280 = "photo_1280"
       case firstFrame130 = "first_frame_130"
       case firstFrame160 = "first_frame_160"
       case firstFrame320 = "first_frame_320"
       case firstFrame800 = "first_frame_800"
       case firstFrame1280 = "first_frame_1280"
       case width, height, id
       case ownerID = "owner_id"
       case title
       case trackCode = "track_code"
       case views
    }
}
// MARK: - Audio
struct Audio: Codable {
    let id: Int
    let storiesCoverAllowed: Bool
    let url: String
    let title: String
    let ownerID, date: Int
    let shortVideosAllowed: Bool
    let genreID, lyricsID, duration: Int?
    let artist: String
    let storiesAllowed: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case storiesCoverAllowed = "stories_cover_allowed"
        case url, title
        case ownerID = "owner_id"
        case date
        case shortVideosAllowed = "short_videos_allowed"
        case genreID = "genre_id"
        case lyricsID = "lyrics_id"
        case duration, artist
        case storiesAllowed = "stories_allowed"
    }
}

// MARK: - Photo
struct PhotoNews: Codable {
    let id: Int
    let photo2560, photo807, photo1280: String?
    let width: Int?
    let accessKey: String
    let photo604, photo130: String?
    let userID, date, ownerID: Int
    let height: Int
    let text: String
    let hasTags: Bool
    let albumID: Int
    let photo75: String?

    enum CodingKeys: String, CodingKey {
        case id
        case photo2560 = "photo_2560"
        case photo807 = "photo_807"
        case photo1280 = "photo_1280"
        case width
        case accessKey = "access_key"
        case photo604 = "photo_604"
        case photo130 = "photo_130"
        case userID = "user_id"
        case date
        case ownerID = "owner_id"
        case height, text
        case hasTags = "has_tags"
        case albumID = "album_id"
        case photo75 = "photo_75"
    }
}

// MARK: - Reposts
struct Reposts: Codable {
    let count, userReposted: Int

    enum CodingKeys: String, CodingKey {
        case count
        case userReposted = "user_reposted"
    }
}

// MARK: - Profile
struct Profile: Codable {
    let online, id: Int
    let photo100: String
    let lastName: String
    let photo50: String
    let onlineInfo: OnlineInfo
    let sex: Int
    let screenName, firstName: String?

    enum CodingKeys: String, CodingKey {
        case online, id
        case photo100 = "photo_100"
        case lastName = "last_name"
        case photo50 = "photo_50"
        case onlineInfo = "online_info"
        case sex
        case screenName = "screen_name"
        case firstName = "first_name"
    }
}

// MARK: - OnlineInfo
struct OnlineInfo: Codable {
    let isMobile: Bool
    let lastSeen: Int?
    let isOnline, visible: Bool

    enum CodingKeys: String, CodingKey {
        case isMobile = "is_mobile"
        case lastSeen = "last_seen"
        case isOnline = "is_online"
        case visible
    }
}
