//
//  RDTabBarController.swift
//  RD-DSKitTests
//
//  Created by Junho Lee on 2022/09/24.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import UIKit

open class RDTabBarController: UITabBarController {

    private let bottomSafeArea: CGFloat = 34.0
    private let tabBarHeight: CGFloat = 70.0
    
    public let rdTabBar = RDTabBar()
    
    open override var selectedIndex: Int {
        didSet {
            self.rdTabBar.select(at: selectedIndex, notifyDelegate: false)
        }
    }
    
    open override var selectedViewController: UIViewController? {
        didSet {
            self.rdTabBar.select(at: selectedIndex, notifyDelegate: false)
        }
    }
    
    // MARK: - View Life Cycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setLayout()
        setTabBar()
    }
}

// MARK: - UI & Layout

extension RDTabBarController {
    
    private func setUI() {
        self.tabBar.isHidden = true
        setMiddleButton()
    }
    
    private func setLayout() {
        self.view.addSubview(rdTabBar)
        
        rdTabBar.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(self.tabBarHeight + self.bottomSafeArea)
        }
    }
}

// MARK: - Methods

extension RDTabBarController {
    private func setTabBar() {
        self.rdTabBar.select(at: selectedIndex)
        self.rdTabBar.delegate = self
    }
    
    func setMiddleButton() {

        let middleBtn = UIButton(frame: CGRect(x: (self.view.bounds.width / 2)-28, y: -28-8, width: 56, height: 56))
        middleBtn.backgroundColor = .blue
        middleBtn.layer.cornerRadius = 28
        
        self.rdTabBar.addSubview(middleBtn)
        middleBtn.addTarget(self, action: #selector(self.menuButtonAction), for: .touchUpInside)

        self.view.layoutIfNeeded()
    }

    // Menu Button Touch Action
    @objc func menuButtonAction(sender: UIButton) {
        self.selectedIndex = 1   //to select the middle tab. use "1" if you have only 3 tabs.
    }
}

extension RDTabBarController: RDTabBarDelegate {
    func rdTabBar(_ sender: RDTabBar, didSelectItemAt index: Int) {
        self.selectedIndex = index
    }
}
