//
//  SegmentedControl.swift
//  Presentation
//
//  Created by 김수연 on 2022/12/20.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import UIKit

import RD_DSKit

import RxSwift

protocol SegmentedControlDelegate: AnyObject {
    func segmentControl(_ segmentControl: SegmentedControl, didChangedOn index: Int)
}

struct SegmentInfo {
    let selectPageColor = RDDSKitAsset.Colors.white01.color
    let notSelectPageColor = RDDSKitAsset.Colors.white03.color

    let selectWidth = 162.adjustedWidth
    let selectHeight = 3.f
    let cornerRadius = 2.f
}

// TODO: - 터치 영역 넓혀야할듯.. 

final class SegmentedControl: UIControl {
    private(set) var segmentInfo: SegmentInfo
    private let buttonTitles: [String]
    private let disposeBag = DisposeBag()

    private var selectorButtons: [UIButton] = []
    private lazy var selectorView: UIControl = {
        let control = UIControl(frame: CGRect(x: .zero, y: -1, width: segmentInfo.selectWidth, height: segmentInfo.selectHeight))
        control.layer.cornerRadius = segmentInfo.cornerRadius
        control.backgroundColor = segmentInfo.selectPageColor
        return control
    }()

    private var buttonWidth: CGFloat { (self.bounds.width / buttonTitles.count.f)}
    public private(set) var selectedIndex: Int = 0

    weak var delegate: SegmentedControlDelegate?

    private init(frame: CGRect, segmentInfo: SegmentInfo, buttonTitles: [String]) {
        self.segmentInfo = segmentInfo
        self.buttonTitles = buttonTitles

        super.init(frame: .zero)
    }

    convenience init(segmentInfo: SegmentInfo = SegmentInfo(), buttonTitles: [String]) {
        self.init(frame: .zero, segmentInfo: segmentInfo, buttonTitles: buttonTitles)
    }

    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
      super.draw(rect)

      drawSegmentControl()
    }
}

// MARK: - Public functions
extension SegmentedControl {
    func selectIndex(_ index: Int, shouldAnimate: Bool) {
        guard 0..<selectorButtons.count ~= index else { return }
        
        selectedIndex = index

        delegate?.segmentControl(self, didChangedOn: selectedIndex)
        sendActions(for: .valueChanged)

        guard shouldAnimate else { return }
        animateSelectedItem(to: buttonWidth * index.f)
    }
}

// MARK: - Private functions
extension SegmentedControl {
    private func drawSegmentControl() {
        createButton()
        configureStackView()
    }

    private func createButton() {
        selectorButtons.removeAll()
        subviews.forEach { $0.removeFromSuperview() }

        buttonTitles.forEach { _ in
            let button = UIButton(type: .custom)
            button.addTarget(self, action: #selector(self.didClickOnButton(sender:)), for: .touchUpInside)
            selectorButtons.append(button)
        }
    }

    private func configureStackView() {
        let containerView = UIView(frame: .zero)
        let stackView = UIStackView(arrangedSubviews: selectorButtons)
        stackView.distribution = .fillEqually
        stackView.backgroundColor = segmentInfo.notSelectPageColor
        stackView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.didReceivePanAction(_:))))

        addSubview(stackView)
        stackView.addSubview(containerView)
        stackView.sendSubviewToBack(containerView)
        stackView.layer.cornerRadius = segmentInfo.cornerRadius

        stackView.snp.makeConstraints {
            $0.directionalEdges.equalToSuperview()
        }

        containerView.addSubview(selectorView)

        containerView.snp.makeConstraints {
            $0.directionalEdges.equalToSuperview()
        }
    }

    private func processSelectedIndex(_ index: Int) {
        Observable.just(index)
            .distinctUntilChanged()
            .asDriver(onErrorDriveWith: .empty())
            .drive { [weak self] index in
                self?.selectedIndex = index
                self?.selectIndex(index, shouldAnimate: false)
            }.disposed(by: self.disposeBag)
    }

    private func animateSelectedItem(to point: CGFloat) {
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.selectorView.frame.origin.x = point
        }
    }
}

// MARK: - Selectors
extension SegmentedControl {
    @objc
    private func didClickOnButton(sender: UIButton) {

        var selectorPosition = selectorView.frame.origin.x

        if selectorPosition == 0.f {
            selectorPosition = buttonWidth
            selectedIndex = 1
        } else {
            selectorPosition = 0.f
            selectedIndex = 0
        }
        

        delegate?.segmentControl(self, didChangedOn: selectedIndex)
        sendActions(for: .valueChanged)
        animateSelectedItem(to: selectorPosition)
    }

    @objc
    private func didReceivePanAction(_ panGesture: UIPanGestureRecognizer) {
        let containerViewWidth = self.bounds.width
        let buttonFrame = self.buttonWidth
        let panLocationXCoordinate = panGesture.location(in: self).x
        let xCoordinateCorrenctionValue = panLocationXCoordinate + (buttonFrame / 2)
        let compensatedXValue: CGFloat

        switch xCoordinateCorrenctionValue {
        case ...buttonFrame:
            compensatedXValue = buttonFrame / 2
        case 0...containerViewWidth:
            compensatedXValue = panLocationXCoordinate
        case containerViewWidth...:
            compensatedXValue = containerViewWidth - (buttonFrame / 2)
        default:
            compensatedXValue = buttonFrame / 2
        }

        switch panGesture.state {
        case .changed:
            selectorView.center.x = compensatedXValue
            self.processSelectedIndex(Int(round(panLocationXCoordinate / containerViewWidth)))
        case .ended:
            let selectorPosition = buttonWidth * selectedIndex.f
            self.animateSelectedItem(to: selectorPosition)
        default: break
        }
    }
}
