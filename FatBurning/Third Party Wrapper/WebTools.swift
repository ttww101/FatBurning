import Foundation
import UIKit
import WebKit

let titleBarColorfabun:UIColor = .white
let bottomBarColorfabun:UIColor = .white
let titleFontfabun:UIFont = UIFont.boldSystemFont(ofSize: CGFloat(18))
let titleTextColorfabun:UIColor = .black
let windowMaskColorfabun:UIColor = UIColor(displayP3Red: 0.0, green: 0.0, blue: 0.0, alpha: 0.75)
let btnBackgroundColorfabun:UIColor = .white
let btnOnLineColorfabun:UIColor = UIColor(displayP3Red: 0.0, green: 0.0, blue: 0.0, alpha: 0.68)
//let btnOnLineColorfabun:UIColor = .init(red: 230/255, green: 57/255, blue: 70/255, alpha: 1.0)
let btnOffLineColorfabun:UIColor = .lightGray

class PrivacyLoadVC: UIViewController, WKNavigationDelegate {
    
    var wkWebViewfabun:WKWebView!
    var backBtnfabun:UIButton!
    var forwardBtnfabun:UIButton!
    var titleDesc:String = " "
    var isInitfabun = false
    var multiUrl:[String] = [String]()
    var backUrlfabun:String?
    var callbackfabun: (() -> Void)?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(titlefabun:String, urlsfabun:[String]?) {
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        
        if (titlefabun == "" || titlefabun.count <= 0) {
            titleDesc = " "
        } else if (titlefabun == "gqo3ij090jg30jg931vjefn742nfjrnjer") {
            titleDesc = ""
        } else {
            titleDesc = titlefabun
        }
        if (urlsfabun != nil) {
            multiUrl = urlsfabun!
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mainViewfabun = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.view.addSubview(mainViewfabun)
        mainViewfabun.translatesAutoresizingMaskIntoConstraints = false
        mainViewfabun.backgroundColor = windowMaskColorfabun
        
        let leftViewfabun = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        mainViewfabun.addSubview(leftViewfabun)
        leftViewfabun.translatesAutoresizingMaskIntoConstraints = false
        leftViewfabun.backgroundColor = UIColor.clear
        
        let rightViewfabun = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        mainViewfabun.addSubview(rightViewfabun)
        rightViewfabun.translatesAutoresizingMaskIntoConstraints = false
        rightViewfabun.backgroundColor = UIColor.clear
        
        let topViewfabun = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        mainViewfabun.addSubview(topViewfabun)
        topViewfabun.translatesAutoresizingMaskIntoConstraints = false
        topViewfabun.backgroundColor = UIColor.clear
        
        let bottmViewfabun = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        mainViewfabun.addSubview(bottmViewfabun)
        bottmViewfabun.translatesAutoresizingMaskIntoConstraints = false
        bottmViewfabun.backgroundColor = UIColor.clear
        
        let titleViewfabun = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        mainViewfabun.addSubview(titleViewfabun)
        titleViewfabun.translatesAutoresizingMaskIntoConstraints = false
        titleViewfabun.clipsToBounds = true
        titleViewfabun.backgroundColor = titleBarColorfabun
        
        let toolsViewfabun = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        mainViewfabun.addSubview(toolsViewfabun)
        toolsViewfabun.translatesAutoresizingMaskIntoConstraints = false
        toolsViewfabun.backgroundColor = bottomBarColorfabun
        
        wkWebViewfabun = WKWebView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        mainViewfabun.addSubview(wkWebViewfabun)
        wkWebViewfabun.translatesAutoresizingMaskIntoConstraints = false
        wkWebViewfabun.backgroundColor = UIColor.groupTableViewBackground
        
        let titleLabelfabun = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        titleViewfabun.addSubview(titleLabelfabun)
        titleLabelfabun.translatesAutoresizingMaskIntoConstraints = false
        titleLabelfabun.numberOfLines = 1
        titleLabelfabun.backgroundColor = UIColor.clear
        titleLabelfabun.font = titleFontfabun
        titleLabelfabun.textAlignment = NSTextAlignment.center
        
        let homeBtnfabun = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        toolsViewfabun.addSubview(homeBtnfabun)
        homeBtnfabun.translatesAutoresizingMaskIntoConstraints = false
        homeBtnfabun.backgroundColor = btnBackgroundColorfabun
        
        homeBtnfabun.imageView?.contentMode = .scaleAspectFit
        homeBtnfabun.setContentHuggingPriority(UILayoutPriority(rawValue: 100), for: NSLayoutConstraint.Axis.vertical)
        homeBtnfabun.setContentHuggingPriority(UILayoutPriority(rawValue: 100), for: NSLayoutConstraint.Axis.horizontal)
        homeBtnfabun.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 50), for: NSLayoutConstraint.Axis.vertical)
        homeBtnfabun.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 50), for: NSLayoutConstraint.Axis.horizontal)
        
        homeBtnfabun.imageView?.contentMode = .scaleAspectFit
        homeBtnfabun.setImage(getNaviHomeLineImagefabun(fabunx: nil, fabuny: nil, fabunz: nil, imageSizefabun: 100, arrowStrokeWidthfabun: 8, arrowColorfabun: btnOnLineColorfabun, backgroundColorfabun: .clear), for: UIControl.State.normal)
        homeBtnfabun.setImage(getNaviHomeLineImagefabun(fabunx: nil, fabuny: nil, fabunz: nil, imageSizefabun: 100, arrowStrokeWidthfabun: 8, arrowColorfabun: btnOffLineColorfabun, backgroundColorfabun: .clear), for: UIControl.State.highlighted)
        
        backBtnfabun = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        toolsViewfabun.addSubview(backBtnfabun)
        backBtnfabun.translatesAutoresizingMaskIntoConstraints = false
        backBtnfabun.backgroundColor = btnBackgroundColorfabun
        
        backBtnfabun.imageView?.contentMode = .scaleAspectFit
        backBtnfabun.setContentHuggingPriority(UILayoutPriority(rawValue: 100), for: NSLayoutConstraint.Axis.vertical)
        backBtnfabun.setContentHuggingPriority(UILayoutPriority(rawValue: 100), for: NSLayoutConstraint.Axis.horizontal)
        backBtnfabun.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 50), for: NSLayoutConstraint.Axis.vertical)
        backBtnfabun.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 50), for: NSLayoutConstraint.Axis.horizontal)
        
        backBtnfabun.imageView?.contentMode = .scaleAspectFit
        backBtnfabun.setImage(getNaviBackLineImagefabun(fabunx: nil, fabuny: nil, fabunz: nil, imageSizefabun: 100, arrowStrokeWidthfabun: 8, arrowColorfabun: btnOnLineColorfabun, backgroundColorfabun: .clear), for: UIControl.State.normal)
        backBtnfabun.setImage(getNaviBackLineImagefabun(fabunx: nil, fabuny: nil, fabunz: nil, imageSizefabun: 100, arrowStrokeWidthfabun: 8, arrowColorfabun: btnOffLineColorfabun, backgroundColorfabun: .clear), for: UIControl.State.highlighted)
        
        forwardBtnfabun = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        toolsViewfabun.addSubview(forwardBtnfabun)
        forwardBtnfabun.translatesAutoresizingMaskIntoConstraints = false
        forwardBtnfabun.backgroundColor = btnBackgroundColorfabun
        
        forwardBtnfabun.imageView?.contentMode = .scaleAspectFit
        forwardBtnfabun.setContentHuggingPriority(UILayoutPriority(rawValue: 100), for: NSLayoutConstraint.Axis.vertical)
        forwardBtnfabun.setContentHuggingPriority(UILayoutPriority(rawValue: 100), for: NSLayoutConstraint.Axis.horizontal)
        forwardBtnfabun.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 50), for: NSLayoutConstraint.Axis.vertical)
        forwardBtnfabun.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 50), for: NSLayoutConstraint.Axis.horizontal)
        
        forwardBtnfabun.imageView?.contentMode = .scaleAspectFit
        forwardBtnfabun.setImage(getNaviForwardLineImagefabun(fabunx: nil, fabuny: nil, fabunz: nil, imageSizefabun: 100, arrowStrokeWidthfabun: 8, arrowColorfabun: btnOnLineColorfabun, backgroundColorfabun: .clear), for: UIControl.State.normal)
        forwardBtnfabun.setImage(getNaviForwardLineImagefabun(fabunx: nil, fabuny: nil, fabunz: nil, imageSizefabun: 100, arrowStrokeWidthfabun: 8, arrowColorfabun: btnOffLineColorfabun, backgroundColorfabun: .clear), for: UIControl.State.highlighted)
        
        
        let refreshBtnfabun = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        toolsViewfabun.addSubview(refreshBtnfabun)
        refreshBtnfabun.translatesAutoresizingMaskIntoConstraints = false
        refreshBtnfabun.backgroundColor = btnBackgroundColorfabun
        
        refreshBtnfabun.imageView?.contentMode = .scaleAspectFit
        refreshBtnfabun.setContentHuggingPriority(UILayoutPriority(rawValue: 100), for: NSLayoutConstraint.Axis.vertical)
        refreshBtnfabun.setContentHuggingPriority(UILayoutPriority(rawValue: 100), for: NSLayoutConstraint.Axis.horizontal)
        refreshBtnfabun.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 50), for: NSLayoutConstraint.Axis.vertical)
        refreshBtnfabun.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 50), for: NSLayoutConstraint.Axis.horizontal)
        
        refreshBtnfabun.imageView?.contentMode = .scaleAspectFit
        refreshBtnfabun.setImage(getNaviRefreshLineImagefabun(fabunx: nil, fabuny: nil, fabunz: nil, imageSizefabun: 100, arrowStrokeWidthfabun: 8, arrowColorfabun: btnOnLineColorfabun, backgroundColorfabun: .clear), for: UIControl.State.normal)
        refreshBtnfabun.setImage(getNaviRefreshLineImagefabun(fabunx: nil, fabuny: nil, fabunz: nil, imageSizefabun: 100, arrowStrokeWidthfabun: 8, arrowColorfabun: btnOffLineColorfabun, backgroundColorfabun: .clear), for: UIControl.State.highlighted)
        
        
        let exitBtnfabun = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        toolsViewfabun.addSubview(exitBtnfabun)
        exitBtnfabun.translatesAutoresizingMaskIntoConstraints = false
        exitBtnfabun.backgroundColor = btnBackgroundColorfabun
        
        exitBtnfabun.imageView?.contentMode = .scaleAspectFit
        exitBtnfabun.setContentHuggingPriority(UILayoutPriority(rawValue: 100), for: NSLayoutConstraint.Axis.vertical)
        exitBtnfabun.setContentHuggingPriority(UILayoutPriority(rawValue: 100), for: NSLayoutConstraint.Axis.horizontal)
        exitBtnfabun.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 50), for: NSLayoutConstraint.Axis.vertical)
        exitBtnfabun.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 50), for: NSLayoutConstraint.Axis.horizontal)
        
        exitBtnfabun.imageView?.contentMode = .scaleAspectFit
        exitBtnfabun.setImage(getNaviExitLineImagefabun(fabunx: nil, fabuny: nil, fabunz: nil, imageSizefabun: 100, arrowStrokeWidthfabun: 8, arrowColorfabun: btnOnLineColorfabun, backgroundColorfabun: .clear), for: UIControl.State.normal)
        exitBtnfabun.setImage(getNaviExitLineImagefabun(fabunx: nil, fabuny: nil, fabunz: nil, imageSizefabun: 100, arrowStrokeWidthfabun: 8, arrowColorfabun: btnOffLineColorfabun, backgroundColorfabun: .clear), for: UIControl.State.highlighted)
        
        let linview = UIView()
        linview.backgroundColor = .lightGray
        toolsViewfabun.addSubview(linview)
        linview.translatesAutoresizingMaskIntoConstraints = false
        linview.topAnchor.constraint(equalTo: toolsViewfabun.topAnchor).isActive = true
        linview.leadingAnchor.constraint(equalTo: toolsViewfabun.leadingAnchor).isActive = true
        linview.trailingAnchor.constraint(equalTo: toolsViewfabun.trailingAnchor).isActive = true
        linview.bottomAnchor.constraint(equalTo: toolsViewfabun.topAnchor, constant: 0.3).isActive = true
        
