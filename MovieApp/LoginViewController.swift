//
//  LoginViewController.swift
//  MovieApp
//
//  Created by Sandro Boka on 04.04.2024..
//

import Foundation
import UIKit
import PureLayout

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        buildViews()
    }
    
    private func buildWelcomeLabel() {
        
        let loginLable = UILabel()
        loginLable.text = "Welcome"
        loginLable.font = UIFont.systemFont(ofSize: 35, weight: .heavy)
        view.addSubview(loginLable)
        loginLable.autoAlignAxis(toSuperviewAxis: .vertical)
        loginLable.autoPinEdge(toSuperviewSafeArea: .top, withInset: 50)
        
        let seperator = UIView()
        seperator.autoSetDimensions(to: CGSize(width: 300, height: 1))
        view.addSubview(seperator)
        seperator.backgroundColor = .gray
        seperator.autoAlignAxis(toSuperviewAxis: .vertical)
        seperator.autoPinEdge(toSuperviewSafeArea: .top, withInset: 130)
    }
    
    private func buildInputs() {
        
        let mailLable = UILabel()
        mailLable.text = "Email:"
        mailLable.font = UIFont.systemFont(ofSize: 22, weight: .heavy)
        view.addSubview(mailLable)
        mailLable.autoPinEdge(toSuperviewSafeArea: .top, withInset: 170)
        mailLable.autoAlignAxis(toSuperviewAxis: .vertical)
        
        let mailField = UITextField()
        mailField.placeholder = "example@examplemail.com"
        mailField.font = UIFont.boldSystemFont(ofSize: 19)
        view.addSubview(mailField)
        mailField.autoPinEdge(toSuperviewSafeArea: .top, withInset: 210)
        mailField.autoAlignAxis(toSuperviewAxis: .vertical)
        mailField.autoSetDimensions(to: CGSize(width: 300, height: 50))
        mailField.textAlignment = .center
        mailField.layer.borderWidth = 2
        mailField.layer.borderColor = UIColor.lightGray.cgColor
        mailField.layer.cornerRadius = 3
        mailField.layer.shadowOpacity = 0.2
        mailField.layer.shadowRadius = 10
        
        let passwordLable = UILabel()
        passwordLable.text = "Password:"
        passwordLable.font = UIFont.systemFont(ofSize: 22, weight: .heavy)
        view.addSubview(passwordLable)
        passwordLable.autoPinEdge(toSuperviewSafeArea: .top, withInset: 280)
        passwordLable.autoAlignAxis(toSuperviewAxis: .vertical)
        
        let passwordField = UITextField()
        passwordField.placeholder = "Example_Password"
        passwordField.font = UIFont.boldSystemFont(ofSize: 19)
        passwordField.isSecureTextEntry = true
        view.addSubview(passwordField)
        passwordField.autoPinEdge(toSuperviewSafeArea: .top, withInset: 320)
        passwordField.autoAlignAxis(toSuperviewAxis: .vertical)
        passwordField.autoSetDimensions(to: CGSize(width: 300, height: 50))
        passwordField.textAlignment = .center
        passwordField.layer.borderWidth = 2
        passwordField.layer.borderColor = UIColor.lightGray.cgColor
        passwordField.layer.cornerRadius = 3
        passwordField.layer.shadowOpacity = 0.2
        passwordField.layer.shadowRadius = 10
    }
    
    private func buildButtons() {
        
        let loginButton = UIButton()
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.backgroundColor = UIColor(red: 24/255, green: 157/255, blue: 228/255, alpha: 1.0)
        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        loginButton.layer.cornerRadius = 3
        loginButton.autoSetDimensions(to: CGSize(width: 120, height: 40))
        view.addSubview(loginButton)
        loginButton.autoAlignAxis(toSuperviewAxis: .vertical)
        loginButton.autoPinEdge(toSuperviewSafeArea: .top, withInset: 400)
        
        let seperator2 = UIView()
        seperator2.autoSetDimensions(to: CGSize(width: 300, height: 1))
        view.addSubview(seperator2)
        seperator2.backgroundColor = .gray
        seperator2.autoAlignAxis(toSuperviewAxis: .vertical)
        seperator2.autoPinEdge(toSuperviewSafeArea: .top, withInset: 475)
        
        let createLabel = UILabel()
        createLabel.text = "Don't have an account?"
        createLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        view.addSubview(createLabel)
        createLabel.autoPinEdge(toSuperviewSafeArea: .top, withInset: 530)
        createLabel.autoAlignAxis(toSuperviewAxis: .vertical)
        
        let createButton = UIButton()
        createButton.setTitle("Create account", for: .normal)
        createButton.setTitleColor(.white, for: .normal)
        createButton.backgroundColor = .orange
        createButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        createButton.layer.cornerRadius = 3
        createButton.autoSetDimensions(to: CGSize(width: 220, height: 40))
        view.addSubview(createButton)
        createButton.autoAlignAxis(toSuperviewAxis: .vertical)
        createButton.autoPinEdge(toSuperviewSafeArea: .top, withInset: 570)
    }
    
    private func buildViews() {
        view.backgroundColor = .white
        
        buildWelcomeLabel()
        
        buildInputs()
        
        buildButtons()
    }
}
