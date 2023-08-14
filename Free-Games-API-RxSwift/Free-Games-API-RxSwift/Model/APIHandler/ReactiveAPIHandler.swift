//
//  ReactiveAPIHandler.swift
//  Free-Games-API-RxSwift
//
//  Created by Mohamed Salah on 14/08/2023.
//

import Foundation
import RxSwift

final class ReactiveAPIHandler {
    let disposeBag = DisposeBag()
    private enum Error: Swift.Error {
        case invalidResponse(URLResponse?)
        case invalidJSON(Swift.Error)
    }
    func fetch() -> Observable<[Game]> {
        let url = URL(
            string: "https://www.freetogame.com/api/games"
        )!
        let request = URLRequest(url: url)
        return URLSession.shared.rx.response(request: request)
            .map { result -> Data in
                guard result.response.statusCode == 200 else {
                    throw Error.invalidResponse(result.response)
                }
                return result.data
            }.map { data in
                do {
                    let games = try JSONDecoder().decode(
                        [Game].self, from: data
                    )
                    return games
                } catch let error {
                    throw Error.invalidJSON(error)
                }
            }
            .observe(on: MainScheduler.instance)
            .asObservable()
    }
}
