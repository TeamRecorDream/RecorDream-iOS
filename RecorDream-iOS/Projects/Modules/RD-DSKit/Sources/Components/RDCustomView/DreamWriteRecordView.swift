//
//  DreamWriteRecordView.swift
//  RD-DSKit
//
//  Created by Junho Lee on 2022/10/11.
//  Copyright © 2022 RecorDream. All rights reserved.
//

import AVFoundation
import UIKit

import RD_Core

import SnapKit
import RxSwift
import RxCocoa

// TODO: - 회의에서 RecordView의 재생 기능 필요성이 결정된 이후 주석 처리하기

public class DreamWriteRecordView: UIView {
    
    // MARK: - Properties
    
    private let disposeBag = DisposeBag()
    
    private enum RecordStatus {
        case notStarted
        case recording
        case completed
    }
    
    private var recordStatus = RecordStatus.notStarted
    
    public let recordOutput = PublishSubject<(URL, CGFloat)?>()
    
    var audioRecorder: AVAudioRecorder?
    var audioPlayer: AVAudioPlayer?
    
    public var audioFileURL: URL {
        let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let audioFileName = UUID().uuidString + ".m4a"
        return documentURL.appendingPathComponent(audioFileName)
    }
    
    // MARK: - UI Components
    
    private let grabberView: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.4)
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "음성녹음"
        label.font = RDDSKitFontFamily.Pretendard.semiBold.font(size: 16)
        label.textColor = .white
        label.sizeToFit()
        return label
    }()
    
    private let mainMicImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.image = RDDSKitAsset.Images.icnMicTitle.image
        return iv
    }()
    
    private let playSliderView = DreamWritePlayerSliderView()
    
    private let recordButton: UIButton = {
        let bt = UIButton()
        bt.setImage(RDDSKitAsset.Images.icnMicStart.image, for: .normal)
        return bt
    }()
    
    private let closeButton: UIButton = {
        let bt = UIButton()
        bt.setImage(RDDSKitAsset.Images.icnMicCancel.image, for: .normal)
        bt.isHidden = true
        return bt
    }()
    
    private let saveButton: UIButton = {
        let bt = UIButton()
        bt.setImage(RDDSKitAsset.Images.icnMicSave.image, for: .normal)
        bt.isHidden = true
        return bt
    }()
    
    // MARK: - View Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setLayout()
        bind()
        setAudio()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI & Layouts

extension DreamWriteRecordView {
    private func setUI() {
        self.backgroundColor = RDDSKitAsset.Colors.grey01.color
        self.layer.cornerRadius = 16
    }
    
    private func setLayout() {
        self.addSubviews(grabberView, titleLabel, mainMicImageView,
                         playSliderView, recordButton, closeButton,
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
        
        mainMicImageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(24.adjustedH)
            make.width.height.equalTo(72.adjustedH)
            make.centerX.equalToSuperview()
        }
        
        playSliderView.snp.makeConstraints { make in
            make.top.equalTo(mainMicImageView.snp.bottom).offset(21.adjustedH)
            make.height.equalTo(23.adjustedH)
            make.leading.trailing.equalToSuperview()
        }
        
        recordButton.snp.makeConstraints { make in
            make.top.equalTo(playSliderView.snp.bottom).offset(36.adjustedH)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(54.adjusted)
        }
        
        closeButton.snp.makeConstraints { make in
            make.centerY.equalTo(recordButton.snp.centerY)
            make.width.height.equalTo(54.adjusted)
            make.leading.equalToSuperview().inset(23.adjusted)
        }
        
        saveButton.snp.makeConstraints { make in
            make.centerY.equalTo(recordButton.snp.centerY)
            make.width.height.equalTo(54.adjusted)
            make.trailing.equalToSuperview().inset(23.adjusted)
        }
    }
}

// MARK: - Methods

