//
//  DreamRecordPage.swift
//  Presentation
//
//  Created by 김수연 on 2022/12/20.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import UIKit

import RD_DSKit

import RxSwift
import SnapKit

public final class DreamRecordViewController: UIViewController {

    // MARK: - Properties

    private enum Metric {
        static let audioViewTop = 12.f
        static let audioViewLeadingTrailing = 6.f
        static let noteLabelTop = 12.f
    }

    // MARK: - UI Components

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = RDDSKitFontFamily.Pretendard.semiBold.font(size: 14)
        label.textColor = RDDSKitAsset.Colors.white01.color
        label.text = "나의 꿈 기록"
        return label
    }()

    private let placeHolder: UILabel = {
        let label = UILabel()
        label.text = "기록된 내용이 없어요."
        label.font = RDDSKitFontFamily.Pretendard.regular.font(size: 14)
        label.textColor = RDDSKitAsset.Colors.white04.color
        return label
    }()

    private let dreamAudioPlayerView = DreamAudioPlayerView()

    private let noteLabel: UILabel = {
        let label = UILabel()
        label.font = RDDSKitFontFamily.Pretendard.regular.font(size: 14)
        label.textColor = RDDSKitAsset.Colors.white01.color
        label.numberOfLines = 0
        label.text = "우리 학교 앞에 떡볶이집이 하나있음 그래서 군것질이나 할 겸 그 가게에 갔는데 메뉴들이 엄청 맛있어보였음. 막 호떡, 핫도그, 떡볶이, 오뎅 뭐가 많았는데 갑자기 내가 식욕이 터지는거임. 분식집 아줌마는 여유롭게 스몰토크 하면서 핫도그 튀기고 있고. 초조한 시간과 지금이라도 버리고 타야되나? 이런 생각을 했음. "
        return label
    }()
    

    // MARK: - View Life Cycle

    public override func viewDidLoad() {
        super.viewDidLoad()

        self.setUI()
        self.setLayout()
    }

    // MARK: - UI & Layout
    private func setUI() {
        self.view.backgroundColor = .none
        self.noteLabel.addLabelSpacing(kernValue: -0.14, lineSpacing: 5.6)
    }

    private func setLayout() {
        self.view.addSubviews(titleLabel, dreamAudioPlayerView, noteLabel)

        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }

        dreamAudioPlayerView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(Metric.audioViewTop)
            $0.leading.trailing.equalToSuperview().inset(Metric.audioViewLeadingTrailing)
        }

        noteLabel.snp.makeConstraints {
            $0.top.equalTo(dreamAudioPlayerView.snp.bottom).offset(Metric.noteLabelTop)
            $0.leading.trailing.equalToSuperview()
        }
    }
}
