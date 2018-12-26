//
//  BooksViewRouter.swift
//  FoxLive
//
//  Created by HOANPV on 10/5/18.
//  Copyright © 2018 HOANDHTB. All rights reserved.
//
import UIKit

protocol CountryViewRouter: ViewRouter {
    func presentPlayList(for country: ItemRegionEntity)
}

class CountryViewRouterImplementation: CountryViewRouter {
    fileprivate weak var countryController: CountryController?
    fileprivate var country: ItemRegionEntity!
    init(countryController: CountryController) {
        self.countryController = countryController
    }
    
    func presentPlayList(for country: ItemRegionEntity) {
        self.country = country
        countryController?.performSegue(withIdentifier: SegueIdentifier.goPlayLitsController, sender: nil)
    }
    
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let playlistController = segue.destination as? PlaylistController
        {
            playlistController.configurator = PlaylistConfiguratorImplementation(country: self.country)
        }
    }

}
