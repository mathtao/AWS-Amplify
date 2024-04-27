//
//  ViewController.swift
//  FaceLivenessDetector
//
//  Created by DN040801DDF on 24.09.2023.
//

import UIKit
import Amplify

class FaceLivnessHomeViewController: UIViewController {

    @IBOutlet weak var imagesLimitBackgroundView: UIView!
    @IBOutlet weak var imagesLimitSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var testServerButton: UIButton!
    @IBOutlet weak var realServerButton: UIButton!
    
    private var selectedSegmentIndex: Int = 0
    private var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        signIn()
    }
    
    private func setupUI() {
        configureViews()
        configureActivityIndicator()
        configureSegmentedControl()
    }
    
    private func configureViews() {
        let customGreenColor = UIColor(red: 79.0/255.0, green: 150.0/255.0, blue: 70.0/255.0, alpha: 1.0)
        
        imagesLimitBackgroundView.layer.cornerRadius = 10
        imagesLimitBackgroundView.layer.shadowColor = UIColor.black.cgColor
        imagesLimitBackgroundView.layer.shadowOpacity = 0.5
        imagesLimitBackgroundView.layer.shadowOffset = CGSize(width: 0, height: 4)
        imagesLimitBackgroundView.layer.shadowRadius = 4
        
        testServerButton.backgroundColor = UIColor.clear
        testServerButton.setTitleColor(customGreenColor, for: .normal)
        testServerButton.layer.borderWidth = 0.5
        testServerButton.layer.borderColor = customGreenColor.cgColor
        testServerButton.layer.cornerRadius = 10
        
        realServerButton.backgroundColor = customGreenColor
        realServerButton.layer.borderWidth = 0.5
        realServerButton.layer.borderColor = customGreenColor.cgColor
        realServerButton.layer.cornerRadius = 10
    }
    
    private func configureActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .gray
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
    }
    
    private func configureSegmentedControl() {
        imagesLimitSegmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
    }
    
    @objc private func segmentedControlValueChanged() {
        selectedSegmentIndex = imagesLimitSegmentedControl.selectedSegmentIndex
    }
    
    @IBAction func startServer(_ sender: UIButton) {
        activityIndicator.startAnimating()
//        self.createSession() {[weak self] sessionId in
//            guard let self = self else { return }
//            self.activityIndicator.stopAnimating()
//            self.handleSessionCreationResult(sessionId)
//        }
        
        self.activityIndicator.stopAnimating()
        self.handleSessionCreationResult("b08386ba-89b0-4bb8-972f-ab4892717e4c")
    }
    
    private func handleSessionCreationResult(_ sessionId: String) {
        print("Session created. Session ID: \(sessionId)")
        showSessionIDViewController(sessionID: sessionId)
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func showSessionIDViewController(sessionID: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let sessionIDVC = storyboard.instantiateViewController(withIdentifier: "SessionIDViewController") as? SessionIDViewController {
            sessionIDVC.sessionID = sessionID
            navigationController?.pushViewController(sessionIDVC, animated: true)
        }
    }
    
    func createSession(_ completion: @escaping (String) -> Void) {
        Task { @MainActor in
            let request = RESTRequest(
                apiName: "liveness",
                path: "/liveness/create"
            )

            do {
                let data = try await Amplify.API.post(request: request)
                let response = try JSONDecoder().decode(
                    CreateSessionResponse.self,
                    from: data
                )
                completion(response.sessionId)
            } catch {
                print("Error creating session", error)
            }
        }
    }

    func signIn() {
        Task {
            do {
                let session = try await Amplify.Auth.fetchAuthSession()
                if !session.isSignedIn {
                    let signInResult = try await Amplify.Auth.signIn(username: "amplify-dev", password: "dm@987654")
                    if signInResult.isSignedIn {
                        print("Is Signed In")
                    } else {
                        print("Not Signed In")
                    }
                } else {
                    print("Is signed in")
                }
            } catch {
                print("Error sign in")
            }
            
        }
    }

    func signOut() {
        Task {
            _ = await Amplify.Auth.signOut()
        }
    }

}
