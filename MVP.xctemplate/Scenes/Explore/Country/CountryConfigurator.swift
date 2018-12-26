//
//  CountryConfigurator.swift
//  FoxLive
//
//  Created by HOANPV on 10/5/18.
//  Copyright © 2018 HOANDHTB. All rights reserved.
//

import UIKit

protocol CountryConfigurator {
    func configure(countryControler: CountryController)
}
class ContryConfiguratorImplementation:  CountryConfigurator {
    func configure(countryControler: CountryController) {
       
        let apiCountryGateway = ApiCountryGatewayImplementation()
       
       
        let displayBooksUseCase = DisplayCountryListUseCaseImplementation(countryGateWay: apiCountryGateway)
        
        let router = CountryViewRouterImplementation(countryController: countryControler)
        
        let presenter = CountryPresenterImplementation(view: countryControler, displayCountryUseCase: displayBooksUseCase, router: router)
        
        countryControler.presenter = presenter
    }
    
    
}
