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

class TableChildExampleViewController: UITableViewController, IndicatorInfoProvider,ViewDialogDelegate {

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
        tableView.register(UINib(nibName: "OrderTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: cellIdentifier)
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? OrderTableViewCell,
            let model = self.data[indexPath.row] as? OrderHisModel else { return OrderTableViewCell() }

        let data:NSMutableDictionary = NSMutableDictionary.init()
        data["indexPath"] = indexPath;
        data["tableView"] = tableView;
        data["model"] = model;
        data["vc"] = self;
        data["aDelegate"] = self;
        cell.setData(data);
        
        cell.backgroundColor = UIColor.purple
        cell.orderItemView.backgroundColor = COLOR_RESERVED
        return cell;
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let model = self.data[indexPath.row] as? OrderHisModel else { return 0.0 }
        
        
        var padding:CGFloat = 30.0;
        if (model.viewContentHidden) {
            padding = 10.0;
            let height = 100.0 + padding
            
            debugPrint("HQHQHQ 1 id = " + model.orderId + " HeightHeight = \(height)")
            return height
        }
        let size:CGSize = model.cellSize;
        let height = size.height + padding;
        
        debugPrint("HQHQHQ 2 id = " + model.orderId + " HeightHeight = \(height)")
        return height;
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
        }
    }
}
