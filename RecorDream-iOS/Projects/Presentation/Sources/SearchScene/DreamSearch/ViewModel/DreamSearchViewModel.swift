//
//  DreamSearchViewModel.swift
//  Presentation
//
//  Created by 정은희 on 2022/11/08.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import Foundation

import Domain
import RD_Network
import RxSwift
import HeeKit

final class DreamSearchViewModel {
    // Input
    private var provider: DefaultSearchService!
    private var collectionViewDataSource: [DreamSearchResultViewModel] = [] // 서브 뷰모델에 해당
    private var currentSearchQuery = ""
    // Output
    var numberOfItems: Int = 0
    // Observer input
    var searchResults = PublishSubject<[DreamSearchResult]>()
    var cellSelected = PublishSubject<DreamSearchResultViewModel>()
    var reloadCollectionViewData = PublishSubject<Bool>()
    var cancelButtonTapped = PublishSubject<Void>()
    var searchQuery = PublishSubject<String>()
    
    private var disposeBag = DisposeBag()
    
    init(provider: DefaultSearchService = DefaultSearchService.shared) {
        self.provider = provider
        self.initialize()
    }
}

extension DreamSearchViewModel {
    func initialize() {
        searchQuery
            .asObservable()
            .observe(on: MainScheduler.instance)
            .flatMapLatest { query -> Observable<[DreamSearchResult]> in
                Log.event(type: .info, "사용자가 \(query)에 대한 검색을 시작함")
                self.currentSearchQuery = query
                self.resetCollectionViewDataSource()
                
                return self.searchItemsForTerm()
                    .catch { error -> Observable<[DreamSearchResult]> in
                        self.reloadCollectionViewData.onNext(true)
                        return Observable.empty()
                    }
            }.subscribe(onNext: { results in
                if results.isEmpty {
                    self.reloadCollectionViewData.onNext(true)
                }
                else {
                    self.prepareCollectionViewDataSource(results: results)
                    self.reloadCollectionViewData.onNext(true)
                }
            })
            .disposed(by: disposeBag)
        
        cancelButtonTapped
            .asObservable()
            .subscribe(onNext: { [weak self] _ in
                self?.resetCollectionViewDataSource()
                self?.reloadCollectionViewData.onNext(true)
            }).disposed(by: disposeBag)
    }
}

extension DreamSearchViewModel {
    func prepareCollectionViewDataSource(results: [DreamSearchResult]) {
        self.numberOfItems = numberOfItems + results.count
        let preparedData = results.map { DreamSearchResultViewModel(dreamSearchResultModel: $0) }
        self.collectionViewDataSource.append(contentsOf: preparedData)
    }
    func searchItemsForTerm() -> Observable<[DreamSearchResult]> {
        return Observable.create({ [weak self] observer -> Disposable in
            guard let self = self else { return }
            self.provider.searchDreamRecords(keyword: self.currentSearchQuery) { result in
                switch result {
                case .success(let searchResponse):
                    if searchResponse.results.isEmpty {
                        Log.event(type: .error, "검색 결과가 존재하지 않습니다요")
                        observer.onError(CustomError.search(type: .notFound))
                    }
                    else {
                        observer.onNext(searchResponse.results)
                        observer.onCompleted()
                    }
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        })
    }
    func getViewModelForCell(indexPathAtRow: Int) -> DreamSearchResultViewModel {
        return collectionViewDataSource[indexPathAtRow]
    }
    private func resetCollectionViewDataSource() {
        Log.event(type: .info, "사용자가 취소 버튼 누름 -> 검색 데이터를 삭제하자!")
        numberOfItems = 0
        collectionViewDataSource = []
    }
}
