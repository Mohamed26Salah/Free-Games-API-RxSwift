//
//  FreeGamesViewModel.swift
//  Free-Games-API-RxSwift
//
//  Created by Mohamed Salah on 12/08/2023.
//

import Foundation
import RxSwift
import RxRelay

class FreeGamesViewModel {
    
    private let provider = NetworkAPIProvider()
    
    var games = BehaviorRelay<[Game]>(value: [])
    var gameelnaggar = [Game]()
    func filterGame(query: String) {
        let gamesFilterArray = gameelnaggar.filter { game in
            query.isEmpty || game.title.localizedCaseInsensitiveContains(query)
        }
        games.accept(gamesFilterArray)
    }
    
    func fetchGames() {
        let baseURL = URL(string: "https://www.freetogame.com/api/games")
        guard let apiURL = baseURL else {
            fatalError("Failed to create baseURL")
        }
        let apiHandler = APIClient(baseURL: apiURL, apiProvider: provider)
        //as is // zy ma elktab bykool by eng ahmed
        apiHandler.fetchResourceData(model: [Game].self) { (result: Result<DecodedGames, Error>) in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    //                    self.games.on(.next(data))
                    self.games.accept(data)
                    self.gameelnaggar = data
                }
            case .failure(let error):
                print("Slaah")
                print(error)
            }
        }
        
    }
    
}
