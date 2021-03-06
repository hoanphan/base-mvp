//
//  PickerViewDialog.swift
//  BaoVietId
//
//  Created by Navatech on 9/17/16.
//  Copyright © 2016 Navatech. All rights reserved.
//

import UIKit




//MARK: PickerViewDialog
public class PickerViewDialog: UIView {
    
    public typealias PickerViewCallback = (_ object: AnyObject?) -> Void
    
    /* Consts */
    private let kPickerViewDialogDefaultButtonHeight:       CGFloat = 50
    private let kPickerViewDialogDefaultButtonSpacerHeight: CGFloat = 1
    private let kPickerViewDialogCornerRadius:              CGFloat = 7
    private let kPickerViewDialogDoneButtonTag:             Int     = 1
    
    /* Views */
    private var dialogView:   UIView!
    private var titleLabel:   UILabel!
    public var pickerView:   UIPickerView!
    private var cancelButton: UIButton!
    private var doneButton:   UIButton!
    
    /* Vars */
    private var defaultDate:    NSDate?
    private var datePickerMode: UIDatePickerMode?
    private var callback:       PickerViewCallback?
    
    
    /* Overrides */
    public init() {
      
        super.init(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        
        initInterface()
        setupView()
        
    }
    
    func initInterface(){
        self.pickerView = UIPickerView(frame: CGRect(x:0,y: 30,width: 0,height: 0))
        self.pickerView.autoresizingMask = UIViewAutoresizing.flexibleRightMargin
        self.pickerView.frame.size.width = 300
    }
    
    required public init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.dialogView = createContainerView()
        
        self.dialogView!.layer.shouldRasterize = true
        self.dialogView!.layer.rasterizationScale = UIScreen.main.scale
        
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        
        self.dialogView!.layer.opacity = 0.5
        self.dialogView!.layer.transform = CATransform3DMakeScale(1.3, 1.3, 1)
        
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        
        self.addSubview(self.dialogView!)
    }
    
    /* Handle device orientation changes */
    @objc func deviceOrientationDidChange(notification: NSNotification) {
        self.frame = CGRect(x: 0,y: 0,width: UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height)
        let screenSize = countScreenSize()
        let dialogSize = CGSize(width: 300,height: 230 + kPickerViewDialogDefaultButtonHeight + kPickerViewDialogDefaultButtonSpacerHeight)
        dialogView.frame = CGRect(x:(screenSize.width - dialogSize.width) / 2,y:(screenSize.height - dialogSize.height) / 2,width: dialogSize.width,height: dialogSize.height)
    }
    
