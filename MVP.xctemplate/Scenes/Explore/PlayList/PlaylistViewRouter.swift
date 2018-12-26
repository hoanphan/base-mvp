//
//  PlaylistViewRouter.swift
//  FoxLive
//
//  Created by HOANPV on 10/5/18.
//  Copyright © 2018 HOANDHTB. All rights reserved.
//

import Foundation

protocol PlaylistViewRouter: ViewRouter {
    
}

class PlaylistViewRouterImplemetation: PlaylistViewRouter
{
    fileprivate weak var playlistController: PlaylistController?
    
    init(playlistController: PlaylistController) {
        self.playlistController = playlistController
    }
}
