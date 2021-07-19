//
//  File.swift
//  
//
//  Created by Brata on 19/07/21.
//

import Foundation

func getMediaUrl(url: String) -> String {
    let unescapedUrlString = url.replacingOccurrences(of: "&amp;", with: "&")
    if (unescapedUrlString.contains("https://styles.redditmedia.com")) {
        return unescapedUrlString.replacingOccurrences(of: "https://styles.redditmedia.com", with: "\(baseUrl)/styles")
    } else if (unescapedUrlString.contains("a.thumbs.redditmedia.com")) {
        return unescapedUrlString.replacingOccurrences(of: "https://a.thumbs.redditmedia.com", with: "\(baseUrl)/athumbs")
    } else if (unescapedUrlString.contains("b.thumbs.redditmedia.com")) {
        return unescapedUrlString.replacingOccurrences(of: "https://b.thumbs.redditmedia.com", with: "\(baseUrl)/bthumbs")
    } else if (unescapedUrlString.contains("c.thumbs.redditmedia.com")) {
        return unescapedUrlString.replacingOccurrences(of: "https://c.thumbs.redditmedia.com", with: "\(baseUrl)/cthumbs")
    } else if (unescapedUrlString.contains("d.thumbs.redditmedia.com")) {
        return unescapedUrlString.replacingOccurrences(of: "https://d.thumbs.redditmedia.com", with: "\(baseUrl)/dthumbs")
    } else if (unescapedUrlString.contains("e.thumbs.redditmedia.com")) {
        return unescapedUrlString.replacingOccurrences(of: "https://e.thumbs.redditmedia.com", with: "\(baseUrl)/ethumbs")
    } else if (unescapedUrlString.contains("f.thumbs.redditmedia.com")) {
        return unescapedUrlString.replacingOccurrences(of: "https://f.thumbs.redditmedia.com", with: "\(baseUrl)/fthumbs")
    } else if (unescapedUrlString.contains("g.thumbs.redditmedia.com")) {
        return unescapedUrlString.replacingOccurrences(of: "https://g.thumbs.redditmedia.com", with: "\(baseUrl)/gthumbs")
    }
    return unescapedUrlString
}
