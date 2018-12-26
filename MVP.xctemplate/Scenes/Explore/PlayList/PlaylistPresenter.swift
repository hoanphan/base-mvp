//
//  PlaylistPresenter.swift
//  FoxLive
//
//  Created by HOANPV on 10/5/18.
//  Copyright © 2018 HOANDHTB. All rights reserved.
//

import UIKit

protocol PlaylitsView: class {
    func refeshPlaylist()
    func displayPlaylistError(title: String, message: String)
    func showSkeleton()
    func hideSkeleton()
}

protocol PlaylistCellView {
    func setData(data: ItemPlayList)
}

protocol PlaylistPeresenter {
    var numberOfPlaylist: Int { get }
    var router: PlaylistViewRouter { get }
    func viewDidLoad()
}

class PlaylistPresentterImplementation: PlaylistPeresenter{
    fileprivate let country: ItemRegionEntity
    fileprivate weak var view: PlaylitsView?
    fileprivate let displayPlaylistUseCase: PlaylistUseCase
    internal let router: PlaylistViewRouter
    
    var listItem = [ItemPlayList]()
    
    var numberOfPlaylist: Int{
        return listItem.count
    }
    
    init(view: PlaylitsView, displayPlaylistUseCase: PlaylistUseCase, router: PlaylistViewRouter, country: ItemRegionEntity) {
        self.view = view
        self.displayPlaylistUseCase = displayPlaylistUseCase
        self.router = router
        self.country = country
    }
    
    func viewDidLoad() {
        let paramester = PlaylistParamester(type: "playlist", q: "Hot Music, Top Genres", maxResult: 25, part: "snippet", codeRegion: country.snippet!.gl, pageToken: "")
        self.displayPlaylistUseCase.fetch(paramester: paramester){
            (result) in
            switch result
            {
            case let .success(playlist):
                self.handlePlaylistReceived(playlist.items)
            case let .failure(error):
                self.handlePlaylistError(error)
            }
        }
    }
    
    fileprivate func handlePlaylistReceived(_ books: [ItemPlayList]) {
        self.listItem = books
        view?.refeshPlaylist()
    }
    
    fileprivate func handlePlaylistError(_ error: Error) {
        // Here we could check the error code and display a localized error message
        view?.displayPlaylistError(title: "Error", message: error.localizedDescription)
    }
}

