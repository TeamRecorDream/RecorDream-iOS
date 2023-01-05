//
//  DreamWriteVC.swift
//  RD-Navigator
//
//  Created by Junho Lee on 2022/09/29.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import UIKit

import Domain
import RD_Core
import RD_DSKit

import RxSwift
import RxCocoa

public class DreamWriteVC: UIViewController {
    
    // MARK: - Properties
    
    private let disposeBag = DisposeBag()
    
    public var factory: ViewControllerFactory!
    public var viewModel: DreamWriteViewModel!
    private var viewModelType: DreamWriteViewModel.DreamWriteViewModelType {
        return viewModel.viewModelType
    }
    
    lazy var dataSource: UICollectionViewDiffableDataSource<Section, AnyHashable>! = nil
    
    private let datePicked = PublishRelay<String>()
    private let voiceRecorded = PublishRelay<Data?>()
    private let titleTextChanged = PublishRelay<String>()
    private let contentTextChanged = PublishRelay<String>()
    private let emotionChagned = PublishRelay<Int?>()
    private let genreListChagned = PublishRelay<[Int]?>()
    private let noteTextChanged = PublishRelay<String>()
    
    // MARK: - UI Components
    
    private lazy var naviBar: RDNaviBar = {
        let naviBar = RDNaviBar()
        var title: String {
            if case .write = self.viewModelType {
                return "기록하기"
            } else {
                return "수정하기"
            }
        }
        return naviBar.title(title)
    }()
    
    private lazy var dreamWriteCollectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: self.createLayout())
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = RDDSKitAsset.Colors.dark.color
        cv.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        cv.allowsMultipleSelection = true
        return cv
    }()
    
    private var mainCell: DreamWriteMainCVC?
    
    private var warningFooter: DreamWriteWarningFooter?
    
    private lazy var saveButton = DreamWriteSaveButton()
        .title("저장하기")
    
    private let backGroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.4)
        view.isUserInteractionEnabled = false
        view.alpha = 0
        return view
    }()
    
    private let datePickerView = RDDateTimePickerView()
        .viewType(.date)
        .enablePanGesture()
    
    private let recordView = DreamWriteRecordView()
    
    // MARK: - View Life Cycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
        self.setLayout()
        self.setDelegate()
        self.registerReusables()
        self.setGesture()
        self.setDataSource()
        self.applySnapshot()
        self.bindViewModels()
        self.bindViews()
    }
}

// MARK: - UI & Layout

extension DreamWriteVC {
    
    private func setUI() {
        self.view.backgroundColor = RDDSKitAsset.Colors.dark.color
    }
    
    private func setLayout() {
        self.view.addSubviews(dreamWriteCollectionView, naviBar, saveButton,
                              backGroundView, recordView, datePickerView)
        
        dreamWriteCollectionView.snp.makeConstraints { make in
            make.top.equalTo(naviBar.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        naviBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(44)
        }
        
        saveButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(88)
            make.bottom.equalToSuperview()
        }
        
        backGroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        recordView.snp.updateConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(327.adjustedH)
            make.top.equalToSuperview().inset(UIScreen.main.bounds.height)
        }
        
        datePickerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(340.adjustedH)
            make.top.equalToSuperview().inset(UIScreen.main.bounds.height)
        }
    }
}

// MARK: - Methods

extension DreamWriteVC {
    
    private func setDelegate() {
        dreamWriteCollectionView.delegate = self
    }
    
    private func registerReusables() {
        DreamWriteMainCVC.register(target: dreamWriteCollectionView)
        DreamWriteEmotionCVC.register(target: dreamWriteCollectionView)
        DreamWriteGenreCVC.register(target: dreamWriteCollectionView)
        DreamWriteNoteCVC.register(target: dreamWriteCollectionView)
        DreamWriteHeader.register(target: dreamWriteCollectionView)
        DreamWriteWarningFooter.register(target: dreamWriteCollectionView)
        DreamWriteDividerView.register(target: dreamWriteCollectionView)
    }
    
