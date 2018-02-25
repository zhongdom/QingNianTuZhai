import Foundation
import PKHUD
import SwiftMessages

private class CustomHUD: PKHUDRotatingImageView {

    static let defaultFrame = CGRect(origin: .zero, size: CGSize(width: 100.0, height: 100.0))

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(image: UIImage?, title: String? = nil, subtitle: String? = nil) {
        super.init(image: image, title: title, subtitle: subtitle)
        self.frame = CustomHUD.defaultFrame
        self.imageView.contentMode = .scaleAspectFit
    }
}

final class HUD {
    
    private enum MessageType {
        case success, info, warning, error
    }
    
    private static var isShown:Bool = false
    
    
    /// 展示loading
    class func showLoding() {
        PKHUD.sharedHUD.dimsBackground = true
        PKHUD.sharedHUD.effect = UIBlurEffect(style: .extraLight)
        PKHUD.sharedHUD.contentView = CustomHUD(image: #imageLiteral(resourceName: "hud_progress"))
        PKHUD.sharedHUD.show(onView: UIApplication.shared.keyWindow)
    }
    
    
    /// 隐藏loading
    class func dismissLoding() {
        PKHUD.sharedHUD.hide()
    }

    /// 文字类型的提示，初始化时调用一次
    class func configureAppearance() {
        SwiftMessages.defaultConfig.presentationContext = .window(windowLevel: UIWindowLevelStatusBar)
//        SwiftMessages.defaultConfig.presentationStyle = .center
        SwiftMessages.defaultConfig.interactiveHide = true
        SwiftMessages.defaultConfig.eventListeners.append({ event in
            switch event {
            case .willShow: isShown = true
            case .didHide: isShown = false
            default: break
            }
        })
    }
    
    class func showSuccess(_ text: String, duration: TimeInterval = 2.5, completionBlock: (() -> Void)? = nil) {
        showText(text, messageType: .success, duration: duration, completionBlock: completionBlock)
    }

    class func showInfo(_ text: String, duration: TimeInterval = 2.5, completionBlock: (() -> Void)? = nil) {
        showText(text, messageType: .info, duration: duration, completionBlock: completionBlock)
    }
    
    class func showError(_ text: String, duration: TimeInterval = 2.5, completionBlock: (() -> Void)? = nil) {
        showText(text, messageType: .error, duration: duration, completionBlock: completionBlock)
    }

    class func showError(_ error: Error, duration: TimeInterval = 2.5, completionBlock: (() -> Void)? = nil) {
        showText(error.localizedDescription, messageType: .error, duration: duration, completionBlock: completionBlock)
    }

    class func showWarning(_ text: String, duration: TimeInterval = 2.5, completionBlock: (() -> Void)? = nil) {
        showText(text, messageType: .warning, duration: duration, completionBlock: completionBlock)
    }

    private class func showText(_ text: String, messageType: MessageType, duration: TimeInterval = 2, completionBlock: (() -> Void)? = nil) {
        
        let messageView = MessageView.viewFromNib(layout: .cardView)
        switch messageType {
        case .success:
            messageView.configureTheme(.success)
        case .info:
            messageView.configureTheme(.info)
        case .warning:
            messageView.configureTheme(.warning)
        case .error:
            messageView.configureTheme(.error)
        }
        messageView.button?.isHidden = true
        messageView.titleLabel?.isHidden = true
        messageView.configureContent(body: text)
        messageView.configureDropShadow()
        messageView.configureIcon(withSize: CGSize(width: 30, height: 30), contentMode: .scaleAspectFill)
        SwiftMessages.defaultConfig.duration = .seconds(seconds: duration)

        let delay: TimeInterval = 0.5
        let duration = isShown ? duration + delay : duration

        if isShown {
            GCD.delay(0.5, block: {
                SwiftMessages.hideAll()
                GCD.delay(0.5, block: {
                    SwiftMessages.show(view: messageView)
                })
            })
        } else {
            SwiftMessages.show(view: messageView)
        }
        GCD.delay(duration) {
            completionBlock?()
        }
    }

    // MARK: - Debug
    /// 测试使用
    class func showTest(_ text: String) {
        #if DEBUG
            showText("[Debug]: \(text)", messageType: .info)
        #endif
    }
    
    /// 测试使用
    class func showTest(_ error: Error) {
        showTest(error.localizedDescription)
    }
}

