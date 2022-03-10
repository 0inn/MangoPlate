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
    
    var mainModel: [Document]?
    var mainImgModel: [ImgDocument]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setCollectionView()
        getAPI()
    }
    
    // MARK: 네비게이션 바 설정
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
    
    // MARK: 맛집 컬렉션 뷰
    private func setCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "MainCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MainCollectionViewCell")
    }
    
    // API 호출해서 데이터 받아온 후에 UI 그리기
    private func getAPI() {
        StoreRequest.getStoreInfo { (mainModel) in
            self.mainModel = mainModel!
            self.collectionView.reloadData()
            self.getImgAPI()
        }
    }
    
    private func getImgAPI() {
        print("count \(mainModel?.count)")
        for i in 0 ... (mainModel!.count - 1) {
            ImageRequest.getImgInfo(mainModel?[i].place_name) { (mainImgModel) in
                self.mainImgModel = mainImgModel
                print("\(self.mainModel?[i].place_name)")
                print("\(mainImgModel)")
            }
        }
    }
    
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainModel?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as! MainCollectionViewCell
        let cellData = mainModel![indexPath.row]
        cell.setData(cellData)
        return cell
    }
    
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else { return CGSize() }
        let numberOfCells: CGFloat = 2
        let width = collectionView.frame.size.width - (flowLayout.minimumInteritemSpacing * (numberOfCells - 1))
        return CGSize(width: width/(numberOfCells), height: width/(numberOfCells) + 100)
    }
}
