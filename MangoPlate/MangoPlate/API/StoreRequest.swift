//
//  StoreRequest.swift
//  MangoPlate
//
//  Created by 김영인 on 2022/03/09.
//

import Foundation
import Alamofire

class StoreRequest {
    
    // 탈출 클로저 @escaping 사용하여 데이터 받을 때까지 기다려야 함
    // WHY? Alamofire는 비동기적으로 동작하기 때문
    static func getStoreInfo(completion: @escaping ([Document]?) -> Void) {
        
        var storeStorage: [Document]?
        
        let headers: HTTPHeaders = [
            "Authorization": "KakaoAK 51302fbcfac8fa678e74120eda31af22"
        ]
        
        let url = "https://dapi.kakao.com/v2/local/search/category"
        
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
                    storeStorage = response.documents
                    completion(storeStorage)
                    print(#function)
                    
                case .failure(let error):
                    print("DEBUG>> ERROR: \(error.localizedDescription)")
                }
            }
        
    }
    
}
