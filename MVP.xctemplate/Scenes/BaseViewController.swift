//
//  BaseViewController.swift
//  BaseSwift
//
//  Created by nava on 7/13/18.
//  Copyright © 2018 nava. All rights reserved.
//

import UIKit
import RxSwift
class BaseViewController: UIViewController {
    let disposeBag = DisposeBag()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        initInterface()
        initData()
        initNotification()
        validate()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initInterface(){
       
        //TODO: abstract - do nothing
    }
    
    func initData(){
        //TODO: abstract - do nothing
    }
    
    
    func initNotification()
    {
        
    }
    
    func validate() {
    }
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension BaseViewController {
    func showAlertWith(title: String? = nil, message: String? = nil,
                       titleDefault: String? = nil, titleCancel: String? = nil,
                       handlerDefault: ((UIAlertAction) -> Swift.Void)? = nil,
                       handlerCancel: ((UIAlertAction) -> Swift.Void)? = nil) {
        // alert
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        if let titleDefault = titleDefault {
            alertVC.addAction(UIAlertAction(title: titleDefault, style: UIAlertActionStyle.default, handler:handlerDefault))
        }
        if let titleCancel = titleCancel {
            alertVC.addAction(UIAlertAction(title: titleCancel, style: UIAlertActionStyle.cancel, handler:handlerCancel))
        }
        
        // present
        self.present(alertVC, animated: true, completion: nil)
    }
    func showAlertWithOnlyCancelAction(title: String? = nil, message: String? = nil,
                                       alertType: UIAlertControllerStyle, cancelTitle: String? = nil,
                                       cancelActionHandler: ((UIAlertAction) -> Swift.Void)? = nil) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: alertType)
        let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel, handler: cancelActionHandler)
        alertVC.addAction(cancelAction)
        present(alertVC, animated: true, completion: nil)
    }
}

extension BaseViewController {
    func presentViewControllerProfile(identifier: String, main: String){
        DispatchQueue.main.async {
            let storyboard: UIStoryboard = UIStoryboard(name: main, bundle: nil)
            let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: identifier)
            self.present(vc, animated: true, completion: nil)
        }
    }
    func pushViewController(identifier: String,main: String){
        let storyboard: UIStoryboard = UIStoryboard(name: main, bundle: nil)
        let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: identifier)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

