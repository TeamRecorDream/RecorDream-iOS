//
//  RDDateTimePickerView.swift
//  RD-DSKit
//
//  Created by Junho Lee on 2022/11/03.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import UIKit

import RD_Core

import SnapKit
import RxSwift
import RxCocoa

// MARK: - DateComponent

fileprivate enum DateComponent: Int {
    
    // MARK: - Static Properties
    
    static let todayYear: String = {
        let formatterYear = DateFormatter()
        formatterYear.dateFormat = "yyyy"
        
        return formatterYear.string(from: Date())
    }()
    
    static let todayMonth: String = {
        let formatterMonth = DateFormatter()
        formatterMonth.dateFormat = "MM"
        
        return formatterMonth.string(from: Date())
    }()
    
    static var availableYear: [Int] = []
    
    // MARK: - DateCase
    
    case year = 0
    case month = 1
    case day = 2
    
    func getRow(day: Int? = nil) -> Int {
        switch self {
        case .year:
            return Self.availableYear.count
        case .month:
            return 12
        case .day:
            return 31
        }
    }
    
    func getTitle(at row: Int) -> String {
        switch self {
        case .year:
            return "\(Self.availableYear[row])년"
        case .month:
            return "\(row + 1)월"
        case .day:
            return "\(row + 1)일"
        }
    }
    
    static func getYear(row: Int) -> Int {
        return self.availableYear[row]
    }
    
    static func initToday() {
        self.availableYear.removeAll()
        for i in 2020...Int(todayYear)! {
            availableYear.append(i)
        }
    }
}

// MARK: - TimeComponent

fileprivate enum TimeComponent: Int {
    case meridiem = 0
    case hour = 1
    case minute = 2
    
    func getRow() -> Int {
        switch self {
        case .meridiem:
            return 2
        case .hour:
            return 12
        case .minute:
            return 60
        }
    }
    
    func getTitle(at row: Int) -> String {
        switch self {
        case .meridiem:
            return (row == 0) ? "AM" : "PM"
        case .hour:
            return (row < 10) ? "0\(row)" : "\(row)"
        case .minute:
            return (row < 10) ? "0\(row)" : "\(row)"
        }
    }
}

// MARK: - RDDateTimePickerView

public class RDDateTimePickerView: UIView {
    
    // MARK: - Properties
    
    public enum ViewType {
        case date
        case time
    }
    
    public var viewType = ViewType.date
    
    var selectedYear = 2020
    var selectedMonth = "01"
    var selectedDay = "01"
    
    var selectedMeridium = ""
    var selectedHour = 0
    var selectedMinute = 0
    
    private let disposeBag = DisposeBag()
    public let dateTimeOutput = PublishSubject<String?>()
    
    // MARK: - UI Components
    
    private let grabberView: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.4)
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "날짜 설정"
        label.font = RDDSKitFontFamily.Pretendard.semiBold.font(size: 16)
        label.textColor = .white
        label.sizeToFit()
        return label
    }()
    
    lazy var datePicker: UIPickerView = {
        let datePicker = UIPickerView()
        datePicker.tintColor = .white
        datePicker.setValue(UIColor.white, forKeyPath: "textColor")
        datePicker.delegate = self
        datePicker.dataSource = self
        return datePicker
    }()
    
    lazy var timePicker: UIPickerView = {
        let timePicker = UIPickerView()
        timePicker.tintColor = .white
        timePicker.delegate = self
        timePicker.dataSource = self
        return timePicker
    }()
    
    private let colonLabel: UILabel = {
        let label = UILabel()
        label.text = ":"
        label.font = .systemFont(ofSize: 34)
        label.textColor = .white
        return label
    }()
    
    public let cancelButton: UIButton = {
        let bt = UIButton()
        bt.setTitle("취소", for: .normal)
        bt.setTitleColor(.white, for: .normal)
        bt.titleLabel?.font = RDDSKitFontFamily.Pretendard.semiBold.font(size: 16)
        bt.backgroundColor = RDDSKitAsset.Colors.white01.color.withAlphaComponent(0.1)
        bt.layer.cornerRadius = 10
        return bt
    }()
    
    public let saveButton: UIButton = {
        let bt = UIButton()
        bt.setTitle("저장", for: .normal)
        bt.setTitleColor(.white, for: .normal)
        bt.titleLabel?.font = RDDSKitFontFamily.Pretendard.semiBold.font(size: 16)
        bt.backgroundColor = RDDSKitAsset.Colors.purple.color
        bt.layer.cornerRadius = 10
        return bt
    }()
    
    // MARK: - View Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
        DateComponent.initToday()
        bindViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI & Layouts

extension RDDateTimePickerView {
    private func setUI() {
        self.backgroundColor = RDDSKitAsset.Colors.grey01.color
        self.layer.cornerRadius = 16
    }
    
    private func setLayout() {
        self.addSubviews(grabberView, titleLabel, datePicker,
                         timePicker, colonLabel, cancelButton,
                         saveButton)
        
        grabberView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12.adjustedH)
            make.width.equalTo(38.adjusted)
            make.height.equalTo(3.adjustedH)
            make.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(grabberView.snp.bottom).offset(14.adjustedH)
            make.centerX.equalToSuperview()
        }
        
        datePicker.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(56)
            make.bottom.equalTo(cancelButton.snp.top).offset(-40)
        }
        
        timePicker.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(40)
            make.bottom.equalTo(cancelButton.snp.top).offset(-40)
        }
        
        colonLabel.snp.makeConstraints { make in
            make.bottom.equalTo(timePicker.snp.bottom).inset(44.adjustedH)
            make.trailing.equalTo(timePicker.snp.trailing).inset(110)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(54.adjustedH)
            make.height.equalTo(40.adjustedH)
            make.width.equalTo(140.adjusted)
            make.leading.equalToSuperview().inset(26.adjusted)
        }
        
        saveButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(54.adjustedH)
            make.height.equalTo(40.adjustedH)
            make.width.equalTo(140.adjusted)
            make.trailing.equalToSuperview().inset(26.adjusted)
        }
    }
}

