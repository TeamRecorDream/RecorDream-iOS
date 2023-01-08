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
    public static let icnMicTitle = RDDSKitImages(name: "icn_mic_title")
    public static let kakaotalk = RDDSKitImages(name: "Kakaotalk")
    public static let icnEdit = RDDSKitImages(name: "icn_edit")
    public static let icnMypage = RDDSKitImages(name: "icn_mypage")
    public static let listBlue = RDDSKitImages(name: "list_blue")
    public static let listPink = RDDSKitImages(name: "list_pink")
    public static let listPurple = RDDSKitImages(name: "list_purple")
    public static let listRed = RDDSKitImages(name: "list_red")
    public static let listWhite = RDDSKitImages(name: "list_white")
    public static let listYellow = RDDSKitImages(name: "list_yellow")
    public static let apple = RDDSKitImages(name: "apple")
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
    public static let cardMBlue = RDDSKitImages(name: "card_m_blue")
    public static let cardMPink = RDDSKitImages(name: "card_m_pink")
    public static let cardMPurple = RDDSKitImages(name: "card_m_purple")
    public static let cardMRed = RDDSKitImages(name: "card_m_red")
    public static let cardMWhite = RDDSKitImages(name: "card_m_white")
    public static let cardMYellow = RDDSKitImages(name: "card_m_yellow")
    public static let cardSBlue = RDDSKitImages(name: "card_s_blue")
    public static let cardSPink = RDDSKitImages(name: "card_s_pink")
    public static let cardSPurple = RDDSKitImages(name: "card_s_purple")
    public static let cardSRed = RDDSKitImages(name: "card_s_red")
    public static let cardSWhite = RDDSKitImages(name: "card_s_white")
    public static let cardSYellow = RDDSKitImages(name: "card_s_yellow")
    public static let feelingLBlank = RDDSKitImages(name: "feeling_L_blank")
    public static let feelingLJoy = RDDSKitImages(name: "feeling_L_joy")
    public static let feelingLSad = RDDSKitImages(name: "feeling_L_sad")
    public static let feelingLScary = RDDSKitImages(name: "feeling_L_scary")
    public static let feelingLShy = RDDSKitImages(name: "feeling_L_shy")
    public static let feelingLStrange = RDDSKitImages(name: "feeling_L_strange")
    public static let feelingMBlank = RDDSKitImages(name: "feeling_m_blank")
    public static let feelingMJoy = RDDSKitImages(name: "feeling_m_joy")
    public static let feelingMSad = RDDSKitImages(name: "feeling_m_sad")
    public static let feelingMScary = RDDSKitImages(name: "feeling_m_scary")
    public static let feelingMShy = RDDSKitImages(name: "feeling_m_shy")
    public static let feelingMStrange = RDDSKitImages(name: "feeling_m_strange")
    public static let feelingSBlank = RDDSKitImages(name: "feeling_s_blank")
    public static let feelingSJoy = RDDSKitImages(name: "feeling_s_joy")
    public static let feelingSSad = RDDSKitImages(name: "feeling_s_sad")
    public static let feelingSScary = RDDSKitImages(name: "feeling_s_scary")
    public static let feelingSShy = RDDSKitImages(name: "feeling_s_shy")
    public static let feelingSStrange = RDDSKitImages(name: "feeling_s_strange")
    public static let feelingXsAll = RDDSKitImages(name: "feeling_xs_all")
    public static let feelingXsBlank = RDDSKitImages(name: "feeling_xs_blank")
    public static let feelingXsBlankSelected = RDDSKitImages(name: "feeling_xs_blank_selected")
    public static let feelingXsJoy = RDDSKitImages(name: "feeling_xs_joy")
    public static let feelingXsJoySelected = RDDSKitImages(name: "feeling_xs_joy_selected")
    public static let feelingXsSad = RDDSKitImages(name: "feeling_xs_sad")
    public static let feelingXsSadSelected = RDDSKitImages(name: "feeling_xs_sad_selected")
    public static let feelingXsScary = RDDSKitImages(name: "feeling_xs_scary")
    public static let feelingXsScarySelected = RDDSKitImages(name: "feeling_xs_scary_selected")
    public static let feelingXsShy = RDDSKitImages(name: "feeling_xs_shy")
    public static let feelingXsShySelected = RDDSKitImages(name: "feeling_xs_shy_selected")
    public static let feelingXsStrange = RDDSKitImages(name: "feeling_xs_strange")
    public static let feelingXsStrangeSelected = RDDSKitImages(name: "feeling_xs_strange_selected")
    public static let homeBackground = RDDSKitImages(name: "home_background")
    public static let icnArrow = RDDSKitImages(name: "icn_arrow")
    public static let icnBack = RDDSKitImages(name: "icn_back")
    public static let icnCalendar = RDDSKitImages(name: "icn_calendar")
    public static let icnClose = RDDSKitImages(name: "icn_close")
    public static let icnGalleryOff = RDDSKitImages(name: "icn_gallery_off")
    public static let icnGalleryOn = RDDSKitImages(name: "icn_gallery_on")
    public static let icnHome = RDDSKitImages(name: "icn_home")
    public static let icnListOff = RDDSKitImages(name: "icn_list_off")
    public static let icnListOn = RDDSKitImages(name: "icn_list_on")
    public static let icnMic = RDDSKitImages(name: "icn_mic")
    public static let icnMicCancel = RDDSKitImages(name: "icn_mic_cancel")
    public static let icnMicM = RDDSKitImages(name: "icn_mic_m")
    public static let icnMicReset = RDDSKitImages(name: "icn_mic_reset")
    public static let icnMicS = RDDSKitImages(name: "icn_mic_s")
    public static let icnMicSave = RDDSKitImages(name: "icn_mic_save")
    public static let icnMicStart = RDDSKitImages(name: "icn_mic_start")
    public static let icnMicStop = RDDSKitImages(name: "icn_mic_stop")
    public static let icnMore = RDDSKitImages(name: "icn_more")
    public static let icnMypageS = RDDSKitImages(name: "icn_mypage_s")
    public static let icnRdVoice = RDDSKitImages(name: "icn_rd_voice")
    public static let icnRdVoiceDisabled = RDDSKitImages(name: "icn_rd_voice_disabled")
    public static let icnRecord = RDDSKitImages(name: "icn_record")
    public static let icnSearch = RDDSKitImages(name: "icn_search")
    public static let icnStart = RDDSKitImages(name: "icn_start")
    public static let icnStop = RDDSKitImages(name: "icn_stop")
    public static let icnStorage = RDDSKitImages(name: "icn_storage")
    public static let rdHomeLogo = RDDSKitImages(name: "rd_home_logo")
    public static let rdSplashLogo = RDDSKitImages(name: "rd_splash_logo")
    public static let rdgoroMark = RDDSKitImages(name: "rdgoro_mark")
    public static let splashBackground = RDDSKitImages(name: "splash_background")

    public static let instaLogo = RDDSKitImages(name: "insta_rogo")
    public static let instaBackground = RDDSKitImages(name: "instaBackground")
    public static let instaCardBlue = RDDSKitImages(name: "insta_card_blue")
    public static let instaCardPink = RDDSKitImages(name: "insta_card_pink")
    public static let instaCardPurple = RDDSKitImages(name: "insta_card_purple")
    public static let instaCardRed = RDDSKitImages(name: "insta_card_red")
    public static let instaCardWhite = RDDSKitImages(name: "insta_card_white")
    public static let instaCardYellow = RDDSKitImages(name: "insta_card_yellow")
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
