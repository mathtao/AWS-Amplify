//
//  FaceLivenessDetectorViewController.swift
//  FaceLivenessDetector
//
//  Created by DN040801DDF on 25.09.2023.
//

import UIKit
import FaceLiveness
import SwiftUI
//import AWSClientRuntime
//import AWSPluginsCore
//import Amplify
import Amplify
import AWSPluginsCore

struct MMckCredentialsProvider: AWSCredentialsProvider {
    let credentials: () -> AWSCredentials

    func fetchAWSCredentials() async throws -> AWSCredentials {
        credentials()
    }
}

//struct MyCredentials: AWSCredentials {
//    var accessKeyId: String { return "" }
//    var secretAccessKey: String { return "" }
//}
//
//struct MyCredentialsProvider: AWSCredentialsProvider {
//    func fetchAWSCredentials() async throws -> AWSCredentials {
//        return MyCredentials()
//    }
//}

class FaceLivenessDetectorViewController: UIViewController {
    
    var sessionID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        configureFaceLivenessDetection()
    }
    
    // MARK: - Private Methods
    
    private func setupNavigationBar() {
        self.title = "Face Detector"
    }
    
    private func configureFaceLivenessDetection() {
//        let customCredentialsProvider = MyCredentialsProvider()
//
//        if let sessionID = self.sessionID {
//            let faceLivenessSwiftUIView = FaceLivenessDetectorView(
//                sessionID: sessionID,
//                credentialsProvider: customCredentialsProvider,
//                region: "us-east-1",
//                disableStartView: false, // Your configuration
//                isPresented: .constant(true),
//                onCompletion: {[weak self] (result) in
//                    switch result {
//                    case .success:
//                        print("Liveness successfully completed")
//
//                        //成功后调用 获取结果的api查询 getLivenessSessionSesult
//
//
//                    case .failure(let error):
//                        print("Liveness error: \(error)")
//                        DispatchQueue.main.async {
//                            let alertC = UIAlertController(title: error.message, message: error.recoverySuggestion, preferredStyle: .alert)
//                            let confirmAction = UIAlertAction(title: "OK", style: .default) { (action: UIAlertAction) in
////                                guard let confirm = confirmHandler else {
////                                    return
////                                }
////                                confirm(action)
//                            }
//                            alertC.addAction(confirmAction)
//                            self?.present(alertC, animated: true)
//                        }
//                    }
//                }
//            )
//            
//            let hostingController = createHostingController(with: faceLivenessSwiftUIView)
//            addHostingControllerAsChild(hostingController)
//            configureConstraints(for: hostingController.view)
//        }
        
    }
    
    private func createHostingController(with rootView: FaceLivenessDetectorView) -> UIHostingController<FaceLivenessDetectorView> {
        return UIHostingController(rootView: rootView)
    }
    
    private func addHostingControllerAsChild(_ hostingController: UIHostingController<FaceLivenessDetectorView>) {
        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
    }
    
    private func configureConstraints(for view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),
            view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
}
