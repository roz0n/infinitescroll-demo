//
//  ViewController.swift
//  InfiniteScrollDemo
//
//  Created by Arnaldo Rozon on 12/30/20.
//

import UIKit

struct Constants {
    static let title = "Infinite Scroll Demo"
    static let directions = "Select a view type to begin..."
    static let tv = "UITableView"
    static let cv = "UICollectionView"
}

class ViewController: UIViewController {
    
    var buttons = [UIButton]()
    var stack = UIStackView()
    
    var tableView = TableViewController()
    var collectionView = CollectionViewController(collectionViewLayout: UICollectionViewLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constants.title
        
        configureLabel()
        configureStack()
        configureButtons()
    }
    
    let titleLabel: UILabel = {
        let tl = UILabel()
        
        tl.translatesAutoresizingMaskIntoConstraints = false
        tl.text = Constants.directions
        tl.font = UIFont.monospacedSystemFont(ofSize: 14, weight: .medium)
        tl.adjustsFontSizeToFitWidth = true
        tl.numberOfLines = 0
        tl.textAlignment = .center
        
        return tl
    }()
    
    func configureLabel() {
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    func configureStack() {
        view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        // Axis, dist, spacing
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 20
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            stack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            stack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    func configureButtons() {
        let buttonLabels: [String: UIColor] = [Constants.tv: UIColor.systemTeal, Constants.cv: UIColor.systemIndigo]
        
        for label in buttonLabels {
            let btn = FancyButton()
            
            btn.setTitle(label.key, for: .normal)
            btn.backgroundColor = label.value
            btn.translatesAutoresizingMaskIntoConstraints = false
            btn.addTarget(self, action: #selector(presentVC(_:)), for: .touchUpInside)
            
            buttons.append(btn)
            stack.addArrangedSubview(btn)
        }
    }
    
    @objc func presentVC(_ sender: UIButton) {
        switch sender.title(for: .normal) {
            case Constants.cv:
                present(collectionView, animated: true)
            case Constants.tv:
                present(tableView, animated: true)
            default:
                break
        }
    }
    
}

