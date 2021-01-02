//
//  TableViewController.swift
//  InfiniteScrollDemo
//
//  Created by Arnaldo Rozon on 12/30/20.
//

import UIKit

class TableViewController: UITableViewController {
    
    var data = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }
    
    func getData() {
        MockAPI.shared.fetchData(paginating: false) { [weak self] (result) in
            switch result {
                case .success(let responseData):
                    self?.data.append(contentsOf: responseData)
                    DispatchQueue.main.async { self?.tableView.reloadData() }
                    break
                case .failure(_):
                    print("Error fetching original data")
                    break
            }
        }
    }
    
}

// MARK: - Table view data source

extension TableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.tvCell, for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    
}

// MARK: - Scroll view delegate

extension TableViewController {
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        
        if position > (tableView.contentSize.height - 100 - scrollView.frame.size.height) {
            
            guard !MockAPI.shared.isLoadingResults else { return }
            
            MockAPI.shared.fetchData(paginating: true) { [weak self] (result) in
                switch result {
                    case .success(let responseData):
                        self?.data.append(contentsOf: responseData)
                        DispatchQueue.main.async { self?.tableView.reloadData() }
                        break
                    case .failure(_):
                        print("Error fetching paginated result")
                        break
                }
            }
        }
    }
    
}
