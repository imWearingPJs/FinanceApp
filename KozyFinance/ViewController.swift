//
//  ViewController.swift
//  KozyFinance
//
//  Created by Michael Kozub on 4/30/19.
//  Copyright © 2019 Michael Kozub. All rights reserved.
//

import UIKit
import Anchorage

class ViewController: UIViewController, UITextFieldDelegate, UIGestureRecognizerDelegate, UIScrollViewDelegate {

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
    
    let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.backgroundColor = .cyan
        return sv
    }()
    
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
        
        let fieldWidth = self.view.widthAnchor * 0.5
        let valueWidth = scrollView.widthAnchor * 0.5
        let fieldHeight = 50.0
        let cornerRadius = CGFloat(5.0)
        
        self.view.addSubview(mortgageText)
        mortgageText.layer.cornerRadius = cornerRadius
        mortgageText.text = "You may qualify for a home up to:"
        mortgageText.textAlignment = .center
        mortgageText.widthAnchor <= self.view.widthAnchor + 10
        mortgageText.heightAnchor == 25
        mortgageText.centerXAnchor == self.view.centerXAnchor
        mortgageText.topAnchor == self.view.safeAreaLayoutGuide.topAnchor + 20
        
        self.view.addSubview(estimatedMortgage)
        estimatedMortgage.layer.cornerRadius = cornerRadius
        estimatedMortgage.text = "$0"
        estimatedMortgage.setQualifiedAmountFont()
        estimatedMortgage.textAlignment = .center
        estimatedMortgage.widthAnchor == fieldWidth
        estimatedMortgage.heightAnchor == fieldHeight
        estimatedMortgage.centerXAnchor == self.view.centerXAnchor
        estimatedMortgage.topAnchor == mortgageText.bottomAnchor
        
        self.view.addSubview(scrollView)
        scrollView.topAnchor == estimatedMortgage.bottomAnchor + 10
        scrollView.bottomAnchor == view.safeAreaLayoutGuide.bottomAnchor - 10
        scrollView.horizontalAnchors == view.safeAreaLayoutGuide.horizontalAnchors + 10
        
        scrollView.addSubview(salaryTitle)
        salaryTitle.setTitleFont()
        salaryTitle.text = "Income"
        salaryTitle.layer.cornerRadius = cornerRadius
        salaryTitle.textAlignment = .left
        salaryTitle.widthAnchor == valueWidth
        salaryTitle.heightAnchor == fieldHeight
        salaryTitle.leftAnchor == scrollView.safeAreaLayoutGuide.leftAnchor + 25
        salaryTitle.topAnchor == scrollView.topAnchor + 25
        
        scrollView.addSubview(salaryValueLabel)
        salaryValueLabel.setValueFont()
        salaryValueLabel.layer.cornerRadius = cornerRadius
        salaryValueLabel.textAlignment = .right
        salaryValueLabel.widthAnchor == valueWidth
        salaryValueLabel.heightAnchor == fieldHeight
        salaryValueLabel.rightAnchor == scrollView.safeAreaLayoutGuide.rightAnchor - 25
        salaryValueLabel.topAnchor == scrollView.topAnchor + 25
        
        scrollView.addSubview(salarySlider)
        salarySlider.widthAnchor == scrollView.safeAreaLayoutGuide.widthAnchor - 50
        salarySlider.heightAnchor == fieldHeight
        salarySlider.centerXAnchor == scrollView.centerXAnchor
        salarySlider.topAnchor == salaryValueLabel.bottomAnchor - 25
        salarySlider.isContinuous = true
        salarySlider.minimumValue = 0
        salarySlider.maximumValue = 250_000
        salarySlider.value = 0
        salarySlider.addTarget(self, action: #selector(salarySliderValueDidChange(sender:)),for: .valueChanged)
        salaryValueLabel.text = (currencyFormatter.string(from: NSNumber(value: salarySlider.value)) ?? "0.00") + " /yr"
        
        scrollView.addSubview(carPaymentTitle)
        carPaymentTitle.setTitleFont()
        carPaymentTitle.text = "Car Payment"
        carPaymentTitle.layer.cornerRadius = cornerRadius
        carPaymentTitle.textAlignment = .left
        carPaymentTitle.widthAnchor == valueWidth
        carPaymentTitle.heightAnchor == fieldHeight
        carPaymentTitle.leftAnchor == scrollView.safeAreaLayoutGuide.leftAnchor + 25
        carPaymentTitle.topAnchor == salarySlider.bottomAnchor + 25
        
        scrollView.addSubview(carPaymentValueLabel)
        carPaymentValueLabel.setValueFont()
        carPaymentValueLabel.layer.cornerRadius = cornerRadius
        carPaymentValueLabel.textAlignment = .right
        carPaymentValueLabel.widthAnchor == valueWidth
        carPaymentValueLabel.heightAnchor == fieldHeight
        carPaymentValueLabel.rightAnchor == scrollView.safeAreaLayoutGuide.rightAnchor - 25
        carPaymentValueLabel.topAnchor == salarySlider.bottomAnchor + 25
        
        scrollView.addSubview(carPaymentSlider)
        carPaymentSlider.widthAnchor == scrollView.safeAreaLayoutGuide.widthAnchor - 50
        carPaymentSlider.heightAnchor == fieldHeight
        carPaymentSlider.centerXAnchor == scrollView.centerXAnchor
        carPaymentSlider.topAnchor == carPaymentValueLabel.bottomAnchor - 25
        carPaymentSlider.isContinuous = true
        carPaymentSlider.minimumValue = 0
        carPaymentSlider.maximumValue = 1_000
        carPaymentSlider.value = 0
        carPaymentSlider.addTarget(self, action: #selector(carPaymentSliderValueDidChange(sender:)),for: .valueChanged)
        carPaymentValueLabel.text = (currencyFormatter.string(from: NSNumber(value: carPaymentSlider.value)) ?? "0.00") + " /mo"
        
        scrollView.addSubview(additionalPaymentTitle)
        additionalPaymentTitle.setTitleFont()
        additionalPaymentTitle.text = "Additional Monthly Debt"
        additionalPaymentTitle.layer.cornerRadius = cornerRadius
        additionalPaymentTitle.textAlignment = .left
        additionalPaymentTitle.heightAnchor == fieldHeight
        additionalPaymentTitle.leftAnchor == scrollView.leftAnchor + 25
        additionalPaymentTitle.topAnchor == carPaymentSlider.bottomAnchor + 25
        
        scrollView.addSubview(additionalPaymentValueLabel)
        additionalPaymentValueLabel.setValueFont()
        additionalPaymentValueLabel.layer.cornerRadius = cornerRadius
        additionalPaymentValueLabel.textAlignment = .right
        additionalPaymentValueLabel.widthAnchor == valueWidth
        additionalPaymentValueLabel.heightAnchor == fieldHeight
        additionalPaymentValueLabel.rightAnchor == scrollView.safeAreaLayoutGuide.rightAnchor - 25
        additionalPaymentValueLabel.topAnchor == carPaymentSlider.bottomAnchor + 25
        
        scrollView.addSubview(additionalPaymentSlider)
        additionalPaymentSlider.widthAnchor == scrollView.widthAnchor - 50
        additionalPaymentSlider.heightAnchor == fieldHeight
        additionalPaymentSlider.centerXAnchor == scrollView.centerXAnchor
        additionalPaymentSlider.topAnchor == additionalPaymentValueLabel.bottomAnchor - 25
        additionalPaymentSlider.isContinuous = true
        additionalPaymentSlider.minimumValue = 0
        additionalPaymentSlider.maximumValue = 5_000
        additionalPaymentSlider.value = 0
        additionalPaymentSlider.addTarget(self, action: #selector(additionalPaymentsSliderValueDidChange(sender:)),for: .valueChanged)
        additionalPaymentValueLabel.text = (currencyFormatter.string(from: NSNumber(value: additionalPaymentSlider.value)) ?? "0.00") + " /mo"
        
        scrollView.addSubview(interestRateTitle)
        interestRateTitle.setTitleFont()
        interestRateTitle.text = "Interest Rate"
        interestRateTitle.layer.cornerRadius = cornerRadius
        interestRateTitle.textAlignment = .left
        interestRateTitle.heightAnchor == fieldHeight
        interestRateTitle.leftAnchor == scrollView.leftAnchor + 25
        interestRateTitle.topAnchor == additionalPaymentSlider.bottomAnchor + 25

        scrollView.addSubview(interestRateLabel)
        interestRateLabel.setValueFont()
        interestRateLabel.layer.cornerRadius = cornerRadius
        interestRateLabel.textAlignment = .right
        interestRateLabel.widthAnchor == valueWidth
        interestRateLabel.heightAnchor == fieldHeight
        interestRateLabel.rightAnchor == scrollView.safeAreaLayoutGuide.rightAnchor - 25
        interestRateLabel.topAnchor == additionalPaymentSlider.bottomAnchor + 25

        scrollView.addSubview(interestRateSlider)
        interestRateSlider.widthAnchor == scrollView.widthAnchor - 50
        interestRateSlider.heightAnchor == fieldHeight
        interestRateSlider.centerXAnchor == scrollView.centerXAnchor
        interestRateSlider.topAnchor == interestRateTitle.bottomAnchor - 25
        interestRateSlider.isContinuous = true
        interestRateSlider.minimumValue = 0.02
        interestRateSlider.maximumValue = 0.15
        interestRateSlider.value = 0
        interestRateSlider.addTarget(self, action: #selector(interestRateSliderValueDidChange(sender:)),for: .valueChanged)
        interestRateLabel.text = (percentFormatter.string(from: NSNumber(value: interestRateSlider.value)) ?? "0.00")
        
        scrollView.addSubview(lengthTitle)
        lengthTitle.setTitleFont()
        lengthTitle.text = "Length of Mortgage"
        lengthTitle.layer.cornerRadius = cornerRadius
        lengthTitle.textAlignment = .left
        lengthTitle.heightAnchor == fieldHeight
        lengthTitle.leftAnchor == scrollView.leftAnchor + 25
        lengthTitle.topAnchor == interestRateSlider.bottomAnchor + 25
        
        scrollView.addSubview(lengthLabel)
        lengthLabel.setValueFont()
        lengthLabel.layer.cornerRadius = cornerRadius
        lengthLabel.textAlignment = .right
        lengthLabel.widthAnchor == valueWidth
        lengthLabel.heightAnchor == fieldHeight
        lengthLabel.rightAnchor == scrollView.safeAreaLayoutGuide.rightAnchor - 25
        lengthLabel.topAnchor == interestRateSlider.bottomAnchor + 25

        scrollView.addSubview(lengthSlider)
        lengthSlider.widthAnchor == scrollView.widthAnchor - 50
        lengthSlider.heightAnchor == fieldHeight
        lengthSlider.centerXAnchor == scrollView.centerXAnchor
        lengthSlider.topAnchor == lengthTitle.bottomAnchor - 25
        lengthSlider.bottomAnchor == scrollView.bottomAnchor - 10
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
        let sum = (salary - (carPayment * 12) - (additionalPayments * 12)) * 4.0
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
        
        let sum = (salary - (carPayment * 12) - (additionalPayments * 12)) * 4.0
        
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