extension DreamWriteRecordView {
    private func bind() {
        recordButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self = self else { return }
                switch self.recordStatus {
                case .notStarted:
                    self.tappedStart()
                case .recording:
                    self.tappedStop()
                case .completed:
                    self.tappedReset()
                }
            })
            .disposed(by: self.disposeBag)
        
        closeButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self = self else { return }
                self.recordOutput.onNext(nil)
            })
            .disposed(by: self.disposeBag)
        
        saveButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self = self,
                      let recorderURL = self.audioRecorder?.url else { return }
                let audioAsset = AVURLAsset.init(url: self.audioRecorder!.url, options: nil)
                let duration = audioAsset.duration
                let durationInSeconds = CGFloat(CMTimeGetSeconds(duration))
                self.recordOutput.onNext((self.audioFileURL, durationInSeconds))
            })
            .disposed(by: self.disposeBag)
        
        Observable<Int>
            .interval(.milliseconds(100), scheduler: MainScheduler.asyncInstance)
            .compactMap { [weak self] _ in self?.audioRecorder?.currentTime }
            .filter { !$0.isZero }
            .bind(to: self.playSliderView.rx.elapsedTime )
            .disposed(by: self.disposeBag)
    }
    
    private func tappedStart() {
        checkMicrophoneAccess { granted in
            DispatchQueue.main.async {
                if granted {
                    self.recordButton.setImage(RDDSKitAsset.Images.icnMicStop.image, for: .normal)
                    self.recordStatus = RecordStatus.recording
                    
                    self.stopPlayer()
                    self.startRecording()
                } else {
                    self.showNeedsGrantAlert()
                }
            }
        }
    }
    
    private func tappedStop() {
        self.recordButton.setImage(RDDSKitAsset.Images.icnMicReset.image, for: .normal)
        self.recordStatus = RecordStatus.completed
        [closeButton, saveButton].forEach { $0.isHidden = false }
        
        self.stopRecording()
//        self.stopPlayer()
    }
    
    private func tappedReset() {
        self.recordButton.setImage(RDDSKitAsset.Images.icnMicStart.image, for: .normal)
        self.recordStatus = RecordStatus.notStarted
        [closeButton, saveButton].forEach { $0.isHidden = true }
        
        self.playSliderView.elapsedTimeSecondsFloat = 0.0
//        self.startPlayer()
    }
    
    private func showNeedsGrantAlert() {
        let topVC = UIApplication.getMostTopViewController()
        topVC?.makeAlert(title: "마이크 사용 권한이 필요합니다",
                         message: "음성 녹음 통해 꿈을 기록하기 위해 마이크 사용 권한에 동의해주세요.")
    }
}

// MARK: - AVFoundation

extension DreamWriteRecordView: AVAudioRecorderDelegate, AVAudioPlayerDelegate {
    
    private func setAudio() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSession.Category.playAndRecord, mode: .default)
        } catch {
            print("audioSession error: \(error.localizedDescription)")
        }
        
        let recorderSetting: [String : Any] = [ AVFormatIDKey : kAudioFormatAppleLossless,
                                     AVEncoderAudioQualityKey : AVAudioQuality.max.rawValue,
                                           AVEncoderBitRateKey: 320000,
                                        AVNumberOfChannelsKey : 2,
                                              AVSampleRateKey : 44100.0 ]
        do {
            audioRecorder = try AVAudioRecorder(url: audioFileURL, settings: recorderSetting)
            audioRecorder?.delegate = self
            audioRecorder?.isMeteringEnabled = true
            audioRecorder?.prepareToRecord()
        } catch {
            print("audioRecorder error: \(error.localizedDescription)")
        }
    }
    
    private func checkMicrophoneAccess(completion: @escaping ((Bool)->Void)) {
        switch AVAudioSession.sharedInstance().recordPermission {
            
        case AVAudioSession.RecordPermission.granted:
            print(#function, " Microphone Permission Granted")
            completion(true)
            break
            
        case AVAudioSession.RecordPermission.denied:
            UIApplication.shared.sendAction(#selector(UIView.endEditing(_:)), to:nil, from:nil, for:nil)
            completion(false)
            return
            
        case AVAudioSession.RecordPermission.undetermined:
            UIApplication.shared.sendAction(#selector(UIView.endEditing(_:)), to:nil, from:nil, for:nil)
            
            AVAudioSession.sharedInstance().requestRecordPermission({ (granted) in
                if granted {
                    print(#function, " Now Granted")
                    completion(true)
                } else {
                    print("Pemission Not Granted")
                    completion(false)
                }
            })
        @unknown default:
            print("ERROR! Unknown Default. Check!")
        }
    }
    
    private func stopPlayer() {
        if let player = audioPlayer {
            if player.isPlaying { player.stop() }
        }
    }
    
    private func startPlayer() {
        guard let recorder = audioRecorder else { return }
        if !recorder.isRecording {
            audioPlayer = try? AVAudioPlayer(contentsOf: recorder.url)
            audioPlayer?.delegate = self
            audioPlayer?.volume = 100
            audioPlayer?.play()
        }
    }
    
    private func stopRecording() {
        guard let recorder = audioRecorder else { return }
        if recorder.isRecording {
            audioRecorder?.stop()
            let audioSession = AVAudioSession.sharedInstance()
            do {
                try audioSession.setActive(false)
            } catch let error {
                print("audioSession error: \(error.localizedDescription)")
            }
        }
    }
    
    private func startRecording() {
        guard let recorder = audioRecorder else { return }
        if !recorder.isRecording {
            let audioSession = AVAudioSession.sharedInstance()
            do {
                try audioSession.setActive(true)
            } catch let error {
                print("audioSession error: \(error.localizedDescription)")
            }
            recorder.record()
        } else {
            recorder.pause()
        }
    }
}
