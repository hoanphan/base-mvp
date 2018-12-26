//
//  PlaylistConfig.swift
//  FoxLive
//
//  Created by HOANPV on 10/5/18.
//  Copyright © 2018 HOANDHTB. All rights reserved.
//

import UIKit

protocol PlaylistConfigurator {
    func configurator(playlistController: PlaylistController)
}

class PlaylistConfiguratorImplementation: PlaylistConfigurator {
    let country: ItemRegionEntity
    
    init(country: ItemRegionEntity) {
        self.country = country
    }
    func configurator(playlistController: PlaylistController) {
        
        let apiPlaylistGateway = ApiPlaylistGatewayImplemention()
        
        let displayPlaylistUseCase = PlaylistUseCaseImplemention(playlistGateway: apiPlaylistGateway)
        
        let router = PlaylistViewRouterImplemetation(playlistController: playlistController)
        
        let presenter = PlaylistPresentterImplementation(view: playlistController, displayPlaylistUseCase: displayPlaylistUseCase, router: router, country: self.country)
        
        playlistController.presenter = presenter
        
    }
    
}
