//
//  ViewController.swift
//  task-for-oson
//
//  Created by Fedya on 26/05/23.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    
    let tableView = UITableView()
    
    
    var categoryData = CategoryData()
    var parentCategoryList: [Category] = []
    var childCategoryList: [Category] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        initNetworkData()
    }
    
    
    func setupTableView() {
        
        view.addSubview(tableView)
       
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func initNetworkData() {
        
        let categoryArr = [Category(id: 33, parentId: 11, childs: []),
                           Category(id: 11, parentId: 0, childs: []),
                           Category(id: 34, parentId: 11, childs: []),
                           Category(id: 57, parentId: 13, childs: []),
                           Category(id: 45, parentId: 12, childs: []),
                           Category(id: 12, parentId: 0, childs: []),
                           Category(id: 46, parentId: 12, childs: []),
                           Category(id: 13, parentId: 0, childs: []),
                           Category(id: 58, parentId: 13, childs: [])]
        
        self.categoryData = CategoryData(categoryList: CategoryList(array: categoryArr))
        
        
        if let parentList = categoryData.categoryList?.makeTree() {
            self.parentCategoryList = parentList
                        
            tableView.reloadData()
        }
    }
    
    
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return parentCategoryList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        childCategoryList = parentCategoryList[section].childs ?? []
        
        return childCategoryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
         
        let child = parentCategoryList[indexPath.section].childs?[indexPath.row]
        cell.textLabel?.text = "id: \(child?.id ?? 0)" //"parentId: \(child?.parentId ?? 0)" + "id: \(child?.id ?? 0)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "parentId: \(parentCategoryList[section].id ?? 0)"
    }
}
