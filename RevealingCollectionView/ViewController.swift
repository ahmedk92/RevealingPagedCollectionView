//
//  ViewController.swift
//  RevealingCollectionView
//
//  Created by Arabia -IT on 7/2/18.
//  Copyright © 2018 Arabia-IT. All rights reserved.
//

import UIKit

let colors = [UIColor.red, .green, .blue]
let cellCount = 10
let pageWidthRatio: CGFloat = 0.9

class Cell: UICollectionViewCell {
    @IBOutlet var bgView: UIView!
}

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet private var collectionView: UICollectionView!
    @IBOutlet private var secretScrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        collectionView.isPagingEnabled = true
        
        collectionView.addGestureRecognizer(secretScrollView.panGestureRecognizer)
        collectionView.panGestureRecognizer.isEnabled = false
        
        collectionView.contentInset = UIEdgeInsets.init(top: 0, left: (self.view.frame.size.width - pageWidthRatio * self.view.frame.size.width)/2, bottom: 0, right: (self.view.frame.size.width - pageWidthRatio * self.view.frame.size.width)/2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        secretScrollView.contentSize = CGSize.init(width: collectionView.frame.size.width * pageWidthRatio * CGFloat(cellCount), height: collectionView.frame.size.height)
        return cellCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! Cell
        cell.bgView.backgroundColor = colors[indexPath.row % colors.count]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size.applying(.init(scaleX: pageWidthRatio, y: 1))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == secretScrollView {
            var offset = secretScrollView.contentOffset
            offset.x -= collectionView.contentInset.left
            collectionView.contentOffset = offset
        }
    }

}

