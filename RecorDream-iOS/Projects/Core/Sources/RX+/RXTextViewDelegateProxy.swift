////
////  RXTextViewDelegateProxy.swift
////  RD-Core
////
////  Created by Junho Lee on 2022/10/06.
////  Copyright © 2022 RecorDream. All rights reserved.
////
//
//import UIKit
//
//import RxSwift
//import RxCocoa
//
//open class RxTextFieldDelegateProxy
//    : DelegateProxy<UITextView, UITextViewDelegate>
//    , DelegateProxyType
//    , UITextViewDelegate {
//
//    public static func currentDelegate(for object: UITextView) -> UITextViewDelegate? {
//        return object.delegate
//    }
//
//    public static func setCurrentDelegate(_ delegate: UITextViewDelegate?, to object: UITextView) {
//        object.delegate = delegate
//    }
//
//    /// Typed parent object.
//    public weak private(set) var textView: UITextView?
//
//    /// - parameter textView: Parent object for delegate proxy.
//    public init(textView: ParentObject) {
//        self.textView = textView
//        super.init(parentObject: textView, delegateProxy: RxTextViewDelegateProxy.self)
//    }
//
//    // Register known implementations
//    public static func registerKnownImplementations() {
//        register(make: RxTextViewDelegateProxy.init)
//    }
//
//    // MARK: delegate methods
//    /// For more information take a look at `DelegateProxyType`.
//    @objc open func textViewShouldReturn(_ textField: UITextField) -> Bool {
//        return forwardToDelegate()?.textFieldShouldReturn?(textField) ?? true
//    }
//
//    @objc open func textFieldShouldClear(_ textField: UITextField) -> Bool {
//        return forwardToDelegate()?.textFieldShouldClear?(textField) ?? true
//    }
//}