    /* Create the dialog view, and animate opening the dialog */
    public func show(title: String, doneButtonTitle: String = "Chọn", cancelButtonTitle: String = "Hủy", callback: @escaping PickerViewCallback) {
        
        
        self.titleLabel.text = title
        self.doneButton.setTitle(doneButtonTitle, for: UIControlState.normal)
        self.cancelButton.setTitle(cancelButtonTitle, for: UIControlState.normal)
        
        self.callback = callback
        
        /* */
        UIApplication.shared.windows.first!.addSubview(self)
       // UIApplication.sharedApplication().windows.first!.addSubview(self)
        UIApplication.shared.windows.first!.endEditing(true)
       // UIApplication.sharedApplication.windows.first!.endEditing(true)
        
//        NotificationCenter.default.addObserver(self, selector:  #selector(PickerViewDialog.deviceOrientationDidChange(notification:)), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(PickerViewDialog.deviceOrientationDidChange(notification:)), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
        /* Anim */
    
        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            options: UIViewAnimationOptions.curveEaseInOut,
            animations: { () -> Void in
                self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
                self.dialogView!.layer.opacity = 1
                self.dialogView!.layer.transform = CATransform3DMakeScale(1, 1, 1)
            },
            completion: nil
        )
        
    }
    
    /* Dialog close animation then cleaning and removing the view from the parent */
    private func close() {
        NotificationCenter.default.removeObserver(self)
       // NSNotificationCenter.defaultCenter().removeObserver(self)
        
        let currentTransform = self.dialogView.layer.transform
        
        let startRotation = (self.value(forKeyPath: "layer.transform.rotation.z") as? NSNumber) as? Double ?? 0.0
        let rotation = CATransform3DMakeRotation((CGFloat)(-startRotation + M_PI * 270 / 180), 0, 0, 0)
        
        self.dialogView.layer.transform = CATransform3DConcat(rotation, CATransform3DMakeScale(1, 1, 1))
        self.dialogView.layer.opacity = 1
        
        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            options: UIViewAnimationOptions.showHideTransitionViews,
            animations: { () -> Void in
                self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
                self.dialogView.layer.transform = CATransform3DConcat(currentTransform, CATransform3DMakeScale(0.6, 0.6, 1))
                self.dialogView.layer.opacity = 0
        }) { (finished: Bool) -> Void in
            for v in self.subviews {
                v.removeFromSuperview()
            }
            
            self.removeFromSuperview()
            self.setupView()
        }
    }
    
    /* Creates the container view here: create the dialog, then add the custom content and buttons */
    private func createContainerView() -> UIView {
        let screenSize = countScreenSize()
        let dialogSize = CGSize(width:
            300,
                                height: 230
                + kPickerViewDialogDefaultButtonHeight
                + kPickerViewDialogDefaultButtonSpacerHeight)
        
        // For the black background
        self.frame = CGRect(x: 0,y: 0,width: screenSize.width,height: screenSize.height)
        
        // This is the dialog's container; we attach the custom content and the buttons to this one
        let dialogContainer = UIView(frame: CGRect(x:(screenSize.width - dialogSize.width) / 2,y: (screenSize.height - dialogSize.height) / 2,width: dialogSize.width, height: dialogSize.height))
        
        // First, we style the dialog to match the iOS8 UIAlertView >>>
        let gradient: CAGradientLayer = CAGradientLayer(layer: self.layer)
        gradient.frame = dialogContainer.bounds
        gradient.colors = [UIColor(red: 218/255, green: 218/255, blue: 218/255, alpha: 1).cgColor,
                           UIColor(red: 233/255, green: 233/255, blue: 233/255, alpha: 1).cgColor,
                           UIColor(red: 218/255, green: 218/255, blue: 218/255, alpha: 1).cgColor]
        
        let cornerRadius = kPickerViewDialogCornerRadius
        gradient.cornerRadius = cornerRadius
        dialogContainer.layer.insertSublayer(gradient, at: 0)
        
        dialogContainer.layer.cornerRadius = cornerRadius
        dialogContainer.layer.borderColor = UIColor(red: 198/255, green: 198/255, blue: 198/255, alpha: 1).cgColor
        dialogContainer.layer.borderWidth = 1
        dialogContainer.layer.shadowRadius = cornerRadius + 5
        dialogContainer.layer.shadowOpacity = 0.1
        dialogContainer.layer.shadowOffset = CGSize(width:0 - (cornerRadius + 5) / 2,height: 0 - (cornerRadius + 5) / 2)
        dialogContainer.layer.shadowColor = UIColor.black.cgColor
        dialogContainer.layer.shadowPath = UIBezierPath(roundedRect: dialogContainer.bounds, cornerRadius: dialogContainer.layer.cornerRadius).cgPath
        
        // There is a line above the button
        let lineView = UIView(frame: CGRect(x: 0,y: dialogContainer.bounds.size.height - kPickerViewDialogDefaultButtonHeight - kPickerViewDialogDefaultButtonSpacerHeight,width: dialogContainer.bounds.size.width,height: kPickerViewDialogDefaultButtonSpacerHeight))
        lineView.backgroundColor = UIColor(red: 198/255, green: 198/255, blue: 198/255, alpha: 1)
        dialogContainer.addSubview(lineView)
        // ˆˆˆ
        
        //Title
        self.titleLabel = UILabel(frame: CGRect(x: 10,y: 10,width: 280,height: 30))
        self.titleLabel.textAlignment = NSTextAlignment.center
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        dialogContainer.addSubview(self.titleLabel)
        

        dialogContainer.addSubview(self.pickerView)
        
        // Add the buttons
        addButtonsToView(container: dialogContainer)
        
        
        return dialogContainer
    }
    
    /* Add buttons to container */
    private func addButtonsToView(container: UIView) {
        let buttonWidth = container.bounds.size.width / 2
        
        self.cancelButton = UIButton(type: UIButtonType.custom) as UIButton
        self.cancelButton.frame = CGRect(x:
            0,
                                         y: container.bounds.size.height - kPickerViewDialogDefaultButtonHeight,
                                         width: buttonWidth,
                                         height: kPickerViewDialogDefaultButtonHeight
        )
        self.cancelButton.setTitleColor(UIColor(red: 0, green: 0.5, blue: 1, alpha: 1), for: UIControlState.normal)
        self.cancelButton.setTitleColor(UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.5), for: UIControlState.highlighted)
        self.cancelButton.titleLabel!.font = UIFont.boldSystemFont(ofSize: 14)
        self.cancelButton.layer.cornerRadius = kPickerViewDialogCornerRadius
        self.cancelButton.addTarget(self, action: #selector(PickerViewDialog.buttonTapped(sender:)), for: UIControlEvents.touchUpInside)
        container.addSubview(self.cancelButton)
        
        self.doneButton = UIButton(type: UIButtonType.custom) as UIButton
        self.doneButton.frame = CGRect(x:
            buttonWidth,
                                       y: container.bounds.size.height - kPickerViewDialogDefaultButtonHeight,
                                       width: buttonWidth,
                                       height: kPickerViewDialogDefaultButtonHeight
        )
        self.doneButton.tag = kPickerViewDialogDoneButtonTag
        self.doneButton.setTitleColor(UIColor(red: 0, green: 0.5, blue: 1, alpha: 1), for: UIControlState.normal)
        self.doneButton.setTitleColor(UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.5), for: UIControlState.highlighted)
        self.doneButton.titleLabel!.font = UIFont.boldSystemFont(ofSize: 14)
        self.doneButton.layer.cornerRadius = kPickerViewDialogCornerRadius
        self.doneButton.addTarget(self, action: #selector(PickerViewDialog.buttonTapped(sender:)), for: UIControlEvents.touchUpInside)
        container.addSubview(self.doneButton)
    }
    
    @objc func buttonTapped(sender: UIButton!) {
        if sender.tag == kPickerViewDialogDoneButtonTag && pickerView.numberOfRows(inComponent: 0) > 0 {
            let selectedObject = pickerView.selectedRow(inComponent: 0)
            self.callback?(selectedObject as AnyObject)
        } else {
            self.callback?(nil)
        }
        
        close()
    }
    
    /* Helper function: count and return the screen's size */
    func countScreenSize() -> CGSize {
        let screenWidth = UIScreen.main.applicationFrame.size.width
        let screenHeight = UIScreen.main.bounds.size.height
        
        return CGSize(width: screenWidth,height: screenHeight)
    }
    
    
    
}
