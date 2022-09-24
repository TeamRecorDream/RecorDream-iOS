//
//  RDTabBar.swift
//  RD-DSKitTests
//
//  Created by Junho Lee on 2022/09/24.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import UIKit

import SnapKit

protocol RDTabBarDelegate: AnyObject {
    func rdTabBar(_ sender: RDTabBar, didSelectItemAt index: Int)
}

final class RDTabBar: UIView {
    
    // MARK: - Properties
    
    weak var delegate: RDTabBarDelegate?
    
    var itemsArray: [UITabBarItem] = []
    
    private var shapeLayer: CALayer?
    
    override func draw(_ rect: CGRect) {
        self.addShape()
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard !clipsToBounds && !isHidden && alpha > 0 else { return nil }
        for member in subviews.reversed() {
            let subPoint = member.convert(point, from: self)
            guard let result = member.hitTest(subPoint, with: event) else { continue }
            return result
        }
        return nil
    }
    
    override func tintColorDidChange() {
        super.tintColorDidChange()
        
        reloadAppearance()
    }
    
    func reloadAppearance() {
        tabBarItems().forEach { item in
            item.selectedColor = tintColor
        }
    }
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 44.0
        
        return stackView
    }()
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        self.backgroundColor = .clear
    }
    
    private func setLayout() {
        self.addSubview(self.stackView)
        
        let stackWidth: CGFloat = 375 - 156 + 28
        self.stackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(6)
            $0.width.equalTo(stackWidth / 375 * UIScreen.main.bounds.width)
            $0.height.equalTo(48)
        }
    }
    
    func add(items tabBarItems: [UITabBarItem]) {
        for tabBarItem in tabBarItems {
            self.itemsArray.append(tabBarItem)
            self.addItem(with: tabBarItem)
        }
    }
    
    private func addItem(with item: UITabBarItem) {
        let item = RDTabBarItem(forItem: item)
        item.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(itemTapped(_:)))
        item.addGestureRecognizer(tapGestureRecognizer)
        
        item.selectedColor = self.tintColor
        self.stackView.addArrangedSubview(item)
    }
    
    @objc
    private func itemTapped(_ sender: UITapGestureRecognizer) {
        if let customTabBarItem = sender.view as? RDTabBarItem,
           let index = self.stackView.arrangedSubviews.firstIndex(of: customTabBarItem) {
            self.select(at: index)
        }
    }
    
    func select(at selectedIndex: Int, notifyDelegate: Bool = true) {
        for (index, item) in self.stackView.arrangedSubviews.enumerated() {
            if let item = item as? RDTabBarItem {
                item.isSelected = index == selectedIndex ? true : false
            }
        }
        
        if notifyDelegate {
            self.delegate?.customTabBar(self, didSelectItemAt: selectedIndex)
        }
    }
    
    private func tabBarItems() -> [RDTabBarItem] {
        return self.stackView.arrangedSubviews.compactMap { $0 as? RDTabBarItem }
    }
}

// MARK: Draw Shape

extension RDTabBar {
    
    private func addShape() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = createPath()
        shapeLayer.strokeColor = UIColor.lightGray.cgColor
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.lineWidth = 1.0
        
        shapeLayer.shadowOffset = CGSize(width:0, height:0)
        shapeLayer.shadowRadius = 10
        shapeLayer.shadowColor = UIColor.gray.cgColor
        shapeLayer.shadowOpacity = 0.3

        if let oldShapeLayer = self.shapeLayer {
            self.layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            self.layer.insertSublayer(shapeLayer, at: 0)
        }
        self.shapeLayer = shapeLayer
    }

    func createPath() -> CGPath {
        let height: CGFloat = 37.0
        let path = UIBezierPath()
        let centerWidth = self.frame.width / 2
        path.move(to: CGPoint(x: 0, y: 0)) // top left에서 시작하여 그린다
        path.addLine(to: CGPoint(x: (centerWidth - height * 2), y: 0))

        path.addCurve(to: CGPoint(x: centerWidth, y: height),
        controlPoint1: CGPoint(x: (centerWidth - 30), y: 0), controlPoint2: CGPoint(x: centerWidth - 40, y: height))

        path.addCurve(to: CGPoint(x: (centerWidth + height * 2), y: 0),
        controlPoint1: CGPoint(x: centerWidth + 40, y: height), controlPoint2: CGPoint(x: (centerWidth + 30), y: 0))

        path.addLine(to: CGPoint(x: self.frame.width, y: 0))
        path.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
        path.addLine(to: CGPoint(x: 0, y: self.frame.height))
        path.close()

        return path.cgPath
    }
}