    private func setGesture() {
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:))))
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            view.endEditing(true)
        }
        sender.cancelsTouchesInView = false
    }

    private func notificateDismiss() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "dismissModify"), object: nil)
    }
}

// MARK: - Bind

extension DreamWriteVC {
    
    private func bindViewModels() {
        let input = DreamWriteViewModel.Input(viewDidLoad: Observable.just(()),
                                              datePicked: self.datePicked.asObservable(),
                                              voiceRecorded: self.voiceRecorded.asObservable(),
                                              titleTextChanged: self.titleTextChanged.asObservable(),
                                              contentTextChanged: self.contentTextChanged.asObservable(),
                                              emotionChagned: self.emotionChagned.asObservable(),
                                              genreListChagned: self.genreListChagned.asObservable(),
                                              noteTextChanged: self.noteTextChanged.asObservable(),
                                              saveButtonTapped: self.saveButton.rx.tap.asObservable())
        let output = self.viewModel.transform(from: input, disposeBag: self.disposeBag)
        
        output.writeButtonEnabled
            .skip(1)
            .bind(to: self.saveButton.rx.isEnabled)
            .disposed(by: self.disposeBag)
        
        output.dreamWriteModelFetched
            .compactMap { $0 }
            .withUnretained(self)
            .subscribe { (strongSelf, entity) in
                strongSelf.applySnapshot(model: entity)
            }.disposed(by: self.disposeBag)
        
        output.showGenreCountCaution
            .withUnretained(self)
            .bind { (strongSelf, shouldShow) in
                strongSelf.warningFooter?.shouldShowCaution = shouldShow
            }.disposed(by: self.disposeBag)
        
        output.writeRequestSuccess
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }

                switch self.viewModelType {
                case .modify:
                    self.notificateDismiss()
                    self.dismiss(animated: true)

                    let presentingVC = self.presentingViewController
                    presentingVC?.dismiss(animated: true)
                case .write:
                    self.dismiss(animated: true)
                }
            }).disposed(by: self.disposeBag)
        
        output.loadingStatus
            .bind(to: self.rx.isLoading)
            .disposed(by: self.disposeBag)
    }
    
    private func bindViews() {
        naviBar.leftButtonTapped.subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            self.dismiss(animated: true)
        }).disposed(by: self.disposeBag)
        
        recordView.recordOutput.subscribe(onNext: { [weak self] dataTimeTuple in
            guard let self = self else { return }
            self.dismissVoiceRecordView()
            guard let voiceData = dataTimeTuple?.0,
                  let totalTime = dataTimeTuple?.1 else { return }
            self.voiceRecorded.accept(voiceData)
            self.mainCell?.recordUpdated(record: totalTime)
        }).disposed(by: self.disposeBag)
        
        datePickerView.dateTimeOutput.subscribe(onNext: { [weak self] dateOutput in
            guard let self = self else { return }
            self.dismissDatePickerView()
            guard let date = dateOutput else { return }
            self.datePicked.accept(date)
            self.mainCell?.dateChanged(date: date)
        }).disposed(by: self.disposeBag)
    }
}


// MARK: - DiffableDataSource

