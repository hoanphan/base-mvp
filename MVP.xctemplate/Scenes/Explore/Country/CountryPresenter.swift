//
//  CountryPresenter.swift
//  FoxLive
//
//  Created by HOANPV on 10/5/18.
//  Copyright © 2018 HOANDHTB. All rights reserved.
//

import Foundation


protocol CountryView: class {
    func refreshCountryView()
    func displayCountryRetrievalError(title: String, message: String)
}

protocol CountryCellView{
    func display(itemRegion: ItemRegionEntity)
}

protocol CountryPresenter {
    var numberOfCountry: Int {get}
    var router: CountryViewRouter{get}
    func viewDidLoad()
    func configure(cell: CountryCellView, forRow row: Int)
    func didSelect(row: Int)
  
}
class CountryPresenterImplementation: CountryPresenter {
    fileprivate weak var view: CountryView?
    fileprivate let displayCountryUseCase: DisplayCountryListUseCase
    internal let router: CountryViewRouter
    
    var countries = [ItemRegionEntity]()
    var numberOfCountry: Int {
        return countries.count
    }
    
    
    init(view: CountryView, displayCountryUseCase: DisplayCountryListUseCase, router: CountryViewRouter) {
        self.view = view
        self.displayCountryUseCase = displayCountryUseCase
        self.router = router
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func viewDidLoad() {
        LoadingHUDControl.sharedManager.showLoadingHud()
        self.displayCountryUseCase.displayCountry(type: "snippet", language: "en"){
            (result) in
            switch result
            {
            case let .success(region):
                LoadingHUDControl.sharedManager.hideLoadingHud()
                self.handleCountryReceived(region.items)
            case let .failure(error):
                LoadingHUDControl.sharedManager.hideLoadingHud()
                self.handleCountryError(error)
                
            }
        }
    }
    
    fileprivate func handleCountryReceived(_ countries: [ItemRegionEntity]) {
        self.countries = countries
        view?.refreshCountryView()
    }
    
    fileprivate func handleCountryError(_ error: Error)
    {
        view?.displayCountryRetrievalError(title: "Error", message: error.localizedDescription)
    }
    
    func configure(cell: CountryCellView, forRow row: Int) {
        let country = self.countries[row]
        cell.display(itemRegion: country)
    }
    
     func didSelect(row: Int)
     {
        router.presentPlayList(for: self.countries[row])
    }
}
