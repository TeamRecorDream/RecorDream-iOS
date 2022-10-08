//
//  CoordinatorNavigationController.swift
//  RouterCoordinator
//
//  Created by Junho Lee on 2022/09/29.
//

/*
 CoordinatorNavigationController : Coordinator에서도 SwipeBack Gesture와 BackButton action을 인지할 수 있도록 하는 클래스입니다.
 - 기본 NaivgationController를 사용하면 backButton을 터치시 Coordinator가 알 수 없습니다. 이를 위해 custom Back Button을 이용합니다.
 - Swipe Back 액션의 경우에서도 CoordinatorNavigationControllerDelegate를 채택하여 코디네이터에 알릴 수 있도록 합니다.
 */

import UIKit

protocol CoordinatorNavigationControllerDelegate: AnyObject {
    func transitionBackFinished()
    func didSelectCustomBackAction()
}

open class CoordinatorNavigationController: UINavigationController {

    // MARK: - Vars & Lets
    
    private var transition: UIViewControllerAnimatedTransitioning?
    private var shouldEnableSwipeBack = false
    fileprivate var duringPushAnimation = false
    
    // MARK: Back button customization
    
    private var backButtonImage: UIImage?
    private var backButtonTitle: String?
    private var backButtonfont: UIFont?
    private var backButtonTitleColor: UIColor?
    private var shouldUseViewControllerTitles = false
    
    // MARK: Delegates
    
    weak var swipeBackDelegate: CoordinatorNavigationControllerDelegate?
    
    // MARK: - Controller lifecycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    // MARK: - Public methods
    
    func setTransition(transition: UIViewControllerAnimatedTransitioning?) {
        if self.shouldEnableSwipeBack {
            self.enableSwipeBack()
        }
        
        self.transition = transition
        
        if transition != nil {
            self.disableSwipeBack()
        }
    }
    
    func customizeBackButton(backButtonImage: UIImage? = nil, backButtonTitle: String? = nil, backButtonfont: UIFont? = nil, backButtonTitleColor: UIColor? = nil, shouldUseViewControllerTitles: Bool = false) {
        self.backButtonImage = backButtonImage
        self.backButtonTitle = backButtonTitle
        self.backButtonfont = backButtonfont
        self.backButtonTitleColor = backButtonTitleColor
        self.shouldUseViewControllerTitles = shouldUseViewControllerTitles
    }
    
    func customizeTitle(titleColor: UIColor, largeTextFont: UIFont, smallTextFont: UIFont, isTranslucent: Bool = true, barTintColor: UIColor? = nil) {
        self.navigationBar.prefersLargeTitles = false
        UINavigationBar.customNavBarStyle(color: titleColor, largeTextFont: largeTextFont, smallTextFont: smallTextFont, isTranslucent: isTranslucent, barTintColor: barTintColor)
    }
    
    func enableSwipeBack() {
        self.shouldEnableSwipeBack = true
        self.interactivePopGestureRecognizer?.isEnabled = true
        self.interactivePopGestureRecognizer?.delegate = self
    }
    
    // MARK: - Private methods
    
    private func disableSwipeBack() {
        self.interactivePopGestureRecognizer?.isEnabled = false
        self.interactivePopGestureRecognizer?.delegate = nil
    }
    
    private func setupCustomBackButton(viewController: UIViewController) {
        if self.backButtonImage != nil || self.backButtonTitle != nil {
            viewController.navigationItem.hidesBackButton = true
            let backButtonTitle = self.shouldUseViewControllerTitles ? self.viewControllers[self.viewControllers.count - 1].title : self.backButtonTitle
            let button = CoordinatorNaviBackButton.initCustomBackButton(backButtonImage: self.backButtonImage,
                                                                        backButtonTitle: backButtonTitle,
                                                                        backButtonfont: self.backButtonfont,
                                                                        backButtonTitleColor: self.backButtonTitleColor)
            button.addTarget(self, action: #selector(actionBack(sender:)), for: .touchUpInside)
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
        }
    }
    
    // MARK: - Actions
    
    @objc private func actionBack(sender: UIBarButtonItem) {
        self.swipeBackDelegate?.didSelectCustomBackAction()
    }
    
    // MARK: - Overrides
    
    open override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        self.duringPushAnimation = true
        super.pushViewController(viewController, animated: animated)
        self.setupCustomBackButton(viewController: viewController)
    }
    
    // MARK: - Initialization
    
    public override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

// MARK: - Extensions
// MARK: - UIGestureRecognizerDelegate
extension CoordinatorNavigationController: UIGestureRecognizerDelegate {
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard gestureRecognizer == self.interactivePopGestureRecognizer else {
            return true
        }
        
        return self.viewControllers.count > 1 && self.duringPushAnimation == false
    }
    
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}

// MARK: - UINavigationControllerDelegate
extension CoordinatorNavigationController: UINavigationControllerDelegate {
    
    public func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self.transition
    }
    
    public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if let coordinator = navigationController.topViewController?.transitionCoordinator {
            coordinator.notifyWhenInteractionChanges { (context) in
                if !context.isCancelled {
                    self.swipeBackDelegate?.transitionBackFinished()
                }
            }
        }
    }
    
    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let swipeNavigationController = navigationController as? CoordinatorNavigationController else { return }
        
        swipeNavigationController.duringPushAnimation = false
    }
    
}

extension UINavigationBar {
    
    // MARK: - Public methods
    
    static func customNavBarStyle(color: UIColor, largeTextFont: UIFont, smallTextFont: UIFont, isTranslucent: Bool, barTintColor: UIColor?) {
        self.appearance().largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: color,
                                                      NSAttributedString.Key.font: largeTextFont]
        self.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: color,
                                                 NSAttributedString.Key.font: smallTextFont]
        self.appearance().isTranslucent = isTranslucent
        
        if let barTintColor = barTintColor {
            self.appearance().barTintColor = barTintColor
        }
    }
}
