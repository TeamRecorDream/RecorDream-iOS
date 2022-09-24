// swiftlint:disable all
// swift-format-ignore-file
// swiftformat:disable all
// Generated using tuist — https://github.com/tuist/tuist

#if os(OSX)
  import AppKit.NSFont
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIFont
#endif

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Fonts

// swiftlint:disable identifier_name line_length type_body_length
public enum PresentationFontFamily {
  public enum Pretendard {
    public static let black = PresentationFontConvertible(name: "Pretendard-Black", family: "Pretendard", path: "Pretendard-Black.otf")
    public static let bold = PresentationFontConvertible(name: "Pretendard-Bold", family: "Pretendard", path: "Pretendard-Bold.otf")
    public static let extraBold = PresentationFontConvertible(name: "Pretendard-ExtraBold", family: "Pretendard", path: "Pretendard-ExtraBold.otf")
    public static let extraLight = PresentationFontConvertible(name: "Pretendard-ExtraLight", family: "Pretendard", path: "Pretendard-ExtraLight.otf")
    public static let light = PresentationFontConvertible(name: "Pretendard-Light", family: "Pretendard", path: "Pretendard-Light.otf")
    public static let medium = PresentationFontConvertible(name: "Pretendard-Medium", family: "Pretendard", path: "Pretendard-Medium.otf")
    public static let regular = PresentationFontConvertible(name: "Pretendard-Regular", family: "Pretendard", path: "Pretendard-Regular.otf")
    public static let semiBold = PresentationFontConvertible(name: "Pretendard-SemiBold", family: "Pretendard", path: "Pretendard-SemiBold.otf")
    public static let thin = PresentationFontConvertible(name: "Pretendard-Thin", family: "Pretendard", path: "Pretendard-Thin.otf")
    public static let all: [PresentationFontConvertible] = [black, bold, extraBold, extraLight, light, medium, regular, semiBold, thin]
  }
  public static let allCustomFonts: [PresentationFontConvertible] = [Pretendard.all].flatMap { $0 }
  public static func registerAllCustomFonts() {
    allCustomFonts.forEach { $0.register() }
  }
}
// swiftlint:enable identifier_name line_length type_body_length

// MARK: - Implementation Details

public struct PresentationFontConvertible {
  public let name: String
  public let family: String
  public let path: String

  #if os(OSX)
  public typealias Font = NSFont
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Font = UIFont
  #endif

  public func font(size: CGFloat) -> Font {
    guard let font = Font(font: self, size: size) else {
      fatalError("Unable to initialize font '\(name)' (\(family))")
    }
    return font
  }

  public func register() {
    // swiftlint:disable:next conditional_returns_on_newline
    guard let url = url else { return }
    CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
  }

  fileprivate var url: URL? {
    // swiftlint:disable:next implicit_return
    return Bundle.module.url(forResource: path, withExtension: nil)
  }
}

public extension PresentationFontConvertible.Font {
  convenience init?(font: PresentationFontConvertible, size: CGFloat) {
    #if os(iOS) || os(tvOS) || os(watchOS)
    if !UIFont.fontNames(forFamilyName: font.family).contains(font.name) {
      font.register()
    }
    #elseif os(OSX)
    if let url = font.url, CTFontManagerGetScopeForURL(url as CFURL) == .none {
      font.register()
    }
    #endif

    self.init(name: font.name, size: size)
  }
}
// swiftlint:enable all
// swiftformat:enable all
