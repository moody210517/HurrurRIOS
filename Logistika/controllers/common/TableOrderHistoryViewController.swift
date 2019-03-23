//  SegmentedExampleViewController.swift
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

class TableOrderHistoryViewController: ButtonBarPagerTabStripViewController,ECDrawerLayoutDelegate {
    
    public var param1:Int = 0
    
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var topBarView: TopBarView!
    
    
    var child0:OrderFrameViewController? = nil
    var child1:OrderFrameViewController? = nil
    var child2:OrderFrameViewController? = nil
    var childs = [OrderFrameViewController]()
    
    var pages:[Int:Int] = [0:0,1:0,2:0]
    
    override func viewDidLoad() {
        let blueInstagramColor = COLOR_PRIMARY!
        // change selected bar color
        settings.style.buttonBarBackgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .white
        settings.style.selectedBarBackgroundColor = blueInstagramColor
        settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 14)
        settings.style.selectedBarHeight = 2.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = CGlobal.color(withHexString: "263f3e", alpha: 1.0)!
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        
        changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else {
                return
            }
            
            if let old = oldCell?.label.text , let newt = newCell?.label.text , let selfself = self {
                if newt == "Pending" {
                    if selfself.pages[1] == 0 {
                        debugPrint("xxxxx1")
                        CGlobal.showIndicator(self)
                        selfself.pages[1] = 1
                    }
                }else if newt == "Returned" {
                    if selfself.pages[2] == 0 {
                        debugPrint("xxxxx2")
                        CGlobal.showIndicator(self)
                        selfself.pages[2] = 1
                    }
                }
                debugPrint("xxxxx")
                debugPrint(old)
                debugPrint(newt)
            }
            
            
        }
        super.viewDidLoad()
        
        
        self.setupLeftView()
        
        self.loadData(isInitial: true)
    }
    
    func setupLeftView(){
        CGlobal.initMenu(self)
        self.topBarView.customLayout(self)
        
        if let leftView:LeftView = self.view.drawerView {
            if self is ProfileViewController {
                leftView.currentMenu = c_menu_title[0] as! String
            }else if self is QuoteViewController {
                leftView.currentMenu = c_menu_title[1] as! String
            }else if self is QuoteCorViewController {
                leftView.currentMenu = c_menu_title[1] as! String
            }else if self is OrderHisCorViewController {
                leftView.currentMenu = c_menu_title[2] as! String
            }else if self is OrderHistoryViewController {
                leftView.currentMenu = c_menu_title[2] as! String
            }else if self is RescheduleViewController {
                leftView.currentMenu = c_menu_title[3] as! String
            }else if self is CancelPickViewController {
                leftView.currentMenu = c_menu_title[4] as! String
            }else if self is AboutUsViewController {
                leftView.currentMenu = c_menu_title[5] as! String
            }else if self is ContactUsViewController {
                leftView.currentMenu = c_menu_title[6] as! String
            }else if self is FeedBackViewController {
                leftView.currentMenu = c_menu_title[7] as! String
            }else if self is PolicyViewController {
                leftView.currentMenu = c_menu_title[8] as! String
            }else {
                leftView.currentMenu = ""
            }
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.isHidden = true;
        self.topBarView.caption.text = "Order History"
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.pages[1] == 0 {
            CGlobal.showIndicator(self)
            
        }
        
    }
    
    func loadData(isInitial:Bool){
        if let env = CGlobal.sharedId().env {
            let params = NSMutableDictionary.init();
            if (env.mode == c_PERSONAL) {
                params["user_id"] = env.user_id;
            }else if(env.mode == c_CORPERATION){
                params["user_id"] = env.corporate_user_id;
            }
            
            let manager = NetworkParser.init()
            CGlobal.showIndicator(self)
            manager.ontemplateGeneralRequest2(params, basePath: BASE_URL_ORDER, path: "get_orders_his", withCompletionBlock: { (dict_ret, error) in
                
                if let dict = CGlobal.processData(for_OrderHistory: dict_ret, error: error) as? NSDictionary{
                    if let child0 = self.child0 , let child1 = self.child1 , let child2 = self.child2 {
                        
                        if self.childs.count == 3 {
                            child0.data = dict["data0"]! as! NSMutableArray
                            child1.data = dict["data1"]! as! NSMutableArray
                            child2.data = dict["data2"]! as! NSMutableArray
                            
                            if isInitial {
                                self.moveToViewController(at: self.param1, animated: true)
                                if let child = self.childs[self.param1] as? OrderFrameViewController {
                                    child.setupView()
                                }
                            }else{
                                if let child = self.childs[self.currentIndex] as? OrderFrameViewController {
                                    child.setupView()
                                }
                            }
                            
                            if(child0.data?.count == 0 && child1.data?.count == 0 && child2.data?.count == 0){
                                CGlobal.alertMessage("No Orders", title: nil)
                                
                            }
                            
                        }
                    }
                }
                CGlobal.stopIndicator(self)
                
            }, method: "post")
        }
    }
    
    
    // MARK: - PagerTabStripDataSource
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let main = UIStoryboard.init(name: "Personal", bundle: nil)
        let v0 = main.instantiateViewController(withIdentifier: "OrderFrameViewController") as! OrderFrameViewController
        v0.setInfo(itemInfo: "Completed")
        
        let v1 = main.instantiateViewController(withIdentifier: "OrderFrameViewController") as! OrderFrameViewController
        v1.setInfo(itemInfo: "Pending")
        
        let v2 = main.instantiateViewController(withIdentifier: "OrderFrameViewController") as! OrderFrameViewController
        v2.setInfo(itemInfo: "Returned")
        
//        v0.rootVC = self; v1.rootVC = self; v2.rootVC = self;
        v0.index = 0; v1.index = 1; v2.index = 2;
        self.child0 = v0; self.child1 = v1; self.child2 = v2;
        
        self.childs = [child0!, child1!, child2!]
        return self.childs
    }
    
    func drawerLayoutDidOpen() {
        
    }
    func drawerLayoutDidClose() {
        
    }
    
    
    
    // MARK: - Custom Action
    
    @IBAction func closeAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
