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

    var mortgageText = UILabel()
    var estimatedMortgage = UILabel()
    var carPaymentField = UITextField()
    var additionalPaymentsField = UITextField()
    let estimateButton = UIButton()
    let resetButton = UIButton()
    
    let salaryTitle = UILabel()
    let salaryValueLabel = UILabel()
    let salarySlider = CustomSlider()
    
    let carPaymentTitle = UILabel()
    let carPaymentValueLabel = UILabel()
    let carPaymentSlider = CustomSlider()
    
    let additionalPaymentTitle = UILabel()
    let additionalPaymentValueLabel = UILabel()
    let additionalPaymentSlider = CustomSlider()
    
    let interestRateTitle = UILabel()
    let interestRateLabel = UILabel()
    let interestRateSlider = CustomSlider()
    
    let lengthTitle = UILabel()
    let lengthLabel = UILabel()
    let lengthSlider = CustomSlider()
    
    let currencyFormatter: NumberFormatter = {
        let temp = NumberFormatter()
        temp.numberStyle = .currency
        return temp
    }()
    
    let percentFormatter: NumberFormatter = {
        let temp = NumberFormatter()
        temp.numberStyle = .percent
        temp.minimumFractionDigits = 1
        temp.maximumFractionDigits = 3
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
//        let numKeyboard = UIKeyboardType.decimalPad
        
        self.view.addSubview(mortgageText)
        mortgageText.layer.cornerRadius = cornerRadius
        mortgageText.text = "You may qualify for a home up to:"
        mortgageText.textAlignment = .center
        mortgageText.widthAnchor == fieldWidth
        mortgageText.heightAnchor == 25
        mortgageText.centerXAnchor == self.view.centerXAnchor
        mortgageText.topAnchor == self.view.safeAreaLayoutGuide.topAnchor + 20
        
        self.view.addSubview(estimatedMortgage)
        estimatedMortgage.layer.cornerRadius = cornerRadius
        estimatedMortgage.text = "$0"
        estimatedMortgage.textAlignment = .center
        estimatedMortgage.widthAnchor == fieldWidth
        estimatedMortgage.heightAnchor == fieldHeight
        estimatedMortgage.centerXAnchor == self.view.centerXAnchor
        estimatedMortgage.topAnchor == mortgageText.bottomAnchor
        
        self.view.addSubview(salaryTitle)
        salaryTitle.text = "Income"
        salaryTitle.layer.cornerRadius = cornerRadius
        salaryTitle.textAlignment = .left
        salaryTitle.widthAnchor == valueWidth
        salaryTitle.heightAnchor == fieldHeight
        salaryTitle.leftAnchor == self.view.safeAreaLayoutGuide.leftAnchor + 25
        salaryTitle.topAnchor == estimatedMortgage.bottomAnchor + 25
        
        self.view.addSubview(salaryValueLabel)
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
        salarySlider.value = 0
        salarySlider.addTarget(self, action: #selector(salarySliderValueDidChange(sender:)),for: .valueChanged)
        salaryValueLabel.text = (currencyFormatter.string(from: NSNumber(value: salarySlider.value)) ?? "0.00") + " /yr"
        
        self.view.addSubview(carPaymentTitle)
        carPaymentTitle.text = "Car Payment"
        carPaymentTitle.layer.cornerRadius = cornerRadius
        carPaymentTitle.textAlignment = .left
        carPaymentTitle.widthAnchor == valueWidth
        carPaymentTitle.heightAnchor == fieldHeight
        carPaymentTitle.leftAnchor == self.view.safeAreaLayoutGuide.leftAnchor + 25
        carPaymentTitle.topAnchor == salarySlider.bottomAnchor + 25
        
        self.view.addSubview(carPaymentValueLabel)
        carPaymentValueLabel.layer.cornerRadius = cornerRadius
        carPaymentValueLabel.textAlignment = .right
        carPaymentValueLabel.widthAnchor == valueWidth
        carPaymentValueLabel.heightAnchor == fieldHeight
        carPaymentValueLabel.rightAnchor == self.view.safeAreaLayoutGuide.rightAnchor - 25
        carPaymentValueLabel.topAnchor == salarySlider.bottomAnchor + 25
        
        self.view.addSubview(carPaymentSlider)
        carPaymentSlider.widthAnchor == self.view.safeAreaLayoutGuide.widthAnchor - 50
        carPaymentSlider.heightAnchor == fieldHeight
        carPaymentSlider.centerXAnchor == self.view.centerXAnchor
        carPaymentSlider.topAnchor == carPaymentValueLabel.bottomAnchor - 25
        carPaymentSlider.isContinuous = true
        carPaymentSlider.minimumValue = 0
        carPaymentSlider.maximumValue = 1_000
        carPaymentSlider.value = 0
        carPaymentSlider.addTarget(self, action: #selector(carPaymentSliderValueDidChange(sender:)),for: .valueChanged)
        carPaymentValueLabel.text = (currencyFormatter.string(from: NSNumber(value: carPaymentSlider.value)) ?? "0.00") + " /mo"
        
        self.view.addSubview(additionalPaymentTitle)
        additionalPaymentTitle.text = "Additional Monthly Debt"
        additionalPaymentTitle.layer.cornerRadius = cornerRadius
        additionalPaymentTitle.textAlignment = .left
        additionalPaymentTitle.heightAnchor == fieldHeight
        additionalPaymentTitle.leftAnchor == self.view.safeAreaLayoutGuide.leftAnchor + 25
        additionalPaymentTitle.topAnchor == carPaymentSlider.bottomAnchor + 25
        
        self.view.addSubview(additionalPaymentValueLabel)
        additionalPaymentValueLabel.layer.cornerRadius = cornerRadius
        additionalPaymentValueLabel.textAlignment = .right
        additionalPaymentValueLabel.widthAnchor == valueWidth
        additionalPaymentValueLabel.heightAnchor == fieldHeight
        additionalPaymentValueLabel.rightAnchor == self.view.safeAreaLayoutGuide.rightAnchor - 25
        additionalPaymentValueLabel.topAnchor == carPaymentSlider.bottomAnchor + 25
        
        self.view.addSubview(additionalPaymentSlider)
        additionalPaymentSlider.widthAnchor == self.view.safeAreaLayoutGuide.widthAnchor - 50
        additionalPaymentSlider.heightAnchor == fieldHeight
        additionalPaymentSlider.centerXAnchor == self.view.centerXAnchor
        additionalPaymentSlider.topAnchor == additionalPaymentValueLabel.bottomAnchor - 25
        additionalPaymentSlider.isContinuous = true
        additionalPaymentSlider.minimumValue = 0
        additionalPaymentSlider.maximumValue = 5_000
        additionalPaymentSlider.value = 0
        additionalPaymentSlider.addTarget(self, action: #selector(additionalPaymentsSliderValueDidChange(sender:)),for: .valueChanged)
        additionalPaymentValueLabel.text = (currencyFormatter.string(from: NSNumber(value: additionalPaymentSlider.value)) ?? "0.00") + " /mo"
        
        self.view.addSubview(interestRateTitle)
        interestRateTitle.text = "Interest Rate"
        interestRateTitle.layer.cornerRadius = cornerRadius
        interestRateTitle.textAlignment = .left
        interestRateTitle.heightAnchor == fieldHeight
        interestRateTitle.leftAnchor == self.view.safeAreaLayoutGuide.leftAnchor + 25
        interestRateTitle.topAnchor == additionalPaymentSlider.bottomAnchor + 25

        self.view.addSubview(interestRateLabel)
        interestRateLabel.layer.cornerRadius = cornerRadius
        interestRateLabel.textAlignment = .right
        interestRateLabel.widthAnchor == valueWidth
        interestRateLabel.heightAnchor == fieldHeight
        interestRateLabel.rightAnchor == self.view.safeAreaLayoutGuide.rightAnchor - 25
        interestRateLabel.topAnchor == additionalPaymentSlider.bottomAnchor + 25

        self.view.addSubview(interestRateSlider)
        interestRateSlider.widthAnchor == self.view.safeAreaLayoutGuide.widthAnchor - 50
        interestRateSlider.heightAnchor == fieldHeight
        interestRateSlider.centerXAnchor == self.view.centerXAnchor
        interestRateSlider.topAnchor == interestRateTitle.bottomAnchor - 25
        interestRateSlider.isContinuous = true
        interestRateSlider.minimumValue = 0.02
        interestRateSlider.maximumValue = 0.15
        interestRateSlider.value = 0
        interestRateSlider.addTarget(self, action: #selector(interestRateSliderValueDidChange(sender:)),for: .valueChanged)
        interestRateLabel.text = (percentFormatter.string(from: NSNumber(value: interestRateSlider.value)) ?? "0.00")
        
        self.view.addSubview(lengthTitle)
        lengthTitle.text = "Length of Mortgage"
        lengthTitle.layer.cornerRadius = cornerRadius
        lengthTitle.textAlignment = .left
        lengthTitle.heightAnchor == fieldHeight
        lengthTitle.leftAnchor == self.view.safeAreaLayoutGuide.leftAnchor + 25
        lengthTitle.topAnchor == interestRateSlider.bottomAnchor + 25
        
        self.view.addSubview(lengthLabel)
        lengthLabel.layer.cornerRadius = cornerRadius
        lengthLabel.textAlignment = .right
        lengthLabel.widthAnchor == valueWidth
        lengthLabel.heightAnchor == fieldHeight
        lengthLabel.rightAnchor == self.view.safeAreaLayoutGuide.rightAnchor - 25
        lengthLabel.topAnchor == interestRateSlider.bottomAnchor + 25

        self.view.addSubview(lengthSlider)
        lengthSlider.widthAnchor == self.view.safeAreaLayoutGuide.widthAnchor - 50
        lengthSlider.heightAnchor == fieldHeight
        lengthSlider.centerXAnchor == self.view.centerXAnchor
        lengthSlider.topAnchor == lengthTitle.bottomAnchor - 25
        lengthSlider.isContinuous = true
        lengthSlider.minimumValue = 1
        lengthSlider.maximumValue = 30
        lengthSlider.value = 30
        lengthSlider.addTarget(self, action: #selector(lengthSliderValueDidChange(sender:)),for: .valueChanged)
        lengthLabel.text = String(Int(lengthSlider.value)) + " years"
    }
    
    //Sliders Did Change
    @objc func salarySliderValueDidChange(sender: UISlider!) {
        let roundedValue = (round(sender.value / 5000) * 5000)
        let formattedValue = currencyFormatter.string(from: NSNumber(value: roundedValue)) ?? "0.00"
        let stringToDisplay = formattedValue
        salarySlider.value = roundedValue //setting the value of the slider here so it's not some precise number
        salaryValueLabel.text = stringToDisplay + " /yr"
        calculateMorgate()
    }
    
    @objc func carPaymentSliderValueDidChange(sender: UISlider!) {
        let roundedValue = (round(sender.value / 25) * 25)
        let formattedValue = currencyFormatter.string(from: NSNumber(value: roundedValue)) ?? "0.00"
        let stringToDisplay = formattedValue
        carPaymentSlider.value = roundedValue
        carPaymentValueLabel.text = stringToDisplay + " /mo"
        calculateMorgate()
    }
    
    @objc func additionalPaymentsSliderValueDidChange(sender: UISlider!) {
        let roundedValue = (round(sender.value / 25) * 25)
        let formattedValue = currencyFormatter.string(from: NSNumber(value: roundedValue)) ?? "0.00"
        let stringToDisplay = formattedValue
        additionalPaymentSlider.value = roundedValue
        additionalPaymentValueLabel.text = stringToDisplay + " /mo"
        calculateMorgate()
    }
    
    @objc func interestRateSliderValueDidChange(sender: UISlider!) {
        let roundedValue = (round(sender.value / 0.00125) * 0.00125)
        print("roundedValue: ", roundedValue)
        let formattedValue = percentFormatter.string(from: NSNumber(value: roundedValue)) ?? "0.00"
        print("formattedValue: ", formattedValue)
        interestRateSlider.value = roundedValue
        interestRateLabel.text = formattedValue
        calculateMorgate()
    }
    
    @objc func lengthSliderValueDidChange(sender: UISlider!) {
        let roundedValue = (round(sender.value / 1) * 1)
        lengthSlider.value = roundedValue
        lengthLabel.text = String(Int(roundedValue)) + " years"
        calculateMorgate()
    }
    
    func calculateMorgate() {
        let salary = salarySlider.value
        let carPayment = carPaymentSlider.value
        let additionalPayments = additionalPaymentSlider.value
        let sum = (salary - (carPayment * 12) - (additionalPayments * 12)) * 3.5
        let formattedSum = currencyFormatter.string(from: NSNumber(value: sum)) ?? "0.00"
        
        if sum > 0.0 {
            estimatedMortgage.text = formattedSum
        } else {
            estimatedMortgage.text = "$0.00"
        }
    }
    
    @objc func calcTapped(sender: UIButton) {
        let salary = salarySlider.value
        let carPayment = Float(carPaymentField.text ?? "0") ?? 0
        let additionalPayments = Float(additionalPaymentsField.text ?? "0") ?? 0
        
        let sum = (salary - (carPayment * 12) - (additionalPayments * 12)) * 2.5
        
        if sum >= 0 {
            estimatedMortgage.text = "$\(sum)"
        } else {
            estimatedMortgage.text = "$0.00"
        }
    }
    
    @objc func resetTapped(sender: UIButton) {
    }
    
    //delegate methods
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    
}

