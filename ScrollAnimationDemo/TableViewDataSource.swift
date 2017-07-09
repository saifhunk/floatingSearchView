//
//  TableViewDataSource.swift
//  Realm
//
//  Created by Night Reaper on 29/09/15.
//  Copyright (c) 2015 Gagan. All rights reserved.
//


import UIKit

typealias  ListCellConfigureBlock = (_ cell : AnyObject , _ item : AnyObject? , _ indexpath: AnyObject?) -> ()
typealias  DidSelectedRow = (_ indexPath : IndexPath) -> ()
typealias  ScrollViewDidScroll = (_ scrollView : UIScrollView) -> ()
typealias ViewForHeaderInSection = (_ section : Int) -> UIView?


class TableViewDataSource: NSObject  {
    
    var items : Array<AnyObject>?
    var cellIdentifier : String?
    var tableView  : UITableView?
    var tableViewRowHeight : CGFloat = 44.0
    
    var configureCellBlock : ListCellConfigureBlock?
    var aRowSelectedListener : DidSelectedRow?
    var ScrollViewListener : ScrollViewDidScroll?
    var viewforHeaderInSection : ViewForHeaderInSection?
    var headerHeight : CGFloat?
    
    
    
    init (items : Array<AnyObject>? , height : CGFloat , tableView : UITableView? , cellIdentifier : String?  , configureCellBlock : ListCellConfigureBlock? , aRowSelectedListener : @escaping DidSelectedRow , DidScrollListener : @escaping ScrollViewDidScroll) {
        
        self.tableView = tableView
        self.items = items
        self.cellIdentifier = cellIdentifier
        self.tableViewRowHeight = height
        self.configureCellBlock = configureCellBlock
        self.aRowSelectedListener = aRowSelectedListener
        self.ScrollViewListener = DidScrollListener
       
        
    }
    
    override init() {
        super.init()
       
    }
    

}

extension TableViewDataSource : UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let identifier = cellIdentifier else{
            fatalError("Cell identifier not provided")
        }
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: identifier , for: indexPath) as UITableViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        if let block = self.configureCellBlock , let item: AnyObject = self.items?[(indexPath as NSIndexPath).row]{
            block(cell , item , indexPath as AnyObject?)
        }
        return cell
    }
    
    

    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let block = self.aRowSelectedListener{
            block(indexPath)
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items?.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableViewRowHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let block = viewforHeaderInSection else { return nil }
        return block(section)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {

        return headerHeight ?? 0.0
    }
    

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if let block = self.ScrollViewListener{
            
            block(scrollView)
        }
    }

}
