//
//  ViewController.swift
//  Free-Games-API-RxSwift
//
//  Created by Mohamed Salah on 12/08/2023.
//

import UIKit
import RxSwift
import RxCocoa
import SDWebImage

class ViewController: UIViewController, UISearchBarDelegate{

    @IBOutlet weak var searchGamesBar: UISearchBar!
    @IBOutlet weak var gamesTableView: UITableView!
    var freeGamesViewModel = FreeGamesViewModel()
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        freeGamesViewModel.fetchGames()
        gamesTableView.register(UINib(nibName: "GameTableViewCell", bundle: nil), forCellReuseIdentifier: "GameTableViewCell")
        showData()
//        let reactiveAPIHandler = ReactiveAPIHandler()
//        reactiveAPIHandler.fetch().subscribe(onNext: { games in
//            print(games.count)
//        }, onError: { error in
//            print(error)
//        }).disposed(by: disposeBag)
        // Do any additional setup after loading the view.
    }
    func showData() {
        
        searchGamesBar.rx.text.orEmpty.asDriver().skip(1).drive(onNext: {[weak self] query in
            self?.freeGamesViewModel.filterGame(query: query)
        })
        .disposed(by: disposeBag)
        
//        searchGamesBar.rx.text.orEmpty
//            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
//            .distinctUntilChanged()
//            .filter { query in
//                freeGamesViewModel.games.value.forEach { game in
//                query.title == game.title
//                }
//            }

//            .map { [weak self] query in
//                guard let self = self else {
//                    return
//                }
//                self.freeGamesViewModel.games.value.filter { game in
//                    query.isEmpty || game.title.lowercased().contains(query.lowercased())
//                }
//            }
        freeGamesViewModel.games
            .bind(to: gamesTableView //subscribe
                .rx
                .items(cellIdentifier: "GameTableViewCell", cellType: GameTableViewCell.self)) {
                    (tv, game, cell) in
                    //tv --> rOW --> IndexPath
                    cell.gameImage.sd_setImage(with: URL(string: game.thumbnail))
                    cell.gameNameLabel.text = game.title
                    cell.platFormLabel.text = game.platform?.rawValue
                    cell.gameDescription.text = game.shortDescription
                }
                .disposed(by: disposeBag)
    }

}

