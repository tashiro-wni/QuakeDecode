//
//  ViewController.swift
//  QuakeDecode
//
//  Created by Tomohiro Tashiro on 7/30/17.
//  Copyright © 2017 test. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var mTableView: UITableView!
    private let cellIdentifier = "cellIdentifier"
    private var quakeList: [Quake] = []
    
    //MARK: - viewController life cycle
    deinit {
        if mTableView != nil {
            mTableView.delegate = nil
            mTableView.dataSource = nil
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mTableView = UITableView(frame: self.view.bounds, style: .plain)
        mTableView.delegate = self
        mTableView.dataSource = self
        mTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        self.view.addSubview(mTableView)
        
        QuakeLoader.get(completion: dataLoaded(_:))
    }
    
    func dataLoaded(_ list: [Quake]?) {
        guard let list = list else { print("load failed."); return }
        
        quakeList = list
        DispatchQueue.main.async { [weak self] in
            self?.mTableView.reloadData()
        }
    }
    
    //MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quakeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        if indexPath.row < quakeList.count {
            let quake = quakeList[indexPath.row]
            cell.textLabel?.text = "\(quake.cell_atime), \(quake.spot), M\(quake.magnitude), 最大震度:\(quake.maxclass)"
        }
        
        return cell
    }
    
}

