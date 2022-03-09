//
//  StoreRequest.swift
//  MangoPlate
//
//  Created by 김영인 on 2022/03/09.
//

import Foundation
import Alamofire

class StoreRequest {
    
    func getStoreInfo() {
        
        let headers: HTTPHeaders = [
            "Authorization": "KakaoAK 51302fbcfac8fa678e74120eda31af22"
        ]
        
        let url = "https://dapi.kakao.com/v2/local/search/category.json"
        
        let parameters: [String: Any] = [
            "category_group_code": "FD6",
            "x": 126.8010862383141,
            "y": 37.51189220888594,
            "radius": 20000
        ]
        
        AF.request(url,
                   method: .get,
                   parameters: parameters,
                   headers: headers)
            .responseDecodable(of: StoreInfo.self) { response in
                
                switch response.result {
                    
                case .success(let response):
                    print("DEBUG>> RESPONSE \(response)")
                    
                case .failure(let error):
                    print("DEBUG>> ERROR: \(error.localizedDescription)")
                }
            }
        
    }
    
}