//        let closeBtnfabun = UIView()
        
        let closeBtnfabun = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        
        toolsViewfabun.addSubview(closeBtnfabun)
        closeBtnfabun.translatesAutoresizingMaskIntoConstraints = false
        closeBtnfabun.backgroundColor = UIColor.groupTableViewBackground
        
        let separatorView = UIView()
        closeBtnfabun.addSubview(separatorView)
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.topAnchor.constraint(equalTo: closeBtnfabun.topAnchor).isActive = true
        separatorView.leadingAnchor.constraint(equalTo: closeBtnfabun.leadingAnchor).isActive = true
        separatorView.trailingAnchor.constraint(equalTo: closeBtnfabun.trailingAnchor).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 0.3).isActive = true
        separatorView.backgroundColor = UIColor(displayP3Red: 13/255, green: 13/255, blue: 13/255, alpha: 1.0)
        
        let checkBoxButton = UIButton()
        checkBoxButton.isUserInteractionEnabled = false
        checkBoxButton.setImage(UIImage(named: "icon_unchecked"), for: .normal)
        checkBoxButton.setImage(UIImage(named: "icon_checked"), for: .selected)
        closeBtnfabun.addSubview(checkBoxButton)
        checkBoxButton.translatesAutoresizingMaskIntoConstraints = false
        checkBoxButton.leadingAnchor.constraint(equalTo: closeBtnfabun.leadingAnchor, constant: 16).isActive = true
        checkBoxButton.centerYAnchor.constraint(equalTo: closeBtnfabun.centerYAnchor).isActive = true
        checkBoxButton.heightAnchor.constraint(equalToConstant: 22).isActive = true
        checkBoxButton.widthAnchor.constraint(equalToConstant: 22).isActive = true
        
        let desLabel = UILabel()
        desLabel.text = "了解并同意隐私权政策"
        desLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 16)
        desLabel.adjustsFontSizeToFitWidth = true
        closeBtnfabun.addSubview(desLabel)
        desLabel.translatesAutoresizingMaskIntoConstraints = false
        desLabel.leadingAnchor.constraint(equalTo: checkBoxButton.trailingAnchor, constant: 8).isActive = true
        desLabel.trailingAnchor.constraint(equalTo: closeBtnfabun.trailingAnchor, constant: -16).isActive = true
        desLabel.centerYAnchor.constraint(equalTo: closeBtnfabun.centerYAnchor).isActive = true
        
        let titleLabelHeightfabun = NSLayoutConstraint(item: titleLabelfabun,
                                                        attribute: .height,
                                                        relatedBy: .equal,
                                                        toItem: nil,
                                                        attribute: .notAnAttribute,
                                                        multiplier: 1.0,
                                                        constant: 21.0)
        titleLabelHeightfabun.priority = UILayoutPriority(rawValue: 249)
        titleLabelfabun.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: NSLayoutConstraint.Axis.vertical)
        titleLabelfabun.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 750), for: NSLayoutConstraint.Axis.vertical)
        
        titleLabelfabun.setContentHuggingPriority(UILayoutPriority(rawValue: 50), for: NSLayoutConstraint.Axis.horizontal)
        titleLabelfabun.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 50), for: NSLayoutConstraint.Axis.horizontal)
        
        titleLabelfabun.addConstraint(titleLabelHeightfabun)
        
        
        titleViewfabun.addConstraints([NSLayoutConstraint(item: titleLabelfabun,
                                                           attribute: NSLayoutConstraint.Attribute.centerY,
                                                           relatedBy: .equal,
                                                           toItem: titleViewfabun,
                                                           attribute: .centerY,
                                                           multiplier: 1.0,
                                                           constant: 0.0),
                                        NSLayoutConstraint(item: titleLabelfabun,
                                                           attribute: .trailing,
                                                           relatedBy: .equal,
                                                           toItem: titleViewfabun,
                                                           attribute: .trailing,
                                                           multiplier: 1.0,
                                                           constant: 0.0),
                                        NSLayoutConstraint(item: titleLabelfabun,
                                                           attribute: .leading,
                                                           relatedBy: .equal,
                                                           toItem: titleViewfabun,
                                                           attribute: .leading,
                                                           multiplier: 1.0,
                                                           constant: 0.0),
                                        NSLayoutConstraint(item: titleLabelfabun,
                                                           attribute: .height,
                                                           relatedBy: .equal,
                                                           toItem: titleViewfabun,
                                                           attribute: .height,
                                                           multiplier: 0.5,
                                                           constant: 0.0)])
        
        self.view.addConstraints([NSLayoutConstraint(item: mainViewfabun,
                                                     attribute: .leading,
                                                     relatedBy: .equal,
                                                     toItem: self.view,
                                                     attribute: .leading,
                                                     multiplier: 1.0,
                                                     constant: 0.0),
                                  NSLayoutConstraint(item: mainViewfabun,
                                                     attribute: .top,
                                                     relatedBy: .equal,
                                                     toItem: self.topLayoutGuide,
                                                     attribute: .bottom,
                                                     multiplier: 1.0,
                                                     constant: 0.0),
                                  NSLayoutConstraint(item: mainViewfabun,
                                                     attribute: .trailing,
                                                     relatedBy: .equal,
                                                     toItem: self.view,
                                                     attribute: .trailing,
                                                     multiplier: 1.0,
                                                     constant: 0.0),
                                  NSLayoutConstraint(item: mainViewfabun,
                                                     attribute: .bottom,
                                                     relatedBy: .equal,
                                                     toItem: self.bottomLayoutGuide,
                                                     attribute: .top,
                                                     multiplier: 1.0,
                                                     constant: 0.0)])
        
        mainViewfabun.addConstraints([NSLayoutConstraint(item: leftViewfabun,
                                                          attribute: .leading,
                                                          relatedBy: .equal,
                                                          toItem: mainViewfabun,
                                                          attribute: .leading,
                                                          multiplier: 1.0,
                                                          constant: 0.0),
                                       NSLayoutConstraint(item: leftViewfabun,
                                                          attribute: .top,
                                                          relatedBy: .equal,
                                                          toItem: mainViewfabun,
                                                          attribute: .top,
                                                          multiplier: 1.0,
                                                          constant: 0.0),
                                       NSLayoutConstraint(item: leftViewfabun,
                                                          attribute: .bottom,
                                                          relatedBy: .equal,
                                                          toItem: mainViewfabun,
                                                          attribute: .bottom,
                                                          multiplier: 1.0,
                                                          constant: 0.0),
                                       NSLayoutConstraint(item: leftViewfabun,
                                                          attribute: .trailing,
                                                          relatedBy: .equal,
                                                          toItem: bottmViewfabun,
                                                          attribute: .leading,
                                                          multiplier: 1.0,
                                                          constant: 0.0),
                                       NSLayoutConstraint(item: leftViewfabun,
                                                          attribute: .trailing,
                                                          relatedBy: .equal,
                                                          toItem: toolsViewfabun,
                                                          attribute: .leading,
                                                          multiplier: 1.0,
                                                          constant: 0.0),
                                       NSLayoutConstraint(item: leftViewfabun,
                                                          attribute: .trailing,
                                                          relatedBy: .equal,
                                                          toItem: wkWebViewfabun,
                                                          attribute: .leading,
                                                          multiplier: 1.0,
                                                          constant: 0.0),
                                       NSLayoutConstraint(item: leftViewfabun,
                                                          attribute: .trailing,
                                                          relatedBy: .equal,
                                                          toItem: titleViewfabun,
                                                          attribute: .leading,
                                                          multiplier: 1.0,
                                                          constant: 0.0),
                                       NSLayoutConstraint(item: leftViewfabun,
                                                          attribute: .trailing,
                                                          relatedBy: .equal,
                                                          toItem: topViewfabun,
                                                          attribute: .leading,
                                                          multiplier: 1.0,
                                                          constant: 0.0),
                                       NSLayoutConstraint(item: leftViewfabun, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: titleViewfabun, attribute: NSLayoutConstraint.Attribute.height, multiplier: 0.5, constant: 0),
                                       NSLayoutConstraint(item: rightViewfabun,
                                                          attribute: .trailing,
                                                          relatedBy: .equal,
                                                          toItem: mainViewfabun,
                                                          attribute: .trailing,
                                                          multiplier: 1.0,
                                                          constant: 0.0),
                                       NSLayoutConstraint(item: rightViewfabun,
                                                          attribute: .bottom,
                                                          relatedBy: .equal,
                                                          toItem: mainViewfabun,
                                                          attribute: .bottom,
                                                          multiplier: 1.0,
                                                          constant: 0.0),
                                       NSLayoutConstraint(item: rightViewfabun,
                                                          attribute: .top,
                                                          relatedBy: .equal,
                                                          toItem: mainViewfabun,
                                                          attribute: .top,
                                                          multiplier: 1.0,
                                                          constant: 0.0),
                                       NSLayoutConstraint(item: rightViewfabun,
                                                          attribute: .leading,
                                                          relatedBy: .equal,
                                                          toItem: bottmViewfabun,
                                                          attribute: .trailing,
                                                          multiplier: 1.0,
                                                          constant: 0.0),
                                       NSLayoutConstraint(item: rightViewfabun,
                                                          attribute: .leading,
                                                          relatedBy: .equal,
                                                          toItem: topViewfabun,
                                                          attribute: .trailing,
                                                          multiplier: 1.0,
                                                          constant: 0.0),
                                       NSLayoutConstraint(item: rightViewfabun,
                                                          attribute: .leading,
                                                          relatedBy: .equal,
                                                          toItem: toolsViewfabun,
                                                          attribute: .trailing,
                                                          multiplier: 1.0,
                                                          constant: 0.0),
                                       NSLayoutConstraint(item: rightViewfabun,
                                                          attribute: .leading,
                                                          relatedBy: .equal,
                                                          toItem: titleViewfabun,
                                                          attribute: .trailing,
                                                          multiplier: 1.0,
                                                          constant: 0.0),
                                       NSLayoutConstraint(item: rightViewfabun,
                                                          attribute: .leading,
                                                          relatedBy: .equal,
                                                          toItem: wkWebViewfabun,
                                                          attribute: .trailing,
                                                          multiplier: 1.0,
                                                          constant: 0.0),
                                       NSLayoutConstraint(item: rightViewfabun, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: titleViewfabun, attribute: NSLayoutConstraint.Attribute.height, multiplier: 0.5, constant: 0),
                                       NSLayoutConstraint(item: topViewfabun,
                                                          attribute: .top,
                                                          relatedBy: .equal,
                                                          toItem: mainViewfabun,
                                                          attribute: .top,
                                                          multiplier: 1.0,
                                                          constant: 0.0),
                                       NSLayoutConstraint(item: topViewfabun,
                                                          attribute: .bottom,
                                                          relatedBy: .equal,
                                                          toItem: titleViewfabun,
                                                          attribute: .top,
                                                          multiplier: 1.0,
                                                          constant: 0.0),
                                       NSLayoutConstraint(item: topViewfabun, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: titleViewfabun, attribute: NSLayoutConstraint.Attribute.height, multiplier: 1.5, constant: 0),
                                       NSLayoutConstraint(item: bottmViewfabun,
                                                          attribute: .bottom,
                                                          relatedBy: .equal,
                                                          toItem: mainViewfabun,
                                                          attribute: .bottom,
                                                          multiplier: 1.0,
                                                          constant: 0.0),
                                       NSLayoutConstraint(item: bottmViewfabun,
                                                          attribute: .top,
                                                          relatedBy: .equal,
                                                          toItem: toolsViewfabun,
                                                          attribute: .bottom,
                                                          multiplier: 1.0,
                                                          constant: 0.0),
                                       NSLayoutConstraint(item: bottmViewfabun, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: titleViewfabun, attribute: NSLayoutConstraint.Attribute.height, multiplier: 1.5, constant: 0),
                                       NSLayoutConstraint(item: titleViewfabun,
                                                          attribute: .bottom,
                                                          relatedBy: .equal,
                                                          toItem: wkWebViewfabun,
                                                          attribute: .top,
                                                          multiplier: 1.0,
                                                          constant: 0.0),
                                       NSLayoutConstraint(item: toolsViewfabun,
                                                          attribute: .top,
                                                          relatedBy: .equal,
                                                          toItem: wkWebViewfabun,
                                                          attribute: .bottom,
                                                          multiplier: 1.0,
                                                          constant: 0.0)])
        
        
        
        toolsViewfabun.addConstraints([NSLayoutConstraint(item: closeBtnfabun,
                                                           attribute: .leading,
                                                           relatedBy: .equal,
                                                           toItem: toolsViewfabun,
                                                           attribute: .leading,
                                                           multiplier: 1.0,
                                                           constant: 0.0),
                                        NSLayoutConstraint(item: closeBtnfabun,
                                                           attribute: .top,
                                                           relatedBy: .equal,
                                                           toItem: toolsViewfabun,
                                                           attribute: .top,
                                                           multiplier: 1.0,
                                                           constant: 0.0),
                                        NSLayoutConstraint(item: closeBtnfabun,
                                                           attribute: .trailing,
                                                           relatedBy: .equal,
                                                           toItem: toolsViewfabun,
                                                           attribute: .trailing,
                                                           multiplier: 1.0,
                                                           constant: 0.0),
                                        NSLayoutConstraint(item: closeBtnfabun,
                                                           attribute: .bottom,
                                                           relatedBy: .equal,
                                                           toItem: toolsViewfabun,
                                                           attribute: .bottom,
                                                           multiplier: 1.0,
                                                           constant: 0.0),
                                        NSLayoutConstraint(item: toolsViewfabun,
                                                           attribute: .height,
                                                           relatedBy: .equal,
                                                           toItem: nil,
                                                           attribute: .notAnAttribute,
                                                           multiplier: 1.0,
                                                           constant: 44.0),
                                        NSLayoutConstraint(item: homeBtnfabun,
                                                           attribute: .leading,
                                                           relatedBy: .equal,
                                                           toItem: toolsViewfabun,
                                                           attribute: .leading,
                                                           multiplier: 1.0,
                                                           constant: 5.0),
                                        NSLayoutConstraint(item: homeBtnfabun,
                                                           attribute: .bottom,
                                                           relatedBy: .equal,
                                                           toItem: toolsViewfabun,
                                                           attribute: .bottom,
                                                           multiplier: 1.0,
                                                           constant: -5.0),
                                        NSLayoutConstraint(item: homeBtnfabun,
                                                           attribute: .top,
                                                           relatedBy: .equal,
                                                           toItem: toolsViewfabun,
                                                           attribute: .top,
                                                           multiplier: 1.0,
                                                           constant: 5.0),
                                        NSLayoutConstraint(item: homeBtnfabun,
                                                           attribute: .trailing,
                                                           relatedBy: .equal,
                                                           toItem: backBtnfabun,
                                                           attribute: .leading,
                                                           multiplier: 1.0,
                                                           constant: -5.0),
                                        NSLayoutConstraint(item: homeBtnfabun,
                                                           attribute: .width,
                                                           relatedBy: .equal,
                                                           toItem: backBtnfabun,
                                                           attribute: .width,
                                                           multiplier: 1.0,
                                                           constant: 0.0),
                                        NSLayoutConstraint(item: homeBtnfabun,
                                                           attribute: .width,
                                                           relatedBy: .equal,
                                                           toItem: forwardBtnfabun,
                                                           attribute: .width,
                                                           multiplier: 1.0,
                                                           constant: 0.0),
                                        NSLayoutConstraint(item: homeBtnfabun,
                                                           attribute: .width,
                                                           relatedBy: .equal,
                                                           toItem: refreshBtnfabun,
                                                           attribute: .width,
                                                           multiplier: 1.0,
                                                           constant: 0.0),
                                        NSLayoutConstraint(item: homeBtnfabun,
                                                           attribute: .width,
                                                           relatedBy: .equal,
                                                           toItem: exitBtnfabun,
                                                           attribute: .width,
                                                           multiplier: 1.0,
                                                           constant: 0.0),
                                        NSLayoutConstraint(item: backBtnfabun,
                                                           attribute: .bottom,
                                                           relatedBy: .equal,
                                                           toItem: toolsViewfabun,
                                                           attribute: .bottom,
                                                           multiplier: 1.0,
                                                           constant: -5.0),
                                        NSLayoutConstraint(item: backBtnfabun,
                                                           attribute: .top,
                                                           relatedBy: .equal,
                                                           toItem: toolsViewfabun,
                                                           attribute: .top,
                                                           multiplier: 1.0,
                                                           constant: 5.0),
                                        NSLayoutConstraint(item: backBtnfabun,
                                                           attribute: .trailing,
                                                           relatedBy: .equal,
                                                           toItem: forwardBtnfabun,
                                                           attribute: .leading,
                                                           multiplier: 1.0,
                                                           constant: -5.0),
                                        NSLayoutConstraint(item: forwardBtnfabun,
                                                           attribute: .bottom,
                                                           relatedBy: .equal,
                                                           toItem: toolsViewfabun,
                                                           attribute: .bottom,
                                                           multiplier: 1.0,
                                                           constant: -5.0),
                                        NSLayoutConstraint(item: forwardBtnfabun,
                                                           attribute: .top,
                                                           relatedBy: .equal,
                                                           toItem: toolsViewfabun,
                                                           attribute: .top,
                                                           multiplier: 1.0,
                                                           constant: 5.0),
                                        NSLayoutConstraint(item: forwardBtnfabun,
                                                           attribute: .trailing,
                                                           relatedBy: .equal,
                                                           toItem: refreshBtnfabun,
                                                           attribute: .leading,
                                                           multiplier: 1.0,
                                                           constant: -5.0),
                                        NSLayoutConstraint(item: refreshBtnfabun,
                                                           attribute: .bottom,
                                                           relatedBy: .equal,
                                                           toItem: toolsViewfabun,
                                                           attribute: .bottom,
                                                           multiplier: 1.0,
                                                           constant: -5.0),
                                        NSLayoutConstraint(item: refreshBtnfabun,
                                                           attribute: .top,
                                                           relatedBy: .equal,
                                                           toItem: toolsViewfabun,
                                                           attribute: .top,
                                                           multiplier: 1.0,
                                                           constant: 5.0),
                                        NSLayoutConstraint(item: refreshBtnfabun,
                                                           attribute: .trailing,
                                                           relatedBy: .equal,
                                                           toItem: exitBtnfabun,
                                                           attribute: .leading,
                                                           multiplier: 1.0,
                                                           constant: -5.0),
                                        NSLayoutConstraint(item: exitBtnfabun,
                                                           attribute: .bottom,
                                                           relatedBy: .equal,
                                                           toItem: toolsViewfabun,
                                                           attribute: .bottom,
                                                           multiplier: 1.0,
                                                           constant: -5.0),
                                        NSLayoutConstraint(item: exitBtnfabun,
                                                           attribute: .top,
                                                           relatedBy: .equal,
                                                           toItem: toolsViewfabun,
                                                           attribute: .top,
                                                           multiplier: 1.0,
                                                           constant: 5.0),
                                        NSLayoutConstraint(item: exitBtnfabun,
                                                           attribute: .trailing,
                                                           relatedBy: .equal,
                                                           toItem: toolsViewfabun,
                                                           attribute: .trailing,
                                                           multiplier: 1.0,
                                                           constant: -5.0)])
        
        titleViewfabun.backgroundColor = titleBarColorfabun
        titleLabelfabun.textColor = titleTextColorfabun
        toolsViewfabun.backgroundColor = bottomBarColorfabun
        homeBtnfabun.backgroundColor = btnBackgroundColorfabun
        backBtnfabun.backgroundColor = btnBackgroundColorfabun
        forwardBtnfabun.backgroundColor = btnBackgroundColorfabun
        refreshBtnfabun.backgroundColor = btnBackgroundColorfabun
        exitBtnfabun.backgroundColor = btnBackgroundColorfabun
