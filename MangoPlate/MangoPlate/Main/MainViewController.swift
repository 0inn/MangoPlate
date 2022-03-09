//
//  MainViewController.swift
//  MangoPlate
//
//  Created by 김영인 on 2022/03/07.
//

import UIKit
import SnapKit
import Then

class MainViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setCollectionView()
    }
    
    private func setNavigationBar() {
        //let view = UIView()   // leftNavigationBarItem자리
        let searchBtn = makeBtn("magnifyingglass")
        let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        spacer.width = 15
        let mapBtn = makeBtn("map")
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: mapBtn), spacer,  UIBarButtonItem(customView: searchBtn)]
        
    }
    
    private func makeBtn( _ name: String) -> UIButton {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: name), for: .normal)
        btn.tintColor = .systemGray
        return btn
    }
    
    private func setCollectionView() {
        
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
}

