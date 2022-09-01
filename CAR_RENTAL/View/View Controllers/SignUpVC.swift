//
//  SignUpVC.swift
//  CAR_RENTAL
//
//  Created by YUSUF KESKİN on 14.08.2022.
//

import UIKit

class SignUpVC: UIViewController, Coordinating {
    
    var coordinator: Coordinator?
    
    static let identifier = "signUpVC"
    
    let signUpView : UIView = {
        let view = UIView(frame: CGRect(x: 20, y: (UIScreen.main.bounds.height - 300) / 2, width: UIScreen.main.bounds.width - 40, height: 300))
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 10
        return view
    }()
    
    let nameTextField : UITextField = {
        let field = UITextField(frame: CGRect(x: 20, y: 20, width: UIScreen.main.bounds.width - 80, height: 40))
        field.placeholder = "Name"
        field.backgroundColor = .white
        field.layer.cornerRadius = 10
        field.textAlignment = .center
        return field
    }()
    
    let emailTextField : UITextField = {
        let field = UITextField(frame: CGRect(x: 20, y: 80, width: UIScreen.main.bounds.width - 80, height: 40))
        field.placeholder = "email"
        field.backgroundColor = .white
        field.layer.cornerRadius = 10
        field.textAlignment = .center
        return field
    }()
    
    let passwordTextField : UITextField = {
        let field = UITextField(frame: CGRect(x: 20, y: 140, width: UIScreen.main.bounds.width - 80, height: 40))
        field.placeholder = "Password"
        field.backgroundColor = .white
        field.layer.cornerRadius = 10
        field.textAlignment = .center
        return field
    }()
    
    let signUpButton : UIButton = {
        let button = UIButton(frame: CGRect(x: 80, y: 200, width: UIScreen.main.bounds.width - 200, height: 40))
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        button.layer.cornerRadius = 10
        button.addTarget(nil, action: #selector(signUp), for: .touchUpInside)
        button.clipsToBounds = true
        
        return button
    }()
    
    let goToLoginBtn : UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 160, y: 260, width: 20, height: 20)
        
        button.setImage(UIImage.checkmark, for: UIControl.State.normal)
        button.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        button.layer.cornerRadius = 10
        button.addTarget(nil, action: #selector(goToLoginVC), for: .touchUpInside)
        return button
    }()

    let textLbl : UILabel = {
        let label = UILabel(frame: CGRect(x: 20, y: 260, width: 200, height: 20))
        label.text = "...or Login now -> "
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

       
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.addSubview(signUpView)
        

        
        signUpView.addSubview(nameTextField)
        signUpView.addSubview(emailTextField)
        signUpView.addSubview(passwordTextField)
        signUpView.addSubview(signUpButton)
        signUpView.addSubview(textLbl)
        signUpView.addSubview(goToLoginBtn)
        
        
    }
    
    @objc func signUp() {
        AuthService.insance.createUser(withEmail: emailTextField.text!, andPassword: passwordTextField.text!, andUsername: nameTextField.text!) { success, error in
            if let error = error {
                print("SignUpError")
            } else {
                self.goToLoginVC()
            }
        }
    }

    
    @objc func goToLoginVC() {
        coordinator?.navOccured(with: .loginVC)
    }

}
