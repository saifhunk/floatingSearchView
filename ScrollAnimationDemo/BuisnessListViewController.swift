//
//  BuisnessListViewController.swift
//  ScrollAnimationDemo


//  Created by Saif Chaudhary on 7/9/17.
//  Copyright © 2017 Saif Chaudhary. All rights reserved.

import UIKit

class BuisnessListViewController: UIViewController {
    
    //MARK: - outlets
    //TableView
    @IBOutlet weak var tableView: UITableView!
    
    var viewSearchHeight : CGFloat = 56
    
    //Button
    @IBOutlet weak var btnCancelSearch: UIButton!

    @IBOutlet weak var tfSearch: UITextField!
    
    @IBOutlet weak var constarintTopSearch: NSLayoutConstraint!
    
    @IBOutlet weak var stackViewHeader: UIStackView!
    
    // MARK: class properties
    
    var dataSource:TableViewDataSource?{
        didSet{
            tableView?.dataSource = dataSource
            tableView?.delegate = dataSource
        }
    }
    
    
    //MARK: - view hierarchy
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
}





//MARK: - setupTableView

extension BuisnessListViewController  {
    
    func setupTableView(){
        
        tableView.estimatedRowHeight = 56
        
        dataSource = TableViewDataSource(items: ["" as AnyObject,"" as AnyObject,"" as AnyObject,"" as AnyObject,"" as AnyObject,"" as AnyObject,"" as AnyObject,"" as AnyObject], height: UITableViewAutomaticDimension , tableView: tableView, cellIdentifier: cellId.nearByListCell.string(), configureCellBlock: { (cell, item, indexPath) in
            
        }, aRowSelectedListener: {(indexPath) in
            
            
            
        }, DidScrollListener: { (scrollview) in
            
            if self.tableView.contentSize.height > (ScreenSize.SCREEN_HEIGHT){
                
                weak var weakSelf  = self
                
                let barOffset = (-scrollview.contentOffset.y + self.viewSearchHeight)
                weakSelf?.constarintTopSearch.constant = barOffset > 0 ? 0 : (barOffset < -self.viewSearchHeight ? -self.viewSearchHeight : barOffset)
                
                
            }
            
            
        })
        
        tableView?.reloadSections(NSIndexSet(index: 0) as IndexSet, with: .automatic)
    }
    
    
    
}


struct ScreenSize
{
    static let SCREEN_WIDTH = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCALE = UIScreen.main.scale
    static let ratio1619 = (0.5625 * ScreenSize.SCREEN_WIDTH)
}


enum cellId {
    
    case nearByListCell
    
    
    func string() -> String {
        
        switch self {
        case .nearByListCell:
            return "NearByListCell"
            
        }
    }
    
    
}
