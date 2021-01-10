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
        
        textLabel.backgroundColor = .systemPurple
        textLabel.text = String(indexPath.row)
        textLabel.font = UIFont.boldSystemFont(ofSize: 24)
        textLabel.textAlignment = .center
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        cell.contentView.addSubview(textLabel)
        cell.contentView.layer.cornerRadius = 6
        cell.contentView.layer.masksToBounds = true
        
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: cell.contentView.topAnchor),
            textLabel.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor),
            textLabel.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor),
            textLabel.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor)
        ])
        
        cell.contentView.backgroundColor = .green
        
        return cell
    }
    
}

// MARK: - Scroll view delegate

extension CollectionViewController {
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        let collectionViewHeight = collectionView.collectionViewLayout.collectionViewContentSize.height
        let scrollViewFrameHeight = scrollView.frame.size.height
        let calc = (collectionViewHeight - 250 - scrollViewFrameHeight)
        
        print("Position", position)
//        print("Collection view height", collectionViewHeight)
//        print("Scroll view frame height", scrollViewFrameHeight)
        print("Calc", calc)
        
        if Int(position) > Int(calc) {
            guard !MockAPI.shared.isLoadingResults else { return }
            
            MockAPI.shared.fetchData(paginating: true) { [weak self] (result) in
                switch result {
                    case .success(let responseData):
                        self?.data.append(contentsOf: responseData)
                        DispatchQueue.main.async { self?.collectionView.reloadData() }
                        break
                    case .failure(_):
                        print("Error fetching paginated result")
                        break
                }
            }
        }
    }
    
}
