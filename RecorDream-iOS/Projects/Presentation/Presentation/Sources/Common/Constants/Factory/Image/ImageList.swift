//
//  ImageList.swift
//  Presentation
//
//  Created by 정은희 on 2022/09/23.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import UIKit

enum ImageList: String, CaseIterable {
    // MARK: - Components
    case backgroundBlue = "background_blue"
    case backgroundPink = "background_pink"
    case backgroundPurple = "background_purple"
    case backgroundRed = "background_red"
    case backgroundWhite = "background_white"
    case backgroundYellow = "background_yellow"
    case cardLBlue = "card_l_blue"
    case cardLPink = "card_l_pink"
    case cardLPurple = "card_l_purple"
    case cardLRed = "card_l_red"
    case cardLWhite = "card_l_white"
    case cardLYellow = "card_l_yellow"
    case cardMBlue1 = "card_m_blue-1"
    case cardMBlue = "card_m_blue"
    case cardMPink = "card_m_pink"
    case cardMRed = "card_m_red"
    case cardMWhite = "card_m_white"
    case cardMYellow = "card_m_yellow"
    case cardSBlue = "card_s_blue"
    case cardSPink = "card_s_pink"
    case cardSPurple = "card_s_purple"
    case cardSRed = "card_s_red"
    case cardSWhite = "card_s_white"
    case cardSYellow = "card_s_yellow"
    case homeBackground = "home_background"
    
    // MARK: - Icons
    // Feeling
    case feelingLBlank = "feeling_L_blank"
    case feelingLJoy = "feeling_L_joy"
    case feelingLSad = "feeling_L_sad"
    case feelingLScary = "feeling_L_scary"
    case feelingLShy = "feeling_L_shy"
    case feelingLStrange = "feeling_L_strange"
    case feelingMBlank = "feeling_m_blank"
    case feelingMJoy = "feeling_m_joy"
    case feelingMSad = "feeling_m_sad"
    case feelingMScary = "feeling_m_scary"
    case feelingMShy = "feeling_m_shy"
    case feelingMStrange = "feeling_m_strange"
    case feelingSBlank = "feeling_s_blank"
    case feelingSJoy = "feeling_s_joy"
    case feelingSSad = "feeling_s_sad"
    case feelingSScary = "feeling_s_scary"
    case feelingSShy = "feeling_s_shy"
    case feelingSStrange = "feeling_s_strange"
    case feelingXSAll = "feeling_xs_all"
    case feelingXSBlank = "feeling_xs_blank"
    case feelingXSJoy = "feeling_xs_joy"
    case feelingXSSad = "feeling_xs_sad"
    case feelingXSScary = "feeling_xs_scary"
    case feelingXSShy = "feeling_xs_shy"
    case feelingXSStrange = "feeling_xs_strange"
    
    // Icon
    case icnArrow = "icn_arrow"
    case icnBack = "document_bg_blue"
    case icnCalendar = "document_bg_dark"
    case icnClose1 = "document_bg_green"
    case icnClose = "document_bg_orange"
    case icnGalleryOff = "document_bg_pink"
    case icnGalleryOn = "document_bg_purple"
    case icnListOff = "colorchip_red_on"
    case icnListOn = "colorchip_blue_on"
    case icnMicCancel = "colorchip_green_on"
    case icnMicM = "colorchip_orange_on"
    case icnMicReset = "colorchip_pink_on"
    case icnMicS = "colorchip_purple_on"
    case icnMicSave = "icn_mic_save"
    case icnMicStart = "icn_mic_start"
    case icnMicStop = "icn_mic_stop"
    case icnMpre = "icn_mpre"
    case icnMypage1 = "icn_mypage-1"
    case icnMypage = "icn_mypage"
    case icnRDVoice = "icn_rd_voice"
    case icnRecord = "icn_record"
    case icnSearch = "icn_search"
    case icnStart = "icn_start"
    case icnStop = "icn_stop"
    case icnStorage1 = "icn_storage-1"
    case icnStorage = "icn_storage"
    case navibarBtnRecord = "navibar_btn_record"
    case navibar = "navibar"
    case RDHomeRogo = "rd_home_rogo"
    case RDSplashRogo = "rd_splash_rogo"
    case RDrogoMark = "rdgoro_mark"
    case listBlus = "list_blue"
    case listPink = "list_pink"
    case listPurple = "list_purple"
    case listRed = "list_red"
    case listWhite = "list_white"
    case listYellow = "list_yellow"
    case splashBackground = "splash_background"

    var name: String {
        return self.rawValue
    }
}
