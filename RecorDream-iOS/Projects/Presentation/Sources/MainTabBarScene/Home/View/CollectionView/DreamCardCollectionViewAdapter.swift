//
//  DreamCardCollectionViewAdapter.swift
//  PresentationTests
//
//  Created by 김수연 on 2022/10/24.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import Foundation
import UIKit

import Domain
import RD_Core
import RD_DSKit

/*
 DreamCardCollectionViewAdapter : MVVM에서 분류하자면 View에 해당
 ViewController의 부담을 줄여주기 위해 Class를 분리한 것 일뿐 따로 ViewModel을 가지고 있지 않습니다.
 => ViewController의 ViewModel 객체나 데이터 Array 혹은 관련 로직을 중복해서 가지고 있지 말자.

 필요한 데이터는 CollectionViewAdapterDataSource Protocol을 통해 모두 가져오기
 */

protocol DreamCardCollectionViewAdapterDataSource: AnyObject {
    // ViewModel이 채택하여 관련 데이터 넘겨주기 , DataSource에 들어갈 정보들
    var numberOfItems: Int { get }
    var fetchedDreamRecord: HomeEntity { get }
}

final class DreamCardCollectionViewAdapter: NSObject {

    private enum Metric {
        static let cellWidth = 264.f
        static let cellHeight = 392.f
    }

    weak var adapterDataSource: DreamCardCollectionViewAdapterDataSource?

    init(collectionView: UICollectionView, adapterDataSource: DreamCardCollectionViewAdapterDataSource) {
        super.init()

        self.setCollectionView(for: collectionView)
        DreamCardCVC.register(target: collectionView)
        self.adapterDataSource = adapterDataSource
    }

    private func setCollectionView(for collectionView: UICollectionView) {
        collectionView.backgroundColor = .none
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.decelerationRate = .fast
        collectionView.isPagingEnabled = false

        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension DreamCardCollectionViewAdapter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return adapterDataSource?.numberOfItems ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DreamCardCVC.className, for: indexPath) as? DreamCardCVC else { return .init() }

        if let dreamRecord = adapterDataSource?.fetchedDreamRecord.records?.safeget(index: indexPath.row) {
            cell.setData(model: dreamRecord)
        }

        return cell
    }
}

extension DreamCardCollectionViewAdapter: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        // adapterDataSource?.fetchNextItemsIfNeeded(indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
}

// MARK: CaruselLayout
public class CarouselLayout: UICollectionViewFlowLayout {

    private enum Metric {
        static let cellHeight = 392.f
        static let cellSideHeight = 337.f

        static let spacing = 16.f
    }

    public var sideItemScale: CGFloat = Metric.cellSideHeight/Metric.cellHeight
    public var sideItemAlpha: CGFloat = 0.4
    public var isPagingEnabled: Bool = false

    private var isSetup: Bool = false

    override public func prepare() {
        super.prepare()
        if isSetup == false {
            setupLayout()
            isSetup = true
        }
    }

    // prepare() 가 처음으로 호출될 때 컬렉션 뷰에 대한 초기 설정을 하기 위해, setupLayout()이라는 함수 만듬.
    private func setupLayout() {
        guard let collectionView = self.collectionView else {return}

        let collectionViewSize = collectionView.bounds.size
        let itemWidth = self.itemSize.width
        let itemHeight = self.itemSize.height

        let xInset = (collectionViewSize.width - itemWidth) / 2
        let yInset = (collectionViewSize.height - itemHeight) / 2

        self.sectionInset = UIEdgeInsets(top: yInset, left: xInset, bottom: yInset, right: xInset)

        let scaledItemOffset =  (itemWidth - itemWidth*self.sideItemScale) / 2
        self.minimumLineSpacing = Metric.spacing - scaledItemOffset

        self.scrollDirection = .horizontal
    }

    // true: 사용자가 스크롤 시 prepare()를 통해 레이아웃 업데이트가 가능하게끔 합니다.
    public override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }

    // 모든 셀과 뷰에 대한 레이아웃 속성을  UICollectionViewLayoutAttributes 배열로 반환하는데
    // 이 속성을 변환해서 반환할 거기 때문에 고차 함수 map을 사용
    public override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let superAttributes = super.layoutAttributesForElements(in: rect),
            let attributes = NSArray(array: superAttributes, copyItems: true) as? [UICollectionViewLayoutAttributes]
            else { return nil }

        return attributes.map({ self.transformLayoutAttributes(attributes: $0) })
    }

    private func transformLayoutAttributes(attributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {

        guard let collectionView = self.collectionView else {return attributes}

        let collectionCenter = collectionView.frame.size.width / 2
        let contentOffset = collectionView.contentOffset.x
        let center = attributes.center.x - contentOffset

        let maxDistance = self.itemSize.width + self.minimumLineSpacing
        let distance = min(abs(collectionCenter - center), maxDistance)

        let ratio = (maxDistance - distance)/maxDistance

        let alpha = ratio * (1 - self.sideItemAlpha) + self.sideItemAlpha
        let scale = ratio * (1 - self.sideItemScale) + self.sideItemScale

        attributes.alpha = alpha

        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
        let dist = attributes.frame.midX - visibleRect.midX
        var transform = CATransform3DScale(CATransform3DIdentity, scale, scale, 1)
        transform = CATransform3DTranslate(transform, 0, 0, -abs(dist/1000))
        attributes.transform3D = transform

        return attributes
    }


    // targetContentOffset 메서드는 스크롤을 중지할 지점을 찾아서 반환하는 메소드
    public override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {

        guard let collectionView = self.collectionView else {
            let latestOffset = super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
            return latestOffset
        }

        let targetRect = CGRect(x: proposedContentOffset.x, y: 0, width: collectionView.frame.width, height: collectionView.frame.height)
        guard let rectAttributes = super.layoutAttributesForElements(in: targetRect) else { return .zero }

        var offsetAdjustment = CGFloat.greatestFiniteMagnitude
        let horizontalCenter = proposedContentOffset.x + collectionView.frame.width / 2

        for layoutAttributes in rectAttributes {
            let itemHorizontalCenter = layoutAttributes.center.x
            if (itemHorizontalCenter - horizontalCenter).magnitude < offsetAdjustment.magnitude {
                offsetAdjustment = itemHorizontalCenter - horizontalCenter
            }
        }

        return CGPoint(x: proposedContentOffset.x + offsetAdjustment, y: proposedContentOffset.y)
    }
}
