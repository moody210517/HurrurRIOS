//  TableChildExampleViewController.swift
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

class TableOrderFrameViewController: UITableViewController, IndicatorInfoProvider,ViewDialogDelegate {
    
    let cellIdentifier = "cell"
    var blackTheme = false
    var itemInfo = IndicatorInfo(title: "View")
    var data:NSMutableArray = NSMutableArray.init()
    var rootVC:OrderHistoryViewController?
    
    init(style: UITableViewStyle, itemInfo: IndicatorInfo) {
        self.itemInfo = itemInfo
        
        super.init(style: style)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "OrderFrameSmallTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "small")
        tableView.register(UINib(nibName: "OrderFrameExpandTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "expand")
        tableView.separatorStyle = .none;
        
        tableView.showsVerticalScrollIndicator = false
        
        tableView.bouncesZoom = false;
        tableView.alwaysBounceVertical = false;
        tableView.alwaysBounceHorizontal = false;
        tableView.bounces = false;
        
        tableView.allowsSelection = false;
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = self.data[indexPath.row] as? OrderHisModel else { return OrderFrameSmallTableViewCell() }
        
        if model.viewContentHidden {
            // small
            if let cell = tableView.dequeueReusableCell(withIdentifier: "small", for: indexPath) as? OrderFrameSmallTableViewCell {
                
                let dictionary: NSDictionary = [
                    "vc" : self,
                    "aDelegate" : self,
                    "model" : model,
                    "indexPath":indexPath,
                    "tableView":tableView,
                    "aDelegate":self
                    ]
                cell.setData(data: dictionary as! [AnyHashable : Any])
                return cell;
            }
        }else{
            // expand
            if let cell = tableView.dequeueReusableCell(withIdentifier: "expand", for: indexPath) as? OrderFrameExpandTableViewCell {
                
                let dictionary: NSDictionary = [
                    "vc" : self,
                    "aDelegate" : self,
                    "model" : model,
                    "indexPath":indexPath,
                    "tableView":tableView,
                    "aDelegate":self
                ]
                cell.setData(data: dictionary as! [AnyHashable : Any])
                return cell;
            }
        }
        
        
        return OrderFrameSmallTableViewCell()
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let model = self.data[indexPath.row] as? OrderHisModel else { return 0.0 }
        if (model.viewContentHidden) {
            return 90;
        }
        let size:CGSize = model.cellSize;
        return size.height;
    }
    
    // MARK: - IndicatorInfoProvider
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
    
    func didSubmit(_ data: [AnyHashable : Any]!, view: UIView!) {
        if view is OrderItemView {
            if let tv = data["tableView"] as? UITableView{
                DispatchQueue.main.async {
                    tv.reloadData()
                }
            }
        }else if view is RescheduleDateInput {
            if let dlg = view.xo as? MyPopupDialog {
                dlg.dismissPopup()
            }
            //            if let orderItemView = data["view"] as? OrderItemView {
            //                if let cell = orderItemView.superview?.superview as? OrderTableViewCell {
            //                    cell.tableView.reloadRows(at: [cell.indexPath], with: .fade)
            //                }
            //            }
            self.rootVC?.loadData(isInitial: false)
        }else if view is OrderFrameSmall {
            let nib = Bundle.main.loadNibNamed("OrderHistoryViews", owner: self, options: nil);
            if let model = data["model"] as? OrderHisModel, let vc_ofe = nib?[2] as? OrderFrameExpand {
                vc_ofe.firstProcess(data)
                if let tv = data["tableView"] as? UITableView{
                    DispatchQueue.main.async {
                        model.viewContentHidden = false
                        tv.reloadData()
                    }
                }
            }
        }else if view is OrderFrameExpand {
            if let model = data["model"] as? OrderHisModel {
                if let tv = data["tableView"] as? UITableView{
                    DispatchQueue.main.async {
                        model.viewContentHidden = true
                        tv.reloadData()
                    }
                }
            }
        }
    }
}