extension DreamWriteVC {
    private func setDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, AnyHashable>(collectionView: dreamWriteCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            switch Section.type(indexPath.section) {
            case .main:
                guard let mainCell = collectionView.dequeueReusableCell(withReuseIdentifier: DreamWriteMainCVC.className, for: indexPath) as? DreamWriteMainCVC else { return UICollectionViewCell() }
                self.mainCell = mainCell
                if let model = itemIdentifier as? DreamWriteEntity.Main {
                    mainCell.setData(model: model,
                                     isModifyView: self.viewModelType.isModifyView)
                }
                mainCell.titleTextChanged
                    .bind(to: self.titleTextChanged)
                    .disposed(by: self.disposeBag)
                mainCell.contentTextChanged
                    .bind(to: self.contentTextChanged)
                    .disposed(by: self.disposeBag)
                mainCell.interactionViewTapped.subscribe(onNext: { [weak self] viewType in
                    guard let self = self else { return }
                    switch viewType {
                    case .date:
                        self.dateInteractionViewTapped()
                    case .voiceRecord(let isEnabled):
                        if isEnabled {
                            self.voiceRecordInteractionViewTapped()
                        } else if self.viewModelType.isModifyView {
                            self.showToast(message: "수정하기에서는 녹음할 수 없어요.")
                        }
                    }
                }).disposed(by: self.disposeBag)
                return mainCell
            case .emotions:
                guard let emotionsCell = collectionView.dequeueReusableCell(withReuseIdentifier: DreamWriteEmotionCVC.className, for: indexPath) as? DreamWriteEmotionCVC else { return UICollectionViewCell() }
                emotionsCell.setData(selectedImage: Section.emotionImages[indexPath.row],
                                     deselectedImage: Section.emotionDeselectedImages[indexPath.row],
                                     text: Section.emotionTitles[indexPath.row])
                if let model = itemIdentifier as? DreamWriteEntity.Emotion {
                    if model.isSelected {
                        collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .bottom)
                        collectionView.scrollToItem(at: IndexPath.init(item: 0, section: 0), at: .top, animated: false)
                    }
                }
                return emotionsCell
            case .genres:
                guard let genresCell = collectionView.dequeueReusableCell(withReuseIdentifier: DreamWriteGenreCVC.className, for: indexPath) as? DreamWriteGenreCVC else { return UICollectionViewCell() }
                genresCell.setData(text: Section.genreTitles[indexPath.row])
                if let model = itemIdentifier as? DreamWriteEntity.Genre {
                    if model.isSelected { collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .centeredHorizontally) }
                }
                return genresCell
            case .note:
                guard let noteCell = collectionView.dequeueReusableCell(withReuseIdentifier: DreamWriteNoteCVC.className, for: indexPath) as? DreamWriteNoteCVC else { return UICollectionViewCell() }
                if let model = itemIdentifier as? DreamWriteEntity.Note {
                    noteCell.setData(noteText: model.noteText)
                }
                noteCell.noteTextChanged
                    .bind(to: self.noteTextChanged)
                    .disposed(by: self.disposeBag)
                return noteCell
            }
        })
        
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            switch kind {
            case DreamWriteHeader.className:
                guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: DreamWriteHeader.className, for: indexPath) as? DreamWriteHeader else { return UICollectionReusableView() }
                let sectionType = Section.type(indexPath.section)
                view.title = sectionType.title
                return view
            case DreamWriteWarningFooter.className:
                guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: DreamWriteWarningFooter.className, for: indexPath) as? DreamWriteWarningFooter else { return UICollectionReusableView() }
                self.warningFooter = view
                if let showWarning = self.viewModel.shouldShowWarningForInit {
                    self.warningFooter?.shouldShowCaution = showWarning
                }
                return view
            case DreamWriteDividerView.className:
                guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: DreamWriteDividerView.className, for: indexPath) as? DreamWriteDividerView else { return UICollectionReusableView() }
                return view
            default: return UICollectionReusableView()
            }
        }
    }
    
    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>()
        snapshot.appendSections([.main, .emotions, .genres, .note])
        snapshot.appendItems([1], toSection: .main)
        snapshot.appendItems([3,4,5,6,7], toSection: .emotions)
        snapshot.appendItems([8,9,10,11,12,13,14,15,16,17], toSection: .genres)
        snapshot.appendItems([18], toSection: .note)
        dataSource.apply(snapshot, animatingDifferences: false)
        self.view.setNeedsLayout()
    }
    
    private func applySnapshot(model: DreamWriteEntity) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>()
        snapshot.appendSections([.main, .emotions, .genres, .note])
        snapshot.appendItems([model.main], toSection: .main)
        snapshot.appendItems(model.emotions, toSection: .emotions)
        snapshot.appendItems(model.genres, toSection: .genres)
        snapshot.appendItems([model.note], toSection: .note)
        dataSource.apply(snapshot, animatingDifferences: false)
        self.view.setNeedsLayout()
    }
    
    private func getSelectedGenresCount() -> Int {
        guard let currentSnapshot = self.dataSource.snapshot(for: .genres).items as? [DreamWriteEntity.Genre] else { return 0 }
        return currentSnapshot
            .filter { $0.isSelected }
            .count
    }
}

