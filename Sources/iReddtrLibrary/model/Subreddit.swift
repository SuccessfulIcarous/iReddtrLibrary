//
//  File.swift
//  
//
//  Created by Brata on 16/07/21.
//

import Foundation

public struct SubredditListing: Codable {
    public let data: RedditListingData<SubredditKind>?
    
    enum CodingKeys: String, CodingKey {
        case data
    }
}

public struct SubredditKind: Codable {
    public let data: SubredditData?
    
    enum CodingKeys: String, CodingKey {
        case data
    }
}

public struct SubredditData: Codable, Identifiable {
    public let id: String
    public let name: String?
    public let title: String?
    public let displayName: String?
    public let displayNamePrefixed: String?
    public let iconImg: String?
    public let communityIcon: String?
    
    enum CodingKeys: String, CodingKey {
        case name, title, id
        case displayName = "display_name"
        case displayNamePrefixed = "display_name_prefixed"
        case iconImg = "icon_img"
        case communityIcon = "community_icon"
    }
    
    public func getSubredditName() -> String {
        return self.displayNamePrefixed ?? ""
    }
    
    public func getSubredditShortDesc() -> String {
        return self.title ?? ""
    }
    
    public func getSubredditIcon() -> String {
        var iconUrl = ""
        if let communityIcon = self.communityIcon, !communityIcon.isEmpty {
            iconUrl = communityIcon
        } else if let defaultIcon = self.iconImg, !defaultIcon.isEmpty {
            iconUrl = defaultIcon
        } else {
            iconUrl = ""
        }
        return getMediaUrl(url: iconUrl)
    }
}
