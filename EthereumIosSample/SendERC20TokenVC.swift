//
//  SendERC20TokenVC.swift
//  EthereumIosSample
//
//  Created by Ergashev Odiljon on 2021/01/19.
//

import UIKit
import EthereumSDK
import BigInt

class SendERC20TokenVC: UIViewController {
    /**
       Declaring necessary UI outlet fields
     */
    @IBOutlet weak var senderAddressTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var contractAddressTxtField: UITextField!
    @IBOutlet weak var receiverAddressTxtLabel: UITextField!
    @IBOutlet weak var amountTxtField: UITextField!
    @IBOutlet weak var gasLimitTxtField: UITextField!
    @IBOutlet weak var txHashTxtField: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()

        // Do any additional setup after loading the view.
    }
    @IBAction func dismissBtnAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendBtnAction(_ sender: Any) {
        /**
            @param infura - Initialize infura
         */
        let eth = EthWalletManager.init(infuraUrl: "https://mainnet.infura.io/v3/a396c3461ac048a59f389c7778f06689")
        /**
         * Using this sendERC20Token function you can send ETH from walletAddress to another walletAddress.
         *
         * @param walletAddress - must be provided sender's wallet address
         * @param password - User must enter password of wallet address
         * @param gasPrice - gas price: 30 or more
         * @param gasLimit - gas limit atleast 60000 or more
         * @param tokenAmount - amount of token
         * @param tokenAmount - amount of ETH which user want to send
         * @param receiverWalletAddress - wallet address which is user want to send token
         *
         * @return if sending token completes successfully the function returns transactionHash or returns error name
         */
        let walletAddress = senderAddressTxtField.text!
        let password = passwordTxtField.text!
        let receiverAddress = receiverAddressTxtLabel.text!
        let tokenAmount = amountTxtField.text!
        let contractAddress = contractAddressTxtField.text!
        let gas = BigUInt(gasLimitTxtField.text!)
        do{
            /**
                if function successfully completes result can be caught in this block
             */
            let tx = try eth.sendERC20Token(walletAddress: walletAddress,
                                            password: password,
                                            receiverAddress: receiverAddress,
                                            tokenAmount: tokenAmount,
                                            tokenContractAddress: contractAddress,
                                            gasPrice: "50",
                                            gasLimit: gas!)
            txHashTxtField.text = tx
        } catch {
            /**
                 if function fails error can be catched in this block
             */
            print(error.localizedDescription)
        }
    }
}

