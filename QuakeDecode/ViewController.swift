//
//  ViewController.swift
//  QuakeDecode
//
//  Created by Tomohiro Tashiro on 7/30/17.
//  Copyright © 2017 test. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private lazy var tableView = UITableView(frame: view.bounds, style: .plain)
    private let cellIdentifier = "cellIdentifier"
    private var quakeList: [Quake] = []
    
    // MARK: - viewController life cycle
    deinit {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        view.addSubview(tableView)
        
        QuakeLoader.get(completion: dataLoaded(_:))
    }
    
    private func dataLoaded(_ list: [Quake]?) {
        guard let list = list else { print("load failed."); return }
        
        quakeList = list
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}
    
// MARK: - UITableViewDelegate, UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quakeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        guard indexPath.row < quakeList.count else { return cell }
        
        let quake = quakeList[indexPath.row]
        cell.textLabel?.text = "\(quake.cell_atime), \(quake.spot), M\(quake.magnitude), 最大震度:\(quake.maxclass)"
        
        return cell
    }
}
