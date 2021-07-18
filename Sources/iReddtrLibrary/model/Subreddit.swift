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
    
    enum CodingKeys: String, CodingKey {
        case name, title, id
        case displayName = "display_name"
        case displayNamePrefixed = "display_name_prefixed"
        case iconImg = "icon_img"
    }
}