// MARK: - Methods

extension RDDateTimePickerView {
    @discardableResult
    public func viewType(_ type: ViewType) -> Self {
        self.viewType = type
        switch type {
        case .date:
            self.setDatePicker()
        case .time:
            self.setTimePicker()
        }
        return self
    }
    
    private func setDatePicker() {
        self.titleLabel.text = "날짜 설정"
        timePicker.removeFromSuperview()
        colonLabel.removeFromSuperview()
    }
    
    private func setDatePickerState() {
        
    }
    
    private func setTimePicker() {
        self.titleLabel.text = "시간 설정"
        datePicker.removeFromSuperview()
    }
    
    private func bindViews() {
        cancelButton.rx.tap
            .asDriver()
            .drive(onNext: {
                self.dateTimeOutput.onNext(nil)
            }).disposed(by: self.disposeBag)
        
        saveButton.rx.tap
            .asDriver()
            .drive(onNext: {
                switch self.viewType {
                case .date:
                    let selectedDate = "\(self.selectedYear)-\(self.selectedMonth)-\(self.selectedDay)"
                    self.dateTimeOutput.onNext(selectedDate)
                case .time:
                    self.dateTimeOutput.onNext(nil)
                }
            }).disposed(by: self.disposeBag)
    }
    
    @discardableResult
    public func enablePanGesture() -> Self {
        let panGesture = UIPanGestureRecognizer()
        self.addGestureRecognizer(panGesture)
        panGesture.rx.event.asDriver { _ in .never() }
            .drive(onNext: { [weak self] sender in
                guard let self = self else { return }
                let translation = sender.translation(in: self)
                switch sender.state {
                case .changed:
                    if translation.y >= 0 {
                            self.transform = CGAffineTransform(translationX: 0, y: translation.y)
                    }
                case .ended:
                    if translation.y >= 200 {
                        self.dateTimeOutput.onNext(nil)
                    } else {
                        UIView.animate(withDuration: 0.15, delay: 0, options: .curveEaseIn) {
                            self.transform = CGAffineTransform.identity
                        }
                    }
                default:
                    break
                }
            }).disposed(by: self.disposeBag)
        return self
    }
}

extension RDDateTimePickerView: UIPickerViewDelegate, UIPickerViewDataSource {
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    public func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        switch self.viewType {
        case .date:
            return (component == 0) ? 100 : 75
        case .time:
            return (component == 0) ? 70 : 110
        }
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch self.viewType {
        case .date:
            return self.getDateRow(at: component)
        case .time:
            return self.getTimeRow(at: component)
        }
    }
    
    private func getDateRow(at component: Int) -> Int {
        let componentType = DateComponent.init(rawValue: component)
        return componentType?.getRow() ?? 0
    }
    
    private func getTimeRow(at component: Int) -> Int {
        let componentType = TimeComponent.init(rawValue: component)
        return componentType?.getRow() ?? 0
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        pickerView.subviews[1].isHidden = true
        switch self.viewType {
        case .date:
            return self.getDateTitle(for: component, at: row)
        case .time:
            return self.getTimeTitle(for: component, at: row)
        }
    }
    
    private func getDateTitle(for component: Int, at row: Int) -> String? {
        let componentType = DateComponent.init(rawValue: component)
        return componentType?.getTitle(at: row)
    }
    
    private func getTimeTitle(for component: Int, at row: Int) -> String? {
        let componentType = TimeComponent.init(rawValue: component)
        return componentType?.getTitle(at: row)
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch self.viewType {
        case .date:
            self.dateSelected(row: row, component: component)
            if (Int(DateComponent.todayYear) == selectedYear && Int(DateComponent.todayMonth)! < Int(selectedMonth)!) {
                pickerView.selectRow(Int(DateComponent.todayMonth)!-1, inComponent: 1, animated: true)
                selectedMonth = DateComponent.todayMonth
            }
        case .time:
            self.timeSelected(row: row, component: component)
        }
    }
    
    private func dateSelected(row: Int, component: Int) {
        let componentType = DateComponent.init(rawValue: component)
        switch componentType {
        case .day:
            var day = ""
            if row < 9 { day = "0\(row + 1)" }
            else { day = "\(row + 1)" }
            selectedDay = day
        case .month:
            var month = ""
            if row < 9 { month = "0\(row + 1)" }
            else { month = "\(row + 1)" }
            selectedMonth = month
        case .year:
            selectedYear = DateComponent.getYear(row: row)
        default: return
        }
    }
    
    private func timeSelected(row: Int, component: Int) {
        let componentType = TimeComponent.init(rawValue: component)
        switch componentType {
        case .meridiem:
            selectedMeridium = componentType?.getTitle(at: row) ?? ""
        case .hour:
            selectedHour = row
        case .minute:
            selectedMinute = row
        default: return
        }
    }
}

// MARK: Reactive Extension

extension Reactive where Base: RDDateTimePickerView {
    public var cancelButtonTapped: ControlEvent<Void> {
        return base.cancelButton.rx.tap
    }
    
    public var saveButtonTapped: Observable<String> {
        return base.saveButton.rx.tap
            .map { "\(base.selectedMeridium)" + "\(base.selectedHour)" + "\(base.selectedMinute)" }
            .asObservable()
    }
}
