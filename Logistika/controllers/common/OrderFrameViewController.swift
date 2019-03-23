//  ChildExampleViewController.swift
//  XLPagerTabStrip ( https://github.com/xmartlabs/XLPagerTabStrip )
//
//  Copyright (c) 2017 Xmartlabs ( http://xmartlabs.com )
//
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import Foundation
import XLPagerTabStrip

class OrderFrameViewController: UIViewController, IndicatorInfoProvider, ViewDialogDelegate {
    
    var itemInfo: IndicatorInfo = "View"
    var data:NSMutableArray?
    var viewConstructed = false
    var rootVC:OrderHistoryViewController?
    var index:Int = 0
    
    @IBOutlet weak var viewScrollContainer: ViewScrollContainer!
    //    init(itemInfo: IndicatorInfo) {
//        self.itemInfo = itemInfo
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    func setInfo(itemInfo: IndicatorInfo) {
        self.itemInfo = itemInfo
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        self.setupView()
    }
    
    func setupView(){
        debugPrint("SSSSSSSSSS")
        if let title = self.itemInfo.title {
            debugPrint(title)
        }
        if let array = self.data , let scroll = self.viewScrollContainer , viewConstructed == false , let rootVC = self.rootVC {
            DispatchQueue.main.async {
                CGlobal.showIndicator(rootVC)
                for i in 0..<array.count {
                    if let model = array[i] as? OrderHisModel {
                        let nib = Bundle.main.loadNibNamed("OrderHistoryViews", owner: self, options: nil);
                        if let vc_cc = nib?[0] as? OrderFrameContainer , let vc_ofs = nib?[1] as? OrderFrameSmall, let vc_ofe = nib?[2] as? OrderFrameExpand {
                            vc_cc.vc_Expand = vc_ofe
                            vc_cc.vc_Small = vc_ofs
                            
                            let dictionary: NSDictionary = [
                                "vc" : self,
                                "aDelegate" : self,
                                "model" : model,
                                ]
                            
                            vc_cc.original_data = dictionary as! [AnyHashable : Any]
                            vc_cc.addMyView(vc_cc.vc_Small)
                            scroll.addOneView(vc_cc)
                        }
                    }
                }
                self.layoutMyView(vv: scroll)
                self.viewConstructed = true
                
                if let rootVC = self.rootVC {
                    rootVC.pages[self.index] = 1
                }
                CGlobal.stopIndicator(rootVC)
                debugPrint("stop1")
            }
            
        }else{
            if let rootVC = self.rootVC {
                DispatchQueue.main.async {
                    CGlobal.stopIndicator(rootVC)
                    debugPrint("stop2")
                }
            }
        }
    }
    
    func didSubmit(_ data: [AnyHashable : Any]!, view: UIView!) {
        if view is OrderFrameSmall {
            // small box clicked.  need to expand
            if let vc_cc = view.superview as? OrderFrameContainer {
                vc_cc.addMyView(vc_cc.vc_Expand)
                self.layoutMyView(vv: vc_cc)
            }
        }else if view is OrderFrameExpand {
            if let vc_cc = view.superview as? OrderFrameContainer {
                vc_cc.addMyView(vc_cc.vc_Small)
                self.layoutMyView(vv: vc_cc)
            }
        }else if view is RescheduleDateInput {
//            if let dlg = view.xo as? MyPopupDialog {
//                dlg.dismissPopup()
//            }
            
            //            if let orderItemView = data["view"] as? OrderItemView {
            //                if let cell = orderItemView.superview?.superview as? OrderTableViewCell {
            //                    cell.tableView.reloadRows(at: [cell.indexPath], with: .fade)
            //                }
            //            }
            
            // open orderhistory again
            if let rootVC = self.rootVC , let leftView:LeftView = rootVC.view.drawerView {
                leftView.reopenOrderHistory(1)
            }
        }
    }
    
    func layoutMyView(vv:UIView){
        vv.setNeedsUpdateConstraints()
        vv.layoutIfNeeded()
    }
    
    func didCancel(_ data: [AnyHashable : Any]!, view: UIView!) {
        if view is RescheduleDateInput {
            if let dlg = view.xo as? MyPopupDialog {
                dlg.dismissPopup()
            }
        }
    }
    
    // MARK: - IndicatorInfoProvider
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
