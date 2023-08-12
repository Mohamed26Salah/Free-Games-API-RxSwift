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

class ViewController: UIViewController {

    @IBOutlet weak var searchGamesBar: UISearchBar!
    @IBOutlet weak var gamesTableView: UITableView!
    var freeGamesViewMode = FreeGamesViewModel()
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        freeGamesViewMode.fetchGames()
        gamesTableView.register(UINib(nibName: "GameTableViewCell", bundle: nil), forCellReuseIdentifier: "GameTableViewCell")
        showData()
        // Do any additional setup after loading the view.
    }
    func showData() {
        freeGamesViewMode.games //Data
            .bind(to: gamesTableView //subscribe
                .rx
                .items(cellIdentifier: "GameTableViewCell", cellType: GameTableViewCell.self)) {
                    (tv, game, cell) in
                    cell.gameImage.sd_setImage(with: URL(string: game.thumbnail))
                    cell.gameNameLabel.text = game.title
                    cell.platFormLabel.text = game.platform?.rawValue
                    cell.gameDescription.text = game.shortDescription
                }
                .disposed(by: disposeBag)
    }

}