//        closeBtnfabun.backgroundColor = titleBarColorfabun
        
        titleLabelfabun.text = titleDesc
        if (titleDesc.count != 0) { // close
            toolsViewfabun.backgroundColor = titleBarColorfabun
            closeBtnfabun.isHidden = false
            homeBtnfabun.isHidden = true
            forwardBtnfabun.isHidden = true
            backBtnfabun.isHidden = true
            refreshBtnfabun.isHidden = true
            exitBtnfabun.isHidden = true
        } else { // open
            toolsViewfabun.backgroundColor = bottomBarColorfabun
            closeBtnfabun.isHidden = true
            homeBtnfabun.isHidden = false
            forwardBtnfabun.isHidden = false
            backBtnfabun.isHidden = false
            refreshBtnfabun.isHidden = false
            exitBtnfabun.isHidden = false
        }
        wkWebViewfabun.navigationDelegate = self
        
        homeBtnfabun.addTarget(self, action: #selector(homeBtnClickfabun(sender:)), for: UIControl.Event.touchUpInside)
        
        forwardBtnfabun.addTarget(self, action: #selector(forwardBtnClickfabun(sender:)), for: UIControl.Event.touchUpInside)
        
        backBtnfabun.addTarget(self, action: #selector(backBtnClickfabun(sender:)), for: UIControl.Event.touchUpInside)
        
        refreshBtnfabun.addTarget(self, action: #selector(refreshBtnClickfabun(sender:)), for: UIControl.Event.touchUpInside)
        
        exitBtnfabun.addTarget(self, action: #selector(exitBtnClickfabun(sender:)), for: UIControl.Event.touchUpInside)
        
//        let tapGes = UITapGestureRecognizer(target: self, action: #selector(closeBtnClickfabun(sender:))
//        closeBtnfabun.addGestureRecognizer(tapGes)
        closeBtnfabun.addTarget(self, action: #selector(closeBtnClickfabun(sender:)), for: UIControl.Event.touchUpInside)
        
        resetBtnColorfabun(fabunx: nil, fabuny: nil, fabunz: nil)
        
        if (multiUrl.count > 0) {
            isInitfabun = true
            while (multiUrl.count > 0) {
                if let gotoUrlfabun:URL = URL(string: multiUrl[0]) {
                    let requestfabun:URLRequest = URLRequest(url: gotoUrlfabun)
                    self.multiUrl.removeFirst()
                    self.wkWebViewfabun.load(requestfabun)
                    break
                } else {
                    self.multiUrl.removeFirst()
                    if (self.multiUrl.count == 0) {
                        isInitfabun = false
                    }
                }
            }
        }
        
    }
    
    func setCallbackForPolicy(fabunx: String?, fabuny: String?, fabunz: String?, callbackHandlerfabun: (() -> Void)?) {
        callbackfabun = callbackHandlerfabun
    }
    
    func loadMultifabun(fabunx: String?, fabuny: String?, fabunz: String?, urlsfabun:[String]) {
        multiUrl = urlsfabun
        if (multiUrl.count > 0) {
            while (multiUrl.count > 0) {
                if let gotoUrlfabun:URL = URL(string: multiUrl[0]) {
                    let requestfabun:URLRequest = URLRequest(url: gotoUrlfabun)
                    self.multiUrl.removeFirst()
                    self.wkWebViewfabun.load(requestfabun)
                    break
                } else {
                    self.multiUrl.removeFirst()
                }
            }
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        self.resetBtnColorfabun(fabunx: nil, fabuny: nil, fabunz: nil)
        
        if let urlfabun = navigationAction.request.url {
            
            let htfabun:[Character] = ["h", "-", "t", "-", "t", "-", "p", "-", ":", "-", "/", "-", "/"]
            let htsfabun:[Character] = ["h", "-", "t", "-", "t", "-", "p", "-", "s", "-", ":", "-", "/", "-", "/"]
            let ftfabun:[Character] = ["f", "-", "t", "-", "p", "-", ":", "-", "/", "-", "/"]
            
            if (!(urlfabun.absoluteString.hasPrefix(String(htfabun).replacingOccurrences(of: "-", with: "")) || urlfabun.absoluteString.hasPrefix(String(htsfabun).replacingOccurrences(of: "-", with: "")) || urlfabun.absoluteString.hasPrefix(String(ftfabun).replacingOccurrences(of: "-", with: "")))) {
                
                decisionHandler(WKNavigationActionPolicy.cancel)
                
                if (self.wkWebViewfabun.backForwardList.backList.count > 0) {
                    backUrlfabun = self.wkWebViewfabun.backForwardList.backList[self.wkWebViewfabun.backForwardList.backList.count - 1].url.absoluteString
                } else {
                    backUrlfabun = nil
                }
                
                UIApplication.shared.open(urlfabun, options: [:], completionHandler: nil)
                return
                
            }
            
        }
        backUrlfabun = nil
        decisionHandler(.allow)
        
        return
        
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.resetBtnColorfabun(fabunx: nil, fabuny: nil, fabunz: nil)
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        self.resetBtnColorfabun(fabunx: nil, fabuny: nil, fabunz: nil)
        if (isInitfabun) {
            if (multiUrl.count > 0) {
                while (multiUrl.count > 0) {
                    if let gotoUrlfabun:URL = URL(string: multiUrl[0]) {
                        let requestfabun:URLRequest = URLRequest(url: gotoUrlfabun)
                        self.multiUrl.removeFirst()
                        self.wkWebViewfabun.load(requestfabun)
                        break
                    } else {
                        self.multiUrl.removeFirst()
                        if (self.multiUrl.count == 0) {
                            isInitfabun = false
                        }
                    }
                }
            } else {
                isInitfabun = false
            }
        } else {
            if (multiUrl.count > 0) {
                while (multiUrl.count > 0) {
                    if let gotoUrlfabun:URL = URL(string: multiUrl[0]) {
                        let requestfabun:URLRequest = URLRequest(url: gotoUrlfabun)
                        self.multiUrl.removeFirst()
                        self.wkWebViewfabun.load(requestfabun)
                        break
                    } else {
                        self.multiUrl.removeFirst()
                    }
                }
            }
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.resetBtnColorfabun(fabunx: nil, fabuny: nil, fabunz: nil)
    }
    
    func resetBtnColorfabun(fabunx: String?, fabuny: String?, fabunz: String?) {
        
        DispatchQueue.main.async {
            
            if (self.wkWebViewfabun.canGoBack) {
                self.backBtnfabun.setImage(getNaviBackLineImagefabun(fabunx: nil, fabuny: nil, fabunz: nil, imageSizefabun: 100, arrowStrokeWidthfabun: 8, arrowColorfabun: btnOnLineColorfabun, backgroundColorfabun: .clear), for: UIControl.State.normal)
            } else {
                self.backBtnfabun.setImage(getNaviBackLineImagefabun(fabunx: nil, fabuny: nil, fabunz: nil, imageSizefabun: 100, arrowStrokeWidthfabun: 8, arrowColorfabun: btnOffLineColorfabun, backgroundColorfabun: .clear), for: UIControl.State.normal)
            }
            
            if (self.wkWebViewfabun.canGoForward) {
                self.forwardBtnfabun.setImage(getNaviForwardLineImagefabun(fabunx: nil, fabuny: nil, fabunz: nil, imageSizefabun: 100, arrowStrokeWidthfabun: 8, arrowColorfabun: btnOnLineColorfabun, backgroundColorfabun: .clear), for: UIControl.State.normal)
            } else {
                self.forwardBtnfabun.setImage(getNaviForwardLineImagefabun(fabunx: nil, fabuny: nil, fabunz: nil, imageSizefabun: 100, arrowStrokeWidthfabun: 8, arrowColorfabun: btnOffLineColorfabun, backgroundColorfabun: .clear), for: UIControl.State.normal)
            }
            
        }
        
    }
    
    @objc func homeBtnClickfabun(sender: UIButton) {
        if (self.wkWebViewfabun.canGoBack) {
            self.wkWebViewfabun.load(URLRequest(url: self.wkWebViewfabun.backForwardList.backList[0].url))
        }
    }
    
    @objc func backBtnClickfabun(sender: UIButton) {
        if (self.titleDesc.count > 0) {
            if (self.wkWebViewfabun.canGoBack) {
                self.wkWebViewfabun.goBack()
            } else {
                self.dismiss(animated: true) {
                    if (self.callbackfabun != nil) {
                        self.callbackfabun!()
                    }
                }
            }
        } else {
            
            if (self.wkWebViewfabun.canGoBack) {
                if (backUrlfabun != nil) {
                    var lastIndexfabun = self.wkWebViewfabun.backForwardList.backList.count - 1
                    for i in 0..<self.wkWebViewfabun.backForwardList.backList.count {
                        if (self.wkWebViewfabun.backForwardList.backList[self.wkWebViewfabun.backForwardList.backList.count - i - 1].url.absoluteString == backUrlfabun!) {
                            lastIndexfabun = self.wkWebViewfabun.backForwardList.backList.count - i - 1
                            break
                        }
                    }
                    self.wkWebViewfabun.go(to: self.wkWebViewfabun.backForwardList.backList[lastIndexfabun])
                } else {
                    self.wkWebViewfabun.goBack()
                }
            }
        }
    }
    
    @objc func forwardBtnClickfabun(sender: UIButton) {
        if (self.wkWebViewfabun.canGoForward) {
            self.wkWebViewfabun.goForward()
        }
    }
    
    @objc func refreshBtnClickfabun(sender: UIButton) {
        self.wkWebViewfabun.reload()
    }
    
    @objc func exitBtnClickfabun(sender: UIButton) {
        if (self.titleDesc.count > 0) {
            self.dismiss(animated: true) {
                if (self.callbackfabun != nil) {
                    self.callbackfabun!()
                }
            }
        } else {
            exit(0)
        }
    }
    
    @objc func closeBtnClickfabun(sender: UIView) {
        for subview in sender.subviews {
            if let button = subview as? UIButton {
                button.isSelected = true
            }
        }
//        self.dismiss(animated: true) {
            if (self.callbackfabun != nil) {
                self.callbackfabun!()
            }
//        }
    }
    
}

func radiansToDegreesfabun(fabunx: String?, fabuny: String?, fabunz: String?, radiansfabun:CGFloat) -> CGFloat {
    //
    // 弧度轉成角度
    return radiansfabun * 180 / CGFloat.pi
}
func degreesToRadiansfabun(fabunx: String?, fabuny: String?, fabunz: String?, degreesfabun:CGFloat) -> CGFloat {
    //
    // 角度轉成弧度
    return degreesfabun * CGFloat.pi / 180
}

func getXrightPlusByRadiusfabun(fabunx: String?, fabuny: String?, fabunz: String?, lengthfabun:CGFloat, degreesRightfabun:CGFloat) -> CGFloat {
    //
    // 中心向右為0度，逆時針旋轉，X左為正Y上為正
    return lengthfabun * cos(degreesRightfabun * CGFloat.pi / 180)
}

func getYtopPlusByRadiusfabun(fabunx: String?, fabuny: String?, fabunz: String?, lengthfabun:CGFloat, degreesRightfabun:CGFloat) -> CGFloat {
    //
    // 中心向右為0度，逆時針旋轉，X左為正Y上為正
    return lengthfabun * sin(degreesRightfabun * CGFloat.pi / 180)
}

func getSideLengthByXfabun(fabunx: String?, fabuny: String?, fabunz: String?, lengthfabun:CGFloat, degreesRightfabun:CGFloat) -> CGFloat {
    //
    // 中心向右為0度，逆時針旋轉，X左為正Y上為正
    let yLenfabun = lengthfabun * tan(degreesRightfabun * CGFloat.pi / 180)
    return sqrt(lengthfabun*lengthfabun + yLenfabun*yLenfabun)
}

func getSideLengthByYfabun(fabunx: String?, fabuny: String?, fabunz: String?, lengthfabun:CGFloat, degreesRightfabun:CGFloat) -> CGFloat {
    //
    // 中心向右為0度，逆時針旋轉，X左為正Y上為正
    let xLenfabun = lengthfabun / tan(degreesRightfabun * CGFloat.pi / 180)
    return sqrt(lengthfabun*lengthfabun + xLenfabun*xLenfabun)
}

func getYtopPlusByXfabun(fabunx: String?, fabuny: String?, fabunz: String?, lengthfabun:CGFloat, degreesRightfabun:CGFloat) -> CGFloat {
    //
    // 中心向右為0度，逆時針旋轉，X左為正Y上為正
    return lengthfabun * tan(degreesRightfabun * CGFloat.pi / 180)
}

func getXrightPlusByYfabun(fabunx: String?, fabuny: String?, fabunz: String?, lengthfabun:CGFloat, degreesRightfabun:CGFloat) -> CGFloat {
    //
    // 中心向右為0度，逆時針旋轉，X左為正Y上為正
    return lengthfabun / tan(degreesRightfabun * CGFloat.pi / 180)
}

func imageToBase64fabun(fabunx: String?, fabuny: String?, fabunz: String?, imagefabun:UIImage) -> String {
    //
    // 將圖片轉為 base64 字串
    if let imageDatafabun = imagefabun.pngData() {
        return imageDatafabun.base64EncodedString()
    } else {
        if let imageDatafabun = imagefabun.jpegData(compressionQuality: 0.75) {
            return imageDatafabun.base64EncodedString()
        } else {
            return ""
        }
    }
}

func base64ToImagefabun(fabunx: String?, fabuny: String?, fabunz: String?, base64fabun:String) -> UIImage? {
    
    if let dataDecodedfabun = Data(base64Encoded: base64fabun, options: Data.Base64DecodingOptions.init()) {
        if let decodedimagefabun = UIImage(data: dataDecodedfabun) {
            return decodedimagefabun
        }
    }
    
    return nil
}

func getNaviHomeLineImagefabun(fabunx: String?, fabuny: String?, fabunz: String?, imageSizefabun:CGFloat?, arrowStrokeWidthfabun:CGFloat?, arrowColorfabun:UIColor?, backgroundColorfabun:UIColor?) -> UIImage? {
    
    var contextSizefabun:CGFloat = 100
    if (imageSizefabun != nil) {
        contextSizefabun = imageSizefabun!
    }
    let sideLangthfabun:CGFloat = contextSizefabun * 0.7
    var strokeWidthfabun:CGFloat = 4
    if (arrowStrokeWidthfabun != nil) {
        strokeWidthfabun = arrowStrokeWidthfabun!
    }
    
    UIGraphicsBeginImageContextWithOptions(CGSize(width: contextSizefabun, height: contextSizefabun), false, 0.0)
    
    if let contextfabun = UIGraphicsGetCurrentContext() {
        
        contextfabun.beginPath()
        contextfabun.move(to: CGPoint(x: 0, y: 0))
        contextfabun.addLine(to: CGPoint(x: contextSizefabun, y: 0))
        contextfabun.addLine(to: CGPoint(x: contextSizefabun, y: contextSizefabun))
        contextfabun.addLine(to: CGPoint(x: 0, y: contextSizefabun))
        contextfabun.closePath()
        if let colorfabun = backgroundColorfabun {
            contextfabun.setFillColor(colorfabun.cgColor)
        } else {
            contextfabun.setFillColor(UIColor.clear.cgColor)
        }
        contextfabun.fillPath()
    }
    
    if let contextfabun = UIGraphicsGetCurrentContext() {
        contextfabun.beginPath()
        contextfabun.setLineCap(.round)
        contextfabun.setLineJoin(.round)
        contextfabun.move(to: CGPoint(x: contextSizefabun * 0.1 , y: contextSizefabun * 0.1 + sideLangthfabun / 2.0))
        
        contextfabun.addLine(to: CGPoint(x: contextSizefabun * 0.1 + sideLangthfabun / 2, y: contextSizefabun * 0.1))
        contextfabun.addLine(to: CGPoint(x: contextSizefabun * 0.1 + sideLangthfabun, y: contextSizefabun * 0.1 + sideLangthfabun / 2.0))
        contextfabun.addLine(to: CGPoint(x: contextSizefabun * 0.1 + sideLangthfabun * 0.85, y: contextSizefabun * 0.1 + sideLangthfabun / 2.0))
        contextfabun.addLine(to: CGPoint(x: contextSizefabun * 0.1 + sideLangthfabun * 0.85, y: contextSizefabun * 0.1 + sideLangthfabun))
        contextfabun.addLine(to: CGPoint(x: contextSizefabun * 0.1 + sideLangthfabun * 0.7, y: contextSizefabun * 0.1 + sideLangthfabun))
        contextfabun.addLine(to: CGPoint(x: contextSizefabun * 0.1 + sideLangthfabun * 0.7, y: contextSizefabun * 0.1 + sideLangthfabun * 0.7))
        contextfabun.addLine(to: CGPoint(x: contextSizefabun * 0.1 + sideLangthfabun * 0.3, y: contextSizefabun * 0.1 + sideLangthfabun * 0.7))
        contextfabun.addLine(to: CGPoint(x: contextSizefabun * 0.1 + sideLangthfabun * 0.3, y: contextSizefabun * 0.1 + sideLangthfabun))
        contextfabun.addLine(to: CGPoint(x: contextSizefabun * 0.1 + sideLangthfabun * 0.15, y: contextSizefabun * 0.1 + sideLangthfabun))
        contextfabun.addLine(to: CGPoint(x: contextSizefabun * 0.1 + sideLangthfabun * 0.15, y: contextSizefabun * 0.1 + sideLangthfabun / 2.0))
        
        contextfabun.setLineWidth(strokeWidthfabun)
        if let colorfabun = arrowColorfabun {
            contextfabun.setStrokeColor(colorfabun.cgColor)
        } else {
            contextfabun.setStrokeColor(UIColor.clear.cgColor)
        }
        contextfabun.strokePath()
    }
    
    let imgfabun = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return imgfabun
}

func getNaviBackLineImagefabun(fabunx: String?, fabuny: String?, fabunz: String?, imageSizefabun:CGFloat?, arrowStrokeWidthfabun:CGFloat?, arrowColorfabun:UIColor?, backgroundColorfabun:UIColor?) -> UIImage? {
    
    var contextSizefabun:CGFloat = 100
    if (imageSizefabun != nil) {
        contextSizefabun = imageSizefabun!
    }
    let sideLangthfabun:CGFloat = contextSizefabun * 0.7
    var strokeWidthfabun:CGFloat = 4
    if (arrowStrokeWidthfabun != nil) {
        strokeWidthfabun = arrowStrokeWidthfabun!
    }
    
    UIGraphicsBeginImageContextWithOptions(CGSize(width: contextSizefabun, height: contextSizefabun), false, 0.0)
    
    if let contextfabun = UIGraphicsGetCurrentContext() {
        
        contextfabun.beginPath()
        contextfabun.move(to: CGPoint(x: 0, y: 0))
        contextfabun.addLine(to: CGPoint(x: contextSizefabun, y: 0))
        contextfabun.addLine(to: CGPoint(x: contextSizefabun, y: contextSizefabun))
        contextfabun.addLine(to: CGPoint(x: 0, y: contextSizefabun))
        contextfabun.closePath()
        if let colorfabun = backgroundColorfabun {
            contextfabun.setFillColor(colorfabun.cgColor)
        } else {
            contextfabun.setFillColor(UIColor.clear.cgColor)
        }
        contextfabun.fillPath()
    }
    
    if let contextfabun = UIGraphicsGetCurrentContext() {
        contextfabun.beginPath()
        contextfabun.setLineCap(.round)
        contextfabun.setLineJoin(.round)
        contextfabun.move(to: CGPoint(x: contextSizefabun * 0.1 + sideLangthfabun * 0.4, y: contextSizefabun * 0.1 + sideLangthfabun * 0.9))
        contextfabun.addLine(to: CGPoint(x: contextSizefabun * 0.1, y: contextSizefabun * 0.1 + sideLangthfabun * 0.5))
        contextfabun.addLine(to: CGPoint(x: contextSizefabun * 0.1 + sideLangthfabun * 0.4, y: contextSizefabun * 0.1 + sideLangthfabun * 0.1))
        contextfabun.addLine(to: CGPoint(x: contextSizefabun * 0.1 + sideLangthfabun * 0.4, y: contextSizefabun * 0.1 + sideLangthfabun * 0.3))
        contextfabun.addLine(to: CGPoint(x: contextSizefabun * 0.1 + sideLangthfabun, y: contextSizefabun * 0.1 + sideLangthfabun * 0.3))
        contextfabun.addLine(to: CGPoint(x: contextSizefabun * 0.1 + sideLangthfabun, y: contextSizefabun * 0.1 + sideLangthfabun * 0.7))
        contextfabun.addLine(to: CGPoint(x: contextSizefabun * 0.1 + sideLangthfabun * 0.4, y: contextSizefabun * 0.1 + sideLangthfabun * 0.7))
        
        contextfabun.setLineWidth(strokeWidthfabun)
        if let colorfabun = arrowColorfabun {
            contextfabun.setStrokeColor(colorfabun.cgColor)
        } else {
            contextfabun.setStrokeColor(UIColor.clear.cgColor)
        }
        contextfabun.strokePath()
    }
    
    let imgfabun = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return imgfabun
}

func getNaviForwardLineImagefabun(fabunx: String?, fabuny: String?, fabunz: String?, imageSizefabun:CGFloat?, arrowStrokeWidthfabun:CGFloat?, arrowColorfabun:UIColor?, backgroundColorfabun:UIColor?) -> UIImage? {
    
    var contextSizefabun:CGFloat = 100
    if (imageSizefabun != nil) {
        contextSizefabun = imageSizefabun!
    }
    let sideLangthfabun:CGFloat = contextSizefabun * 0.7
    var strokeWidthfabun:CGFloat = 4
    if (arrowStrokeWidthfabun != nil) {
        strokeWidthfabun = arrowStrokeWidthfabun!
    }
    
    UIGraphicsBeginImageContextWithOptions(CGSize(width: contextSizefabun, height: contextSizefabun), false, 0.0)
    
    if let contextfabun = UIGraphicsGetCurrentContext() {
        
        contextfabun.beginPath()
        contextfabun.move(to: CGPoint(x: 0, y: 0))
        contextfabun.addLine(to: CGPoint(x: contextSizefabun, y: 0))
        contextfabun.addLine(to: CGPoint(x: contextSizefabun, y: contextSizefabun))
        contextfabun.addLine(to: CGPoint(x: 0, y: contextSizefabun))
        contextfabun.closePath()
        if let colorfabun = backgroundColorfabun {
            contextfabun.setFillColor(colorfabun.cgColor)
        } else {
            contextfabun.setFillColor(UIColor.clear.cgColor)
        }
        contextfabun.fillPath()
    }
    
    if let contextfabun = UIGraphicsGetCurrentContext() {
        contextfabun.beginPath()
        contextfabun.setLineCap(.round)
        contextfabun.setLineJoin(.round)
        contextfabun.move(to: CGPoint(x: contextSizefabun * 0.1 + sideLangthfabun * 0.6, y: contextSizefabun * 0.1 + sideLangthfabun * 0.9))
        contextfabun.addLine(to: CGPoint(x: contextSizefabun * 0.1 + sideLangthfabun, y: contextSizefabun * 0.1 + sideLangthfabun * 0.5))
        contextfabun.addLine(to: CGPoint(x: contextSizefabun * 0.1 + sideLangthfabun * 0.6, y: contextSizefabun * 0.1 + sideLangthfabun * 0.1))
        contextfabun.addLine(to: CGPoint(x: contextSizefabun * 0.1 + sideLangthfabun * 0.6, y: contextSizefabun * 0.1 + sideLangthfabun * 0.3))
        contextfabun.addLine(to: CGPoint(x: contextSizefabun * 0.1, y: contextSizefabun * 0.1 + sideLangthfabun * 0.3))
        contextfabun.addLine(to: CGPoint(x: contextSizefabun * 0.1, y: contextSizefabun * 0.1 + sideLangthfabun * 0.7))
        contextfabun.addLine(to: CGPoint(x: contextSizefabun * 0.1 + sideLangthfabun * 0.6, y: contextSizefabun * 0.1 + sideLangthfabun * 0.7))
        
        contextfabun.setLineWidth(strokeWidthfabun)
        if let colorfabun = arrowColorfabun {
            contextfabun.setStrokeColor(colorfabun.cgColor)
        } else {
            contextfabun.setStrokeColor(UIColor.clear.cgColor)
        }
        contextfabun.strokePath()
    }
    
    let imgfabun = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return imgfabun
}

func getNaviRefreshLineImagefabun(fabunx: String?, fabuny: String?, fabunz: String?, imageSizefabun:CGFloat?, arrowStrokeWidthfabun:CGFloat?, arrowColorfabun:UIColor?, backgroundColorfabun:UIColor?) -> UIImage? {
    
    var contextSizefabun:CGFloat = 100
    if (imageSizefabun != nil) {
        contextSizefabun = imageSizefabun!
    }
    let sideLangthfabun:CGFloat = contextSizefabun * 0.7
    var strokeWidthfabun:CGFloat = 4
    if (arrowStrokeWidthfabun != nil) {
        strokeWidthfabun = arrowStrokeWidthfabun!
    }
    
    UIGraphicsBeginImageContextWithOptions(CGSize(width: contextSizefabun, height: contextSizefabun), false, 0.0)
    
    if let contextfabun = UIGraphicsGetCurrentContext() {
        
        contextfabun.beginPath()
        contextfabun.move(to: CGPoint(x: 0, y: 0))
        contextfabun.addLine(to: CGPoint(x: contextSizefabun, y: 0))
        contextfabun.addLine(to: CGPoint(x: contextSizefabun, y: contextSizefabun))
        contextfabun.addLine(to: CGPoint(x: 0, y: contextSizefabun))
        contextfabun.closePath()
        if let colorfabun = backgroundColorfabun {
            contextfabun.setFillColor(colorfabun.cgColor)
        } else {
            contextfabun.setFillColor(UIColor.clear.cgColor)
        }
        contextfabun.fillPath()
    }
    
    if let contextfabun = UIGraphicsGetCurrentContext() {
        contextfabun.beginPath()
        contextfabun.setLineCap(.round)
        contextfabun.setLineJoin(.round)
        contextfabun.move(to: CGPoint(x: contextSizefabun * 0.1 + sideLangthfabun / 2.0 + getXrightPlusByRadiusfabun(fabunx: nil, fabuny: nil, fabunz: nil, lengthfabun: sideLangthfabun * 0.4, degreesRightfabun: 150), y: contextSizefabun * 0.1 + sideLangthfabun / 2.0 - getYtopPlusByRadiusfabun(fabunx: nil, fabuny: nil, fabunz: nil, lengthfabun: sideLangthfabun * 0.4, degreesRightfabun: 150)))
        contextfabun.addArc(center: CGPoint(x: contextSizefabun * 0.1 + sideLangthfabun / 2.0, y: contextSizefabun * 0.1 + sideLangthfabun / 2.0), radius: sideLangthfabun * 0.4, startAngle: 210 * CGFloat.pi / 180 , endAngle: 0, clockwise: false)
        
        contextfabun.move(to: CGPoint(x: contextSizefabun * 0.1 + sideLangthfabun * 0.8, y: contextSizefabun * 0.1 + sideLangthfabun * 0.4))
        contextfabun.addLine(to: CGPoint(x: contextSizefabun * 0.1 + sideLangthfabun * 0.9, y: contextSizefabun * 0.1 + sideLangthfabun * 0.5))
        contextfabun.addLine(to: CGPoint(x: contextSizefabun * 0.1 + sideLangthfabun * 1, y: contextSizefabun * 0.1 + sideLangthfabun * 0.4))
        
        
        contextfabun.move(to: CGPoint(x: contextSizefabun * 0.1 + sideLangthfabun / 2.0 + getXrightPlusByRadiusfabun(fabunx: nil, fabuny: nil, fabunz: nil, lengthfabun: sideLangthfabun * 0.4, degreesRightfabun: 330), y: contextSizefabun * 0.1 + sideLangthfabun / 2.0 - getYtopPlusByRadiusfabun(fabunx: nil, fabuny: nil, fabunz: nil, lengthfabun: sideLangthfabun * 0.4, degreesRightfabun: 330)))
        contextfabun.addArc(center: CGPoint(x: contextSizefabun * 0.1 + sideLangthfabun / 2.0, y: contextSizefabun * 0.1 + sideLangthfabun / 2.0), radius: sideLangthfabun * 0.4, startAngle: 30 * CGFloat.pi / 180 , endAngle: 180 * CGFloat.pi / 180, clockwise: false)
        
        contextfabun.move(to: CGPoint(x: contextSizefabun * 0.1 + sideLangthfabun * 0.2, y: contextSizefabun * 0.1 + sideLangthfabun * 0.6))
        contextfabun.addLine(to: CGPoint(x: contextSizefabun * 0.1 + sideLangthfabun * 0.1, y: contextSizefabun * 0.1 + sideLangthfabun * 0.5))
        contextfabun.addLine(to: CGPoint(x: contextSizefabun * 0.1, y: contextSizefabun * 0.1 + sideLangthfabun * 0.6))
        
        contextfabun.setLineWidth(strokeWidthfabun)
        if let colorfabun = arrowColorfabun {
            contextfabun.setStrokeColor(colorfabun.cgColor)
        } else {
            contextfabun.setStrokeColor(UIColor.clear.cgColor)
        }
        contextfabun.strokePath()
    }
    
    let imgfabun = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return imgfabun
}

func getNaviExitLineImagefabun(fabunx: String?, fabuny: String?, fabunz: String?, imageSizefabun:CGFloat?, arrowStrokeWidthfabun:CGFloat?, arrowColorfabun:UIColor?, backgroundColorfabun:UIColor?) -> UIImage? {
    
    var contextSizefabun:CGFloat = 100
    if (imageSizefabun != nil) {
        contextSizefabun = imageSizefabun!
    }
    let sideLangthfabun:CGFloat = contextSizefabun * 0.7
    var strokeWidthfabun:CGFloat = 4
    if (arrowStrokeWidthfabun != nil) {
        strokeWidthfabun = arrowStrokeWidthfabun!
    }
    
    UIGraphicsBeginImageContextWithOptions(CGSize(width: contextSizefabun, height: contextSizefabun), false, 0.0)
    
    if let contextfabun = UIGraphicsGetCurrentContext() {
        
        contextfabun.beginPath()
        contextfabun.move(to: CGPoint(x: 0, y: 0))
        contextfabun.addLine(to: CGPoint(x: contextSizefabun, y: 0))
        contextfabun.addLine(to: CGPoint(x: contextSizefabun, y: contextSizefabun))
        contextfabun.addLine(to: CGPoint(x: 0, y: contextSizefabun))
        contextfabun.closePath()
        if let colorfabun = backgroundColorfabun {
            contextfabun.setFillColor(colorfabun.cgColor)
        } else {
            contextfabun.setFillColor(UIColor.clear.cgColor)
        }
        contextfabun.fillPath()
    }
    
    if let contextfabun = UIGraphicsGetCurrentContext() {
        contextfabun.beginPath()
        contextfabun.setLineCap(.round)
        contextfabun.setLineJoin(.round)
        contextfabun.move(to: CGPoint(x: contextSizefabun * 0.1 + sideLangthfabun / 2.0 + getXrightPlusByRadiusfabun(fabunx: nil, fabuny: nil, fabunz: nil, lengthfabun: sideLangthfabun * 0.4, degreesRightfabun: 120), y: contextSizefabun * 0.1 + sideLangthfabun / 2.0 - getYtopPlusByRadiusfabun(fabunx: nil, fabuny: nil, fabunz: nil, lengthfabun: sideLangthfabun * 0.4, degreesRightfabun: 120)))
        contextfabun.addArc(center: CGPoint(x: contextSizefabun * 0.1 + sideLangthfabun / 2.0, y: contextSizefabun * 0.1 + sideLangthfabun / 2.0), radius: sideLangthfabun * 0.4, startAngle: 240 * CGFloat.pi / 180 , endAngle: 300 * CGFloat.pi / 180, clockwise: true)
        
        contextfabun.move(to: CGPoint(x: contextSizefabun * 0.1 + sideLangthfabun / 2.0, y: contextSizefabun * 0.1))
        contextfabun.addLine(to: CGPoint(x: contextSizefabun * 0.1 + sideLangthfabun / 2.0, y: contextSizefabun * 0.1 + sideLangthfabun * 0.4))
        
        contextfabun.setLineWidth(strokeWidthfabun)
        if let colorfabun = arrowColorfabun {
            contextfabun.setStrokeColor(colorfabun.cgColor)
        } else {
            contextfabun.setStrokeColor(UIColor.clear.cgColor)
        }
        contextfabun.strokePath()
    }
    
    let imgfabun = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return imgfabun
}
