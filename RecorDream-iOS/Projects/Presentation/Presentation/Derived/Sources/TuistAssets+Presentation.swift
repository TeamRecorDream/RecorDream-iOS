// swiftlint:disable all
// swift-format-ignore-file
// swiftformat:disable all
// Generated using tuist — https://github.com/tuist/tuist

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
public enum PresentationAsset {
  public enum Colors {
    public static let dark = PresentationColors(name: "dark")
    public static let grey01 = PresentationColors(name: "grey01")
    public static let grey02 = PresentationColors(name: "grey02")
    public static let purple = PresentationColors(name: "purple")
    public static let red = PresentationColors(name: "red")
    public static let white01 = PresentationColors(name: "white01")
    public static let white02 = PresentationColors(name: "white02")
    public static let white03 = PresentationColors(name: "white03")
    public static let white04 = PresentationColors(name: "white04")
    public static let white05 = PresentationColors(name: "white05")
    public static let white06 = PresentationColors(name: "white06")
  }
  public enum Images {
    public static let backgroundBlue = PresentationImages(name: "background_blue")
    public static let backgroundPink = PresentationImages(name: "background_pink")
    public static let backgroundPurple = PresentationImages(name: "background_purple")
    public static let backgroundRed = PresentationImages(name: "background_red")
    public static let backgroundWhite = PresentationImages(name: "background_white")
    public static let backgroundYellow = PresentationImages(name: "background_yellow")
    public static let cardLBlue = PresentationImages(name: "card_l_blue")
    public static let cardLPink = PresentationImages(name: "card_l_pink")
    public static let cardLPurple = PresentationImages(name: "card_l_purple")
    public static let cardLRed = PresentationImages(name: "card_l_red")
    public static let cardLWhite = PresentationImages(name: "card_l_white")
    public static let cardLYellow = PresentationImages(name: "card_l_yellow")
    public static let cardMBlue1 = PresentationImages(name: "card_m_blue-1")
    public static let cardMBlue = PresentationImages(name: "card_m_blue")
    public static let cardMPink = PresentationImages(name: "card_m_pink")
    public static let cardMRed = PresentationImages(name: "card_m_red")
    public static let cardMWhite = PresentationImages(name: "card_m_white")
    public static let cardMYellow = PresentationImages(name: "card_m_yellow")
    public static let cardSBlue = PresentationImages(name: "card_s_blue")
    public static let cardSPink = PresentationImages(name: "card_s_pink")
    public static let cardSPurple = PresentationImages(name: "card_s_purple")
    public static let cardSRed = PresentationImages(name: "card_s_red")
    public static let cardSWhite = PresentationImages(name: "card_s_white")
    public static let cardSYellow = PresentationImages(name: "card_s_yellow")
    public static let homeBackground = PresentationImages(name: "home_background")
    public static let listBlue = PresentationImages(name: "list_blue")
    public static let listPink = PresentationImages(name: "list_pink")
    public static let listPurple = PresentationImages(name: "list_purple")
    public static let listRed = PresentationImages(name: "list_red")
    public static let listWhite = PresentationImages(name: "list_white")
    public static let listYellow = PresentationImages(name: "list_yellow")
    public static let splashBackground = PresentationImages(name: "splash_background")
  }
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

public final class PresentationColors {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  public private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  fileprivate init(name: String) {
    self.name = name
  }
}

public extension PresentationColors.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: PresentationColors) {
    let bundle = PresentationResources.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

public struct PresentationImages {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Image = UIImage
  #endif

  public var image: Image {
    let bundle = PresentationResources.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let image = bundle.image(forResource: NSImage.Name(name))
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
}

public extension PresentationImages.Image {
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the PresentationImages.image property")
  convenience init?(asset: PresentationImages) {
    #if os(iOS) || os(tvOS)
    let bundle = PresentationResources.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

// swiftlint:enable all
// swiftformat:enable all
