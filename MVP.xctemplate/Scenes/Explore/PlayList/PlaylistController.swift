//
//  PlayLitsController.swift
//  FoxLive
//
//  Created by HOANPV on 10/5/18.
//  Copyright © 2018 HOANDHTB. All rights reserved.
//

import UIKit

class PlaylistController: BaseViewController, PlaylitsView {
    var configurator: PlaylistConfigurator!
    var presenter: PlaylistPeresenter!
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configurator(playlistController: self)
        presenter.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    func refeshPlaylist() {
        
    }
    
    func displayPlaylistError(title: String, message: String) {
        
    }
    
    func showSkeleton() {
        
    }
    
    func hideSkeleton() {
        
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
