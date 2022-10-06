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
public enum RDDSKitAsset {
  public enum Colors {
    public static let dark = RDDSKitColors(name: "dark")
    public static let grey01 = RDDSKitColors(name: "grey01")
    public static let grey02 = RDDSKitColors(name: "grey02")
    public static let purple = RDDSKitColors(name: "purple")
    public static let red = RDDSKitColors(name: "red")
    public static let white01 = RDDSKitColors(name: "white01")
    public static let white02 = RDDSKitColors(name: "white02")
    public static let white03 = RDDSKitColors(name: "white03")
    public static let white04 = RDDSKitColors(name: "white04")
    public static let white05 = RDDSKitColors(name: "white05")
    public static let white06 = RDDSKitColors(name: "white06")
  }
  public enum Images {
    public static let backgroundBlue = RDDSKitImages(name: "background_blue")
    public static let backgroundPink = RDDSKitImages(name: "background_pink")
    public static let backgroundPurple = RDDSKitImages(name: "background_purple")
    public static let backgroundRed = RDDSKitImages(name: "background_red")
    public static let backgroundWhite = RDDSKitImages(name: "background_white")
    public static let backgroundYellow = RDDSKitImages(name: "background_yellow")
    public static let cardLBlue = RDDSKitImages(name: "card_l_blue")
    public static let cardLPink = RDDSKitImages(name: "card_l_pink")
    public static let cardLPurple = RDDSKitImages(name: "card_l_purple")
    public static let cardLRed = RDDSKitImages(name: "card_l_red")
    public static let cardLWhite = RDDSKitImages(name: "card_l_white")
    public static let cardLYellow = RDDSKitImages(name: "card_l_yellow")
    public static let cardMBlue1 = RDDSKitImages(name: "card_m_blue-1")
    public static let cardMBlue = RDDSKitImages(name: "card_m_blue")
    public static let cardMPink = RDDSKitImages(name: "card_m_pink")
    public static let cardMRed = RDDSKitImages(name: "card_m_red")
    public static let cardMWhite = RDDSKitImages(name: "card_m_white")
    public static let cardMYellow = RDDSKitImages(name: "card_m_yellow")
    public static let cardSBlue = RDDSKitImages(name: "card_s_blue")
    public static let cardSPink = RDDSKitImages(name: "card_s_pink")
    public static let cardSPurple = RDDSKitImages(name: "card_s_purple")
    public static let cardSRed = RDDSKitImages(name: "card_s_red")
    public static let cardSWhite = RDDSKitImages(name: "card_s_white")
    public static let cardSYellow = RDDSKitImages(name: "card_s_yellow")
    public static let homeBackground = RDDSKitImages(name: "home_background")
    public static let listBlue = RDDSKitImages(name: "list_blue")
    public static let listPink = RDDSKitImages(name: "list_pink")
    public static let listPurple = RDDSKitImages(name: "list_purple")
    public static let listRed = RDDSKitImages(name: "list_red")
    public static let listWhite = RDDSKitImages(name: "list_white")
    public static let listYellow = RDDSKitImages(name: "list_yellow")
    public static let splashBackground = RDDSKitImages(name: "splash_background")
    public static let feelingBright = RDDSKitImages(name: "feeling_bright")
    public static let feelingFright = RDDSKitImages(name: "feeling_fright")
    public static let feelingSad = RDDSKitImages(name: "feeling_sad")
    public static let feelingShy = RDDSKitImages(name: "feeling_shy")
    public static let feelingWeird = RDDSKitImages(name: "feeling_weird")
    public static let icnHome = RDDSKitImages(name: "icn-home")
    public static let icnRecord = RDDSKitImages(name: "icn-record")
    public static let icnStorage = RDDSKitImages(name: "icn-storage")
    public static let icnBack = RDDSKitImages(name: "icn_back")
    public static let icnClose = RDDSKitImages(name: "icn_close")
  }
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

public final class RDDSKitColors {
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

public extension RDDSKitColors.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: RDDSKitColors) {
    let bundle = RDDSKitResources.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

public struct RDDSKitImages {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Image = UIImage
  #endif

  public var image: Image {
    let bundle = RDDSKitResources.bundle
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

public extension RDDSKitImages.Image {
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the RDDSKitImages.image property")
  convenience init?(asset: RDDSKitImages) {
    #if os(iOS) || os(tvOS)
    let bundle = RDDSKitResources.bundle
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
