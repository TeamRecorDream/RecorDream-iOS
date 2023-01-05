//
//  RDTabBarController.swift
//  RD-DSKitTests
//
//  Created by Junho Lee on 2022/09/24.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import UIKit

import SnapKit

open class RDTabBarController: UITabBarController {

    private let bottomSafeArea: CGFloat = 34.0
    private let tabBarHeight: CGFloat = 70.0
    
    public var middleButtonAction: (()->Void)?
    
    public let rdTabBar = RDTabBar()
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.black.cgColor
        layer.path = self.createPath()
        view.layer.addSublayer(layer)
        return view
    }()
    
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
        self.view.addSubviews(backgroundView, rdTabBar)
        
        [backgroundView, rdTabBar].forEach {
            $0.snp.makeConstraints {
                $0.leading.trailing.bottom.equalToSuperview()
                $0.height.equalTo(self.tabBarHeight + self.bottomSafeArea)
            }
        }
    }
    
    public func setTabBarHidden(_ isHidden: Bool = true) {
        self.rdTabBar.isHidden = isHidden
        self.backgroundView.isHidden = isHidden
    }
}

// MARK: - Methods

extension RDTabBarController {
    private func setTabBar() {
        self.rdTabBar.select(at: selectedIndex)
        self.rdTabBar.delegate = self
    }
    
    private func setMiddleButton() {

        let middleBtn = UIButton(frame: CGRect(x: (self.view.bounds.width / 2)-28, y: -28-8, width: 56, height: 56))
        middleBtn.backgroundColor = .black
        middleBtn.layer.cornerRadius = 28
        self.rdTabBar.addSubview(middleBtn)
        middleBtn.addTarget(self, action: #selector(self.menuButtonAction), for: .touchUpInside)
        
        self.addShadowLayer(at: middleBtn)
        
        let plusImage = UIImageView(frame: CGRect(x: 28-12, y: 28-12, width: 24, height: 24))
        plusImage.image = RDDSKitAsset.Images.icnRecord.image
        middleBtn.addSubview(plusImage)
    }
    
    private func addShadowLayer(at btn: UIButton) {
        let outerDropShadowLayer = CAShapeLayer()
        outerDropShadowLayer.frame = btn.bounds
        outerDropShadowLayer.applyShadow(color: UIColor(rgb: 0x000000), alpha: 0.2, x: 0, y: -5, blur: 20, spread: 0)
        btn.layer.insertSublayer(outerDropShadowLayer, at: 1)
        
        let innerShadowLayer = CAShapeLayer()
        innerShadowLayer.frame = btn.bounds
        innerShadowLayer.applyShadow(color: UIColor(rgb: 0xC8CADA), alpha: 0.28, x: 0, y: 0, blur: 13, spread: 0)
        innerShadowLayer.masksToBounds = true
        innerShadowLayer.cornerRadius = 28
        btn.layer.insertSublayer(innerShadowLayer, at: 2)

        self.view.layoutIfNeeded()
        btn.layoutSubviews()
        
        outerDropShadowLayer.shadowPath = UIBezierPath(roundedRect: btn.bounds, cornerRadius: 28).cgPath
        
        let innerPath = UIBezierPath(roundedRect: btn.bounds.insetBy(dx: -5, dy: -5), cornerRadius: 28)
        let cutout = UIBezierPath(roundedRect: btn.bounds, cornerRadius: 28).reversing()
        innerPath.append(cutout)
        innerShadowLayer.shadowPath = innerPath.cgPath
    }
    
    private func createPath() -> CGPath {
        let curveHeight: CGFloat = 37.0
        let path = UIBezierPath()
        let centerWidth = UIScreen.main.bounds.width / 2
        let tabBarheight = self.tabBarHeight + self.bottomSafeArea
        
        path.move(to: CGPoint(x: 0, y: 0)) // top left에서 시작하여 그린다
        path.addLine(to: CGPoint(x: (centerWidth - curveHeight * 2), y: 0))

        path.addCurve(to: CGPoint(x: centerWidth, y: curveHeight),
        controlPoint1: CGPoint(x: (centerWidth - 30), y: 0), controlPoint2: CGPoint(x: centerWidth - 40, y: curveHeight))

        path.addCurve(to: CGPoint(x: (centerWidth + curveHeight * 2), y: 0),
        controlPoint1: CGPoint(x: centerWidth + 40, y: curveHeight), controlPoint2: CGPoint(x: (centerWidth + 30), y: 0))

        path.addLine(to: CGPoint(x: UIScreen.main.bounds.width, y: 0))
        path.addLine(to: CGPoint(x: UIScreen.main.bounds.width, y: tabBarheight))
        path.addLine(to: CGPoint(x: 0, y: tabBarheight))
        path.close()

        return path.cgPath
    }

    @objc func menuButtonAction(sender: UIButton) {
        self.middleButtonAction?()
    }
}

extension RDTabBarController: RDTabBarDelegate {
    func rdTabBar(_ sender: RDTabBar, didSelectItemAt index: Int) {
        self.selectedIndex = index
    }
}
