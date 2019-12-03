//
//  AditionalInfoViewController.swift
//  CaronaSocial
//
//  Created by Julia Conti Mestre on 29/11/19.
//  Copyright © 2019 Matheus Oliveira. All rights reserved.
//

import UIKit

class AditionalInfoViewController: UIViewController {
    
    @IBOutlet weak var progressImage: UIImageView!
    @IBOutlet weak var finishButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if registerScreen == 0 {
            progressImage.image = UIImage(named: "progress24")
        } else {
            progressImage.image = UIImage(named: "progress5")
        }
    }
    
    @IBAction func finishPressed(_ sender: UIButton) {
        let title = "Cadastro finalizado!"
        let msg = "Para entrar no aplicativo é preciso verificar seu endereço de email. Por favor confira sua caixa de entrada e siga as instruções no email que enviamos."
        
        displayMsg(title : title, msg : msg, style: .alert)
        
    }
    
    //Alert message
    func displayMsg(title : String, msg : String, style: UIAlertController.Style = .alert) {
        
        let ac = UIAlertController.init(title: title,
                                        message: msg,
                                        preferredStyle: style)
        
        ac.addAction(UIAlertAction.init(title: "OK",
                                        style: .default,
                                        handler: {(action: UIAlertAction!) in
                                            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                            let newRegisterViewController = storyBoard.instantiateViewController(withIdentifier: "Login") as! LoginViewController
                                            self.navigationController?.pushViewController(newRegisterViewController, animated: true)
                                            
        }))
        
    
        DispatchQueue.main.async {
            self.present(ac, animated: true, completion: nil)
        }
    }

}
