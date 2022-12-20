//
//  DetailRecordPageViewController.swift
//  Presentation
//
//  Created by 김수연 on 2022/12/20.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import UIKit

import RD_DSKit

import RxSwift

final class DetailRecordPageViewController: UIView {

    private enum Metric {
        static let segmentControlHeight = 1.f
        static let segmentControlWidth = 324.adjustedWidth
        static let segmentControlTopBottom = 20.f
    }

    private let pageViewController = UIPageViewController(
        transitionStyle: .scroll,
        navigationOrientation: .horizontal)

    private let segmentedControl: RDSegmentedControl
    private let segmentTitles: [String]

    private var contentPages: [UIViewController] = []
    private var currentPageIndex: Int = 0

    private let disposeBag = DisposeBag()

    init(segmentTitles: [String], on viewController: UIViewController) {
        self.segmentedControl = RDSegmentedControl(buttonTitles: segmentTitles)
        self.segmentTitles = segmentTitles

        super.init(frame: .zero)
        
        initailize()
        setLayouts()

        viewController.addChild(pageViewController)
        pageViewController.didMove(toParent: viewController)
    }

    private func initailize() {
        addSubview(segmentedControl)
        addSubview(pageViewController.view)

        segmentedControl.delegate = self
        pageViewController.delegate = self
        pageViewController.dataSource = self
    }

    private func setLayouts() {
        let segmentWidth = segmentedControl
            .segmentInfo
            .selectWidth * segmentTitles.count.f

        segmentedControl.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).inset(Metric.segmentControlTopBottom)
            $0.height.equalTo(Metric.segmentControlHeight)
            $0.width.equalTo(segmentWidth)
            $0.centerX.equalToSuperview()
        }

        pageViewController.view.snp.makeConstraints {
            $0.top.equalTo(segmentedControl.snp.bottom).offset(Metric.segmentControlTopBottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - Public functions
extension DetailRecordPageViewController {
    func setTabContentsItem(contentPages: [UIViewController]) {
        self.contentPages = contentPages
        movePage(from: 0, to: 0, animated: true)
    }
}

extension DetailRecordPageViewController {
    private func movePage(from currentIndex: Int, to targetIndex: Int, animated: Bool) {
        guard let targetPage = contentPages.safeget(index: targetIndex) else { return }

        let direction: UIPageViewController.NavigationDirection =
        currentIndex < targetIndex ? .forward : .reverse

        self.pageViewController
            .setViewControllers([targetPage], direction: direction, animated: true)
        { isCompleted in }
    }
}

extension DetailRecordPageViewController: SegmentedControlDelegate {
    func segmentControl(_ segmentControl: RDSegmentedControl, didChangedOn index: Int) {
        movePage(from: currentPageIndex, to: index, animated: true)
        currentPageIndex = index
    }
}

extension DetailRecordPageViewController: UIPageViewControllerDelegate { }

extension DetailRecordPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = contentPages.firstIndex(of: viewController) else { return nil }

        return contentPages.safeget(index: index - 1)
    }

    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = contentPages.firstIndex(of: viewController) else { return nil }

        return contentPages.safeget(index: index + 1)
    }

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard finished,
              completed,
              let currentViewController = pageViewController.viewControllers?.first,
              let targetIndex = contentPages.lastIndex(of: currentViewController)
        else { return }

        currentPageIndex = targetIndex
        segmentedControl.selectIndex(targetIndex, shouldAnimate: true)
    }
}
