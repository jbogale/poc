//
//  ViewController.swift
//  test2
//
//  Created by Joseph Bogale on 5/22/18.
//  Copyright © 2018 Joseph Bogale. All rights reserved.
//

import UIKit

class Item {
    let title: String
    init (title: String){
        self.title = title
     }
}


class ViewController: UIViewController{
    @IBOutlet weak var uiCollectionView: UICollectionView!
    @IBOutlet weak var IndicatorStackView: UIStackView!
    @IBOutlet weak var indicatorContainer: UIView!
    
    @IBOutlet weak var indicatorContainerTrailingConstraint: NSLayoutConstraint!
    let numberOfItems = 5
    var items = [Item]()
    var indicators = [IndicatorView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiCollectionView.dataSource = self

        for i in 0...numberOfItems - 1 {
            let title = "Offer " + String(i)
            let  item = Item(title: title)
            items.append(item)
            let indicator = IndicatorView()
            IndicatorStackView.addArrangedSubview(indicator)
            indicators.append(indicator)
        }
        setIndicatorContainerWidth()
    }
    
    
    private func setIndicatorContainerWidth() {
        let minWidth = indicatorContainer.bounds.width
        let countForMinWidth = 5
        let countForMaxWidth = 10
        
        if indicators.count <= countForMinWidth {
            indicatorContainerTrailingConstraint.constant =  minWidth * -0.5
        } else if indicators.count  < countForMaxWidth {
            let pad = CGFloat(countForMaxWidth -  indicators.count) / CGFloat(countForMaxWidth)
            indicatorContainerTrailingConstraint.constant = minWidth * pad * -1
        }
        view.layoutIfNeeded()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellItemID", for: indexPath) as! CollectionViewCell
        cell.label.text = items[indexPath.row].title
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        indicators.forEach { indicator in
            indicator.indicatorOn = false
        }
        indicators[indexPath.row].indicatorOn = true
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let height = collectionView.bounds.height
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat{
        return 0
    }
}
