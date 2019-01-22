//
//  ViewController.swift
//  CustomPickerViewDemo
//
//  Created by Pankaj on 22/01/19.
//  Copyright © 2019 Canarys Automations Pvt Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var cityTextField: UITextField!
    @IBOutlet var placeTextField: UITextField!
    
    var pickerView: UIPickerView?

    var pickerTextField:UITextField?
    var offsetTextField:CGPoint?
    
    var cityRow = 0
    var placeRow = 0
    var comonSelectedPickerRow = 0
    var commonPickerData: [String]?
    var numberTextField:UITextField?

    var cityList = ["Mumbai","Delhi","Bangalore","Hyderabad","Ahmedabad","Chennai","Kolkata","Surat","Pune","Jaipur","Lucknow","Kanpur","Nagpur","Visakhapatnam","Indore","Thane","Bhopal","Patna","Vadodara","Ghaziabad","Ludhiana"]
    
    var placeList = ["Chadar – The Frozen River Trek", "Manali-Leh Road Trip","Markha Valley Trek","Rishikesh","Ladakh","Jim Corbett Wildlife Safari","Har Ki Doon Trek","Pushkar","Dharamshala","Delhi","Spiti Valley","Auli","Valley of Flowers Trek","Ranthambore","Kuari Pass Trek","Jaipur","Nainital","Shimla","Mussorie","Kasol", "Thar Desert","Hampta Pass Trek","Khajjiar, Himachal Pradesh","Roopkund Trek, Himalayas"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerViewMethod()
        toolbarMethod()
        // Do any additional setup after loading the view, typically from a nib.
    }
    func pickerViewMethod()
    {
        pickerView = UIPickerView(frame: CGRect(x: 0, y: 200, width: view.frame.width, height: 217))
        pickerView?.backgroundColor = UIColor.clear
        pickerView?.showsSelectionIndicator = true

        pickerView?.delegate = self
        pickerView?.dataSource = self
        cityTextField.inputView = pickerView
        placeTextField.inputView = pickerView
    }
    
    func toolbarMethod()
    {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.white
        toolBar.sizeToFit()
        toolBar.barTintColor = UIColor(red: 51/255, green: 52/255, blue: 72/255, alpha: 1)
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action:#selector(ViewController.donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.done, target: self, action: #selector(ViewController.donePicker))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        self.cityTextField.inputAccessoryView = toolBar
        self.placeTextField.inputAccessoryView = toolBar
        
    }
    
    @objc func donePicker (_ sender:UIBarButtonItem)
    {
        self.cityTextField.resignFirstResponder()
        self.placeTextField.resignFirstResponder()

    }
}

//MARK:- UIPickerViewDelegate Method
extension ViewController: UIPickerViewDelegate,UIPickerViewDataSource{
    
    // DataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
        
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if let commonPickerData = commonPickerData?.count{
            return commonPickerData
        }else{
            return 0
        }
        
    }
    // Delegate
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        switch self.pickerView!.tag{
            
        case 1:
            return cityList[row]
         
        case 2:
            return placeList[row]
            
        default:
            return cityList[row]
            
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch self.pickerView!.tag{
            
        case 1:
            self.cityRow = row
       
        case 2:
            self.placeRow = row
            
        default:
            break
            
        }
        
        self.pickerTextField?.text  = commonPickerData?[row]
        self.pickerView?.reloadAllComponents()
        
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
    
        var label:UILabel
    
        if let v = view as? UILabel{
            label = v
        }
        else{
            label = UILabel()
        }
    
        label.textColor = UIColor.black
        label.backgroundColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont(name: "Helvetica", size: 18)
        label.text = commonPickerData?[row]
    
        return label
    }
    
}

//MARK:- TextFieldDelegate Method
extension ViewController: UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        self.numberTextField = textField
        if textField == self.cityTextField
        {
            self.comonSelectedPickerRow =  self.cityRow
            self.commonPickerData = cityList
            
            self.pickerView?.tag = 0
            
            if textField.text?.count == 0 {
                self.comonSelectedPickerRow = 0
            }
        }
        if textField == self.placeTextField
        {
            self.comonSelectedPickerRow =  self.placeRow
            self.commonPickerData = placeList
            
            self.pickerView?.tag = 1
            
            if textField.text?.count == 0 {
                self.comonSelectedPickerRow = 0
            }
        }
        self.pickerTextField = textField
        self.pickerView?.reloadAllComponents()
        self.pickerView?.selectRow(self.comonSelectedPickerRow, inComponent: 0, animated:true )
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        
        return true;
        
    }
}
