//
//  CollectionViewController.swift
//  InfiniteScrollDemo
//
//  Created by Arnaldo Rozon on 12/30/20.
//

import UIKit

class CollectionViewController: UICollectionViewController {
    
    var data = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .systemTeal
        getData()
    }
    
    func getData() {
        MockAPI.shared.fetchData(paginating: false) { [weak self] (result) in
            switch result {
                case .success(let responseData):
                    self?.data.append(contentsOf: responseData)
                    DispatchQueue.main.async { self?.collectionView.reloadData() }
                    print("Successfully fetched data")
                    break
                case .failure(_):
                    print("Error fetching original data")
                    break
            }
        }
    }
    
}

// MARK: UICollectionViewDataSource

extension CollectionViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("Number of items in cell", data.count)
        return data.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cvCell, for: indexPath)
        let textLabel = UITextView(frame: .zero);
        
        textLabel.backgroundColor = .blue
        textLabel.text = String(indexPath.row)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        cell.contentView.addSubview(textLabel)
        
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: cell.contentView.topAnchor),
            textLabel.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor),
            textLabel.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor),
            textLabel.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor)
        ])
        
        cell.contentView.backgroundColor = .green
        
        return cell
    }
    
}