// MARK: - BindCellActions

extension DreamWriteVC {
    private func dateInteractionViewTapped() {
        self.makeTransParentBackground()
        self.showDatePickerView()
    }
    
    private func voiceRecordInteractionViewTapped() {
        self.makeTransParentBackground()
        self.showVoiceRecordView()
    }
    
    private func makeTransParentBackground() {
        self.backGroundView.isUserInteractionEnabled = true
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn) {
            self.backGroundView.alpha = 1
        }
    }
    
    private func showDatePickerView() {
        datePickerView.transform = CGAffineTransform.identity
        datePickerView.snp.updateConstraints { make in
            make.top.equalToSuperview().inset(UIScreen.main.bounds.height - 340.adjustedH)
        }
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func showVoiceRecordView() {
        recordView.transform = CGAffineTransform.identity
        recordView.snp.updateConstraints { make in
            make.top.equalToSuperview().inset(UIScreen.main.bounds.height - 327.adjustedH)
        }
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func dismissVoiceRecordView() {
        self.backGroundView.isUserInteractionEnabled = false
        recordView.snp.updateConstraints { make in
            make.top.equalToSuperview().inset(UIScreen.main.bounds.height)
        }
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn) {
            self.backGroundView.alpha = 0
            self.view.layoutIfNeeded()
        }
    }
    
    private func dismissDatePickerView() {
        self.backGroundView.isUserInteractionEnabled = false
        datePickerView.snp.updateConstraints { make in
            make.top.equalToSuperview().inset(UIScreen.main.bounds.height)
        }
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn) {
            self.backGroundView.alpha = 0
            self.view.layoutIfNeeded()
        }
    }
}

// MARK: - UICollectionViewDelegate

extension DreamWriteVC: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        switch Section.type(indexPath.section) {
        case .emotions:
            var selectedIndexPath: IndexPath? = nil
            selectedIndexPath = collectionView
                .indexPathsForSelectedItems?
                .first { $0.section == indexPath.section }
            self.emotionChagned.accept(indexPath.item + 1)
            guard let selected = selectedIndexPath else {
                return true
            }
            collectionView.deselectItem(at: selected, animated: false)
            return true
        case .genres:
            let selectedList = self.getCurrentGenreList(indexPath: indexPath, insert: true)
            self.genreListChagned.accept(selectedList.count == 0 ? nil : selectedList)
            if selectedList.count >= 4 {
                return false
            } else { return true }
        default: return false
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        switch Section.type(indexPath.section) {
        case .emotions, .genres:
            return true
        default: return false
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        switch Section.type(indexPath.section) {
        case .emotions:
            self.emotionChagned.accept(nil)
        case .genres:
            let currentList = getCurrentGenreList(indexPath: indexPath)
            self.genreListChagned.accept(currentList.count == 0 ? nil : currentList)
        default: return
        }
    }
    
    private func getCurrentGenreList(indexPath: IndexPath, insert: Bool = false) -> [Int] {
        var selectedSet: Set<IndexPath> = .init(self.dreamWriteCollectionView
            .indexPathsForSelectedItems?
            .filter { $0.section == indexPath.section } ?? [])
        if insert == true { selectedSet.insert(indexPath) }
        return selectedSet
            .map { $0.item + 1 }
            .sorted()
    }
}
