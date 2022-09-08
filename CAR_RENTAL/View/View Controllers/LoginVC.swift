//
//  LoginVC.swift
//  CAR_RENTAL
//
//  Created by YUSUF KESKİN on 14.08.2022.
//

import UIKit

class LoginVC: UIViewController {
    
    var coordinator: MainCoordinator?

    static let identifier = "loginVC"
    
    let signUpView : UIView = {
        let view = UIView(frame: CGRect(x: 20, y: (UIScreen.main.bounds.height - 300) / 2, width: UIScreen.main.bounds.width - 40, height: 300))
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 10
        return view
    }()

    let emailTextField : UITextField = {
        let field = UITextField(frame: CGRect(x: 20, y: 20, width: UIScreen.main.bounds.width - 80, height: 40))
        field.placeholder = "email"
        field.backgroundColor = .white
        field.layer.cornerRadius = 10
        field.textAlignment = .center
        return field
    }()
    
    let passwordTextField : UITextField = {
        let field = UITextField(frame: CGRect(x: 20, y: 80, width: UIScreen.main.bounds.width - 80, height: 40))
        field.placeholder = "Password"
        field.backgroundColor = .white
        field.layer.cornerRadius = 10
        field.textAlignment = .center
        return field
    }()
    
    let loginBtn : UIButton = {
        let button = UIButton(frame: CGRect(x: 80, y: 160, width: UIScreen.main.bounds.width - 200, height: 40))
        button.setTitle("Login", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        button.layer.cornerRadius = 10
        button.addTarget(nil, action: #selector(login), for: .touchUpInside)
        button.clipsToBounds = true
        
        return button
    }()
    
    let goToSignUpBtn : UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 160, y: 260, width: 20, height: 20)
        
        button.setImage(UIImage.checkmark, for: UIControl.State.normal)
        button.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        button.layer.cornerRadius = 10
        button.addTarget(nil, action: #selector(goToSignUpVC), for: .touchUpInside)
        return button
    }()

    let textLbl : UILabel = {
        let label = UILabel(frame: CGRect(x: 20, y: 260, width: 200, height: 20))
        label.text = "or register now -> "
        label.textColor = .black
        label.layer.cornerRadius = 10
        label.font = UIFont(name: "Avenir", size: 12)
        label.textAlignment = .left
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpView.isUserInteractionEnabled = true
        view.isUserInteractionEnabled = true
        navigationController?.navigationBar.isHidden = true

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.addSubview(signUpView)
        

        signUpView.addSubview(emailTextField)
        signUpView.addSubview(passwordTextField)
        signUpView.addSubview(loginBtn)
        signUpView.addSubview(textLbl)
        signUpView.addSubview(goToSignUpBtn)
        
        
    }
    
    @objc func login() {
        AuthService.insance.loginUser(withEmail: emailTextField.text!, andPassword: passwordTextField.text!) { [self] success, error in
            if error != nil {
                print("Login Error")
            } else {
                goToMainVC()
            }
        }
    }
    
    @objc func goToSignUpVC(){
        coordinator?.navOccured(with: .signUpVC)
    }
    
    func goToMainVC  () {
        coordinator?.navOccured(with: .mainVC)
    }
    
    deinit {
        print("LoginVC deinited")
    }


}
