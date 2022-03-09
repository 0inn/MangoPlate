//
//  MainCollectionViewCell.swift
//  MangoPlate
//
//  Created by 김영인 on 2022/03/09.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var storeImg: UIImageView!
    @IBOutlet weak var storeName: UILabel!
    @IBOutlet weak var storeDist: UILabel!
    @IBOutlet weak var storeScore: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func setData( _ data: Document) {
        storeName.text = data.place_name
        let dist = Double(data.distance!)! / Double(1000)
        let distStr = String(format: "%.2f", dist)
        storeDist.text = "부천시 \(distStr) km"
    }

}
