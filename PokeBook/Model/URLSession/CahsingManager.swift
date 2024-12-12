//
//  CahsingManager.swift
//  PokeBook
//
//  Created by 박진홍 on 12/12/24.
//

import UIKit

final class ImageCacheManager {//매번 url을 통해 이미지를 새로 받아오니 업데이트가 한 박자 느림을 느낌 
    static let shared = ImageCacheManager()
    private let cache = NSCache<NSString, UIImage>()
    
    private init() {
        cache.countLimit = 100 //캐시할 최대 수
        cache.totalCostLimit = 1024 * 1024 * 100 // 100MB로 비용 제한
    }
    
    func getImage(for url: String) -> UIImage? {
        return cache.object(forKey: url as NSString)
    }
    
    func saveImage(_ image: UIImage, for url: String) {
        cache.setObject(image, forKey: url as NSString)
    }
}
