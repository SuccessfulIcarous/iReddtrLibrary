import Foundation

let baseUrl = "https://asia-southeast2-macredditbackend.cloudfunctions.net/reddit/v1"
public typealias HttpCallback<T : Codable> = (HttpResult<T>) -> Void
public struct iReddtr {
    private static var _instance: iReddtr? = nil
    
    public static func getInstance() -> iReddtr {
        return _instance!
    }
    
    static func resetInstance() {
        _instance = nil
    }
    
    @discardableResult public static func initAPI() -> iReddtr {
        if let instance = _instance {
            return instance
        }
        _instance = iReddtr(url: "https://asia-southeast2-macredditbackend.cloudfunctions.net/reddit/v1")
        return _instance!
    }
    
    let baseUrl: String
    
    init(url: String) {
        self.baseUrl = url
    }
    
    func performGet<T>(_url: String, queryParams: [String: Any], resultQueue: DispatchQueue, completion: @escaping HttpCallback<T>) {
        guard var urlComponents = URLComponents(string: _url) else {
            completion(HttpResult.Error(APIError.invalidUrl))
            return
        }
        urlComponents.setQueryItems(with: queryParams)
        guard let url = urlComponents.url else {
            completion(HttpResult.Error(APIError.invalidUrl))
            return
        }
        let request = createGetRequest(url: url)
        print("Calling \(url.absoluteString)")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                resultQueue.async {
                    completion(HttpResult.Error(error))
                }
                return
            }
            
            guard let httpResponse = (response as? HTTPURLResponse), (200...299).contains(httpResponse.statusCode) else {
                resultQueue.async {
                    completion(HttpResult.Error(APIError.nonOkHttpResponse))
                }
                return
            }
            
            guard let json = try? JSONDecoder().decode(T.self, from: data!) else {
                resultQueue.async {
                    completion(HttpResult.Error(APIError.cannotDeserialiseJson))
                }
                return
            }
            
            resultQueue.async {
                completion(HttpResult.Success(json))
            }
            return
        }
        task.resume()
    }
    
    public func searchSubreddits(query: String, limit: Int = 100, nsfw: Bool = false, resultQueue: DispatchQueue = .main, onDone: @escaping HttpCallback<SubredditListing>) throws {
        let queryParams: [String: Any] = [
            "raw_json": 1,
            "q": query,
            "include_over_18": nsfw ? 1 : 0,
            "limit": limit
        ]
        let url = self.getAPIUrl(path: ApiPath.searchSubreddits)
        performGet(_url: url, queryParams: queryParams, resultQueue: resultQueue, completion: onDone)
    }
    
    public func getMediaUrl(url: String) -> String {
        let unescapedUrlString = url.replacingOccurrences(of: "&amp;", with: "&")
        if (unescapedUrlString.contains("https://styles.redditmedia.com")) {
            return unescapedUrlString.replacingOccurrences(of: "https://styles.redditmedia.com", with: "\(self.baseUrl)/styles")
        } else if (unescapedUrlString.contains("a.thumbs.redditmedia.com")) {
            return unescapedUrlString.replacingOccurrences(of: "https://a.thumbs.redditmedia.com", with: "\(self.baseUrl)/athumbs")
        } else if (unescapedUrlString.contains("b.thumbs.redditmedia.com")) {
            return unescapedUrlString.replacingOccurrences(of: "https://b.thumbs.redditmedia.com", with: "\(self.baseUrl)/bthumbs")
        } else if (unescapedUrlString.contains("c.thumbs.redditmedia.com")) {
            return unescapedUrlString.replacingOccurrences(of: "https://c.thumbs.redditmedia.com", with: "\(self.baseUrl)/cthumbs")
        } else if (unescapedUrlString.contains("d.thumbs.redditmedia.com")) {
            return unescapedUrlString.replacingOccurrences(of: "https://d.thumbs.redditmedia.com", with: "\(self.baseUrl)/dthumbs")
        } else if (unescapedUrlString.contains("e.thumbs.redditmedia.com")) {
            return unescapedUrlString.replacingOccurrences(of: "https://e.thumbs.redditmedia.com", with: "\(self.baseUrl)/ethumbs")
        } else if (unescapedUrlString.contains("f.thumbs.redditmedia.com")) {
            return unescapedUrlString.replacingOccurrences(of: "https://f.thumbs.redditmedia.com", with: "\(self.baseUrl)/fthumbs")
        } else if (unescapedUrlString.contains("g.thumbs.redditmedia.com")) {
            return unescapedUrlString.replacingOccurrences(of: "https://g.thumbs.redditmedia.com", with: "\(self.baseUrl)/gthumbs")
        }
        return unescapedUrlString
    }
    
    func getAPIUrl(path: ApiPath) -> String {
        return "\(baseUrl)/api\(path.rawValue)"
    }
    
    func createGetRequest(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethod.GET.rawValue
        return request
    }
}

public enum HttpResult<T> {
    case Success(T)
    case Error(Error)
}

public enum APIError: Error {
    case invalidUrl
    case cannotDeserialiseJson
    case nonOkHttpResponse
}

enum ApiPath: String {
    case searchSubreddits = "/subreddits/search.json"
}

enum HttpMethod: String {
    case GET, POST
}
