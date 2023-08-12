//
//  FreeGamesViewModel.swift
//  Free-Games-API-RxSwift
//
//  Created by Mohamed Salah on 12/08/2023.
//

import Foundation
import RxSwift

class FreeGamesViewModel {
    private let provider = NetworkAPIProvider()
    
    var games = BehaviorSubject(value: [Game]())
    
    func fetchGames() {
        let baseURL = URL(string: "https://www.freetogame.com/api/games")
        guard let apiURL = baseURL else {
            fatalError("Failed to create baseURL")
        }
        let apiHandler = APIClient(baseURL: apiURL, apiProvider: provider)
        apiHandler.fetchResourceData { (result: Result<DecodedGames, Error>) in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.games.on(.next(data))
                }
            case .failure(let error):
                print("Slaah")
                print(error)
            }
        }

    }

}
