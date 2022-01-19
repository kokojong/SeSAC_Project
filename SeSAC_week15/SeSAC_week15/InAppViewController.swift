//
//  InAppViewController.swift
//  SeSAC_week15
//
//  Created by kokojong on 2022/01/07.
//

import UIKit
import StoreKit

class InAppViewController: UIViewController {
    
    // 1. 인앱 상풍 ID 정의
    var productIdentifier: Set<String> = ["com.kokojong.lotto.diamond100"]
    
    // 3-1. 인앱 상품 배열
    var productArray = Array<SKProduct>()
    var product: SKProduct?
    
    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        requestProductData()
        view.addSubview(button)
        button.backgroundColor = .yellow
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        button.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(100)
        }

        // Do any additional setup after loading the view.
    }
    
    // 4.구매버튼 클릭
    @objc func buttonClicked() {
        let payment = SKPayment(product: product!)
        SKPaymentQueue.default().add(payment)
        
        
    }
    
    // app store에 이 상품의 번들이 있는지 물어봐야함
    // 2. productIdentifier에 정의된 상품ID에 대한 정보 가져오기, 사용자의 디바이스가 인앱결제가 가능한지 확인
    func requestProductData() {
        if SKPaymentQueue.canMakePayments() {
            print("인앱 결제 가능!")
            let request = SKProductsRequest(productIdentifiers: productIdentifier)
            request.delegate = self
            request.start() // 인앱 상품 조회
        } else {
            print("인앱 결제 불가능")
        }
        
    }
    
    func receiptValidation(transaction: SKPaymentTransaction, productIden: String){
        // SandBox: “https://sandbox.itunes.apple.com/verifyReceipt”
                // iTunes Store : “https://buy.itunes.apple.com/verifyReceipt”
        
        let receiptFileURL = Bundle.main.appStoreReceiptURL
        let receiptData = try? Data(contentsOf: receiptFileURL!)
        let receiptString = receiptData?.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        
        print("receiptString",receiptString)
        SKPaymentQueue.default().finishTransaction(transaction)
        
        // 위치는 맞지만 쓰레드 처리 등이 필요하다
//        button.backgroundColor = .red
        
    }
}

extension InAppViewController: SKProductsRequestDelegate {
    // 3. 인앱 상품에 대한 정보 조회
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        let products = response.products
        
        if products.count > 0 {
            // 가지고 있는 인앱 상품이 1개이상이다
            // 상품을 하나씩 조회
            for i in products {
                productArray.append(i)
                product = i // 옵션
                print("product",product)
                print(i.localizedTitle, i.price, i.priceLocale, i.localizedDescription)
            }
            
        } else {
            print("프로덕트가 없습니다")
        }
    }
    
    
}
// 구매 취소, 승인에 대한 프로토콜
extension InAppViewController: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        print("updatedTransactions")
        
        for transaction in transactions {
            switch transaction.transactionState {
            
            case .purchased: // 구매 승인 이후 -> 영수증 검사 절차가 필요
                print("Transaction Approved \(transaction.payment.productIdentifier)")
                receiptValidation(transaction: transaction, productIden: transaction.payment.productIdentifier)
            
            case .failed: // 실패 토스트, transaction
                print("Transaction Failed")
                SKPaymentQueue.default().finishTransaction(transaction)
                
                
            @unknown default:
                break
            }
        }
        
        
        
    }
    
    // (옵셔널) 제거
    func paymentQueue(_ queue: SKPaymentQueue, removedTransactions transactions: [SKPaymentTransaction]) {
        print("removedTransactions")
    }
    
}
