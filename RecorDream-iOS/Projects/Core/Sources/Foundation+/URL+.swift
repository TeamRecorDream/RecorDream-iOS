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
        // TODO: -
        public static let appstore = "앱스토어 유알엘 받아서 처리"
    }
}
