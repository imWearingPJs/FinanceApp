//
//  ViewController.swift
//  KozyFinance
//
//  Created by Michael Kozub on 4/30/19.
//  Copyright © 2019 Michael Kozub. All rights reserved.
//

import UIKit
import Anchorage

class ViewController: UIViewController, UITextFieldDelegate, UIGestureRecognizerDelegate {

    var estimatedMortgage = UILabel()
    var salaryField = UITextField()
    var carPaymentField = UITextField()
    var additionalPaymentsField = UITextField()
    let estimateButton = UIButton()
    let resetButton = UIButton()
    
    let salaryNameLabel = UILabel()
    let salaryValueLabel = UILabel()
    var salaryValue = 25_000
    let salarySlider = CustomSlider()
    
    let currencyFormatter: NumberFormatter = {
        let temp = NumberFormatter()
        temp.numberStyle = .currency
        return temp
    }()
    
    override func viewWillAppear(_ animated: Bool) { //hides the tab bar for this map view
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) { //shows the nav bar when going to other tabs
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        salaryField.delegate = self
        carPaymentField.delegate = self
        additionalPaymentsField.delegate = self
        addViews()
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
    }

    func addViews() {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        
        let fieldWidth = self.view.widthAnchor * 0.8
        let valueWidth = self.view.widthAnchor * 0.3
        let fieldHeight = 50.0
        let cornerRadius = CGFloat(5.0)
        let numKeyboard = UIKeyboardType.decimalPad
        
        self.view.addSubview(estimatedMortgage)
        estimatedMortgage.backgroundColor = #colorLiteral(red: 0, green: 0.9914394021, blue: 1, alpha: 1)
        estimatedMortgage.layer.cornerRadius = cornerRadius
        estimatedMortgage.text = "$0"
        estimatedMortgage.textAlignment = .center
        estimatedMortgage.widthAnchor == fieldWidth
        estimatedMortgage.heightAnchor == fieldHeight
        estimatedMortgage.centerXAnchor == self.view.centerXAnchor
        estimatedMortgage.topAnchor == self.view.safeAreaLayoutGuide.topAnchor + 20
        
        self.view.addSubview(salaryNameLabel)
        salaryNameLabel.text = "Income"
        salaryNameLabel.backgroundColor = #colorLiteral(red: 0, green: 0.9914394021, blue: 1, alpha: 1)
        salaryNameLabel.layer.cornerRadius = cornerRadius
        salaryNameLabel.textAlignment = .left
        salaryNameLabel.widthAnchor == valueWidth
        salaryNameLabel.heightAnchor == fieldHeight
        salaryNameLabel.leftAnchor == self.view.safeAreaLayoutGuide.leftAnchor + 25
        salaryNameLabel.topAnchor == estimatedMortgage.bottomAnchor + 25
        
        self.view.addSubview(salaryValueLabel)
        salaryValueLabel.backgroundColor = #colorLiteral(red: 0, green: 0.9914394021, blue: 1, alpha: 1)
        salaryValueLabel.layer.cornerRadius = cornerRadius
        salaryValueLabel.textAlignment = .right
        salaryValueLabel.widthAnchor == valueWidth
        salaryValueLabel.heightAnchor == fieldHeight
        salaryValueLabel.rightAnchor == self.view.safeAreaLayoutGuide.rightAnchor - 25
        salaryValueLabel.topAnchor == estimatedMortgage.bottomAnchor + 25
        
        self.view.addSubview(salarySlider)
        salarySlider.widthAnchor == self.view.safeAreaLayoutGuide.widthAnchor - 50
        salarySlider.heightAnchor == fieldHeight
        salarySlider.centerXAnchor == self.view.centerXAnchor
        salarySlider.topAnchor == salaryValueLabel.bottomAnchor - 25
        salarySlider.isContinuous = true
        salarySlider.minimumValue = 0
        salarySlider.maximumValue = 250_000
        salarySlider.value = 20_000
        salarySlider.addTarget(self, action: #selector(sliderValueDidChange(sender:)),for: .valueChanged)
        salaryValueLabel.text = (currencyFormatter.string(from: NSNumber(value: salarySlider.value)) ?? "0.00") + " /yr"
        
        self.view.addSubview(salaryField)
        salaryField.backgroundColor = #colorLiteral(red: 0, green: 0.9914394021, blue: 1, alpha: 1)
        salaryField.placeholder = "Yearly Salary (pre tax)"
        salaryField.textAlignment = .center
        salaryField.keyboardType = numKeyboard
        salaryField.layer.cornerRadius = cornerRadius
        salaryField.widthAnchor == fieldWidth
        salaryField.heightAnchor == fieldHeight
        salaryField.centerXAnchor == self.view.centerXAnchor
        salaryField.topAnchor == salarySlider.bottomAnchor + 25
        
        self.view.addSubview(carPaymentField)
        carPaymentField.backgroundColor = #colorLiteral(red: 0, green: 0.9914394021, blue: 1, alpha: 1)
        carPaymentField.placeholder = "Car Payment"
        carPaymentField.textAlignment = .center
        carPaymentField.keyboardType = numKeyboard
        carPaymentField.layer.cornerRadius = cornerRadius
        carPaymentField.widthAnchor == fieldWidth
        carPaymentField.heightAnchor == fieldHeight
        carPaymentField.centerXAnchor == self.view.safeAreaLayoutGuide.centerXAnchor
        carPaymentField.topAnchor == salaryField.bottomAnchor + 25
        
        self.view.addSubview(additionalPaymentsField)
        additionalPaymentsField.backgroundColor = #colorLiteral(red: 0, green: 0.9914394021, blue: 1, alpha: 1)
        additionalPaymentsField.placeholder = "Additional Monthly Payments"
        additionalPaymentsField.textAlignment = .center
        additionalPaymentsField.keyboardType = numKeyboard
        additionalPaymentsField.layer.cornerRadius = cornerRadius
        additionalPaymentsField.widthAnchor == fieldWidth
        additionalPaymentsField.heightAnchor == fieldHeight
        additionalPaymentsField.centerXAnchor == self.view.centerXAnchor
        additionalPaymentsField.topAnchor == carPaymentField.bottomAnchor + 25
        
        self.view.addSubview(estimateButton)
        estimateButton.layer.backgroundColor = #colorLiteral(red: 0.8823529412, green: 0.3450980392, blue: 0.1607843137, alpha: 1)
        estimateButton.setTitle("Calculate", for: .normal)
        estimateButton.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        estimateButton.centerXAnchor == self.view.safeAreaLayoutGuide.centerXAnchor
        estimateButton.topAnchor == additionalPaymentsField.bottomAnchor + 25
        estimateButton.widthAnchor == self.view.safeAreaLayoutGuide.widthAnchor / 3
        estimateButton.heightAnchor == 50
        estimateButton.layer.cornerRadius = 5
        estimateButton.addTarget(self, action: #selector(calcTapped(sender:)), for: .touchUpInside)
        
        self.view.addSubview(resetButton)
        resetButton.layer.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        resetButton.setTitle("Reset", for: .normal)
        resetButton.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        resetButton.centerXAnchor == self.view.safeAreaLayoutGuide.centerXAnchor
        resetButton.topAnchor == estimateButton.bottomAnchor + 25
        resetButton.widthAnchor == self.view.safeAreaLayoutGuide.widthAnchor / 3
        resetButton.heightAnchor == 50
        resetButton.layer.cornerRadius = 5
        resetButton.addTarget(self, action: #selector(resetTapped(sender:)), for: .touchUpInside)
        
    }
    
    @objc func sliderValueDidChange(sender: UISlider!) {
        let roundedValue = (round(sender.value / 5000) * 5000)
        let formattedValue = currencyFormatter.string(from: NSNumber(value: roundedValue)) ?? "0.00"
        let stringToDisplay = formattedValue
        salarySlider.value = roundedValue //setting the value of the slider here so it's not some precise number
        salaryValueLabel.text = stringToDisplay + " /yr"
        
        calculateMorgate()
    }
    
    func calculateMorgate() {
        let salary = salarySlider.value
        let carPayment = Float(carPaymentField.text ?? "0") ?? 0
        let additionalPayments = Float(additionalPaymentsField.text ?? "0") ?? 0
        let sum = (salary - (carPayment * 12) - (additionalPayments * 12)) * 3.5
        let formattedSum = currencyFormatter.string(from: NSNumber(value: sum)) ?? "0.00"
        estimatedMortgage.text = formattedSum
    }
    
    @objc func calcTapped(sender: UIButton) {
        let salary = salarySlider.value
        let carPayment = Float(carPaymentField.text ?? "0") ?? 0
        let additionalPayments = Float(additionalPaymentsField.text ?? "0") ?? 0
        
        let sum = (salary - (carPayment * 12) - (additionalPayments * 12)) * 3.5
        
        estimatedMortgage.text = "$\(sum)"
    }
    
    @objc func resetTapped(sender: UIButton) {
        salaryField.text = ""
        carPaymentField.text = ""
        additionalPaymentsField.text = ""
        estimatedMortgage.text = "$0"
    }
    
    //delegate methods
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    
}

