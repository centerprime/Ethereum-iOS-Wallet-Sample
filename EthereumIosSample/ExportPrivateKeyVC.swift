//
//  ExportPrivateKeyVC.swift
//  EthereumIosSample
//
//  Created by Ergashev Odiljon on 2021/01/19.
//

import UIKit
import EthereumSDK
class ExportPrivateKeyVC: UIViewController {
    /**
       Declaring necessary UI outlet fields
     */
    @IBOutlet weak var walletAddressTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var privateKeyLbl: UILabel!
    @IBOutlet weak var copyBtnOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func dismissBtnAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func copyBtnAction(_ sender: Any) {
        UIPasteboard.general.string = privateKeyLbl.text
    }
    @IBAction func exportPrivateKeyBtnAction(_ sender: Any) {
        /**
            @param infura - Initialize infura
         */
        let eth = EthWalletManager.init(infuraUrl: "https://mainnet.infura.io/v3/a396c3461ac048a59f389c7778f06689")
        do{
            /**
                if function successfully completes result can be caught in this block
             */
            let privateKey = try eth.exportPrivateKey(walletAddress: walletAddressTxtField.text!, password: passwordTxtField.text!)
            privateKeyLbl.text = privateKey.toHexString()
            copyBtnOutlet.setTitle("Copy", for: .normal)
        } catch {
            /**
                 if function fails error can be catched in this block
             */
            print(error.localizedDescription)
        }
    }
}
extension ExportPrivateKeyVC {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(ExportPrivateKeyVC.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
