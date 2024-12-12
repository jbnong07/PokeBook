//
//  URLSession.swift
//  PokeBook
//
//  Created by 박진홍 on 12/10/24.
//

import CoreData
import UIKit

final class NetworkManager {
    static let shared = NetworkManager()
    private let imageCache = NSCache<NSString, UIImage>() // 이미지 캐시
    private let successRange: Range = (200..<300)
    
    // MARK: - Fetch random sprites
    func fetchPokemonSprites(completion: @escaping (String?) -> Void) {//네트워크 통신이 함수가 종료된 뒤에 완료될 수 있으므로 @escaping
        let pokemonID: Int = generatePokemonID()
        let urlString: String = "https://pokeapi.co/api/v2/pokemon/\(pokemonID)" //랜덤한 id를 가진 url 생성
        guard let url = URL(string: urlString) else { return } //url이 정상적인지 체크
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in//간단한 요청이므로 URLSesison을 따로 만들지 않고 공유세션 사용
            guard let self = self else { return }
            guard let data, error == nil else {//데이터와 에러를 체크하여 데이터가 없거나 에러가 있으면 종료
                print("Error: \(error?.localizedDescription ?? "Unknown")")
                completion(nil)
                return
            }
            if let response = response as? HTTPURLResponse {//타입 캐스팅
                if self.successRange.contains(response.statusCode) {//응답 코드가 성공인지 체크
                    do {
                        let pokemonSprite = try JSONDecoder().decode(PokemonData.self, from: data)//디코딩 시도
                        completion(pokemonSprite.sprites.backDefault)//성공 시 data 전달
                    } catch {
                        print("decoding error: \(error)")//디코딩 에러 처리
                        completion(nil)
                    }
                } else {
                    print("response error: \(response.statusCode)")//실패 시 상태코드 처리
                }
            }
        }.resume()//작업 시작
    }
    
    // MARK: - generate ID
    func generatePokemonID() -> Int {
        return Int.random(in: 1...500)
    }
}
