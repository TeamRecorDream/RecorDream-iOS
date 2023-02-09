import Foundation

public extension URL {
    /// - Description: URL에 한국어가 있는 경우, 퍼센트 문자로 치환합니다
    static func decodeURL(urlString: String) -> URL? {
        if let url = URL(string: urlString)  {
            return url
        } else {
            let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? urlString
            return URL(string: encodedString)
        }
    }
}

public extension URL {
    struct ExternalURL {
        public static let appstore = URL(string: "https://apps.apple.com/kr/app/%EB%A0%88%EC%BD%94%EB%93%9C%EB%A6%BC/id1645675304")
    }
}
