//
//  FreeGamesParser.swift
//  Free-Games-API-RxSwift
//
//  Created by Mohamed Salah on 12/08/2023.
//

import Foundation
import OptionallyDecodable

// MARK: - DecodeSceneElement
struct Game: Codable {
    var id: Int
    var title: String
    var thumbnail: String
    var shortDescription: String
    var gameURL: String
    var genre: Genre?
    var platform: Platform?
    var publisher: String
    var developer: String
    var releaseDate: String
    var freetogameProfileURL: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case thumbnail = "thumbnail"
        case shortDescription = "short_description"
        case gameURL = "game_url"
        case genre = "genre"
        case platform = "platform"
        case publisher = "publisher"
        case developer = "developer"
        case releaseDate = "release_date"
        case freetogameProfileURL = "freetogame_profile_url"
    }
}

enum Genre: String, Codable {
    case actionRPG = "Action RPG"
    case arpg = "ARPG"
    case battleRoyale = "Battle Royale"
    case cardGame = "Card Game"
    case fantasy = "Fantasy"
    case fighting = "Fighting"
    case genreMMORPG = " MMORPG"
    case mmo = "MMO"
    case mmoarpg = "MMOARPG"
    case mmorpg = "MMORPG"
    case moba = "MOBA"
    case racing = "Racing"
    case shooter = "Shooter"
    case social = "Social"
    case sports = "Sports"
    case strategy = "Strategy"
}

enum Platform: String, Codable {
    case pcWindows = "PC (Windows)"
    case pcWindowsWebBrowser = "PC (Windows), Web Browser"
    case webBrowser = "Web Browser"
}

typealias DecodedGames = [Game]
