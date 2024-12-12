//
//  URLSession.swift
//  PokeBook
//
//  Created by 박진홍 on 12/10/24.
//
import Foundation
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
        /*
         각 숫자를 누적하고 랜덤한 수를 뽑은 뒤 누적된 수에 해당하는 포켓몬을 반환하여
         다른 확률로 나오는 포켓몬 뽑기
         */
        let pokemonProbabilities: [(id: Int, probability: Double)] = [
            (13, 0.30),  // 뿔충이
            (19, 0.30),  // 꼬렛
            (16, 0.30),  // 구구
            (25, 0.01), // 피카츄
            (4, 0.03),  // 파이리
            (7, 0.03),  // 꼬부기
            (1, 0.03)   // 이상해씨
        ]
        
        var cumulative = 0.0
        
        //각각의 가중치를 누적하
        let cumulativeProbabilities = pokemonProbabilities.map { item -> (Int, Double) in
            cumulative += item.probability
            return (item.id, cumulative)
        }
        
        // 0.0 ~ 1.0 사이의 무작위 값 생성
        let randomValue = Double.random(in: 0...1)
        
        // 확률 범위에 따라 포켓몬 선택
        for (id, cumulativeProbability) in cumulativeProbabilities {
            if randomValue <= cumulativeProbability {
                return id
            }
        }
        
        return 0//기본값
    }
}
