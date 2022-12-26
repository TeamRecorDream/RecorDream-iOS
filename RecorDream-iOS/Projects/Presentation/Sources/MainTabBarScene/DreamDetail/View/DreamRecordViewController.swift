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

    }

    // MARK: - UI Components

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = RDDSKitFontFamily.Pretendard.semiBold.font(size: 14)
        label.textColor = RDDSKitAsset.Colors.white01.color
        label.text = "나의 꿈 기록"
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
    }

    private func setLayout() {
        self.view.addSubviews(titleLabel)

        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
    }
}
