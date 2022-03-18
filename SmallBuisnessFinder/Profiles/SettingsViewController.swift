//
//  SettingsViewController.swift
//  SmallBuisnessFinder
//
//  Created by Joe Wentzel on 3/16/22.
//

import UIKit

// struct to help with the groupings of cells
struct SettingsCell {
    let title: String
    let handler: (() -> Void)
}

class SetttingsViewController: UIViewController {
    
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        return tableView
    }()
    
    // arrray to hold the content that will be in each cell
    private var settings = [[SettingsCell]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.backgroundColor = .white
        view.addSubview(tableView)
        configure()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.tableView.backgroundColor = .white
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    // sets up the buttons on the settings page - each settings.append represents a new grouping on the page
    private func configure() {
        
        settings.append([ SettingsCell(title: "User Info") { [weak self] in
            
        },
        SettingsCell(title: "Edit Profile") { [weak self] in
            self?.didTapEditProfile()
        }])/*
        SettingsCell(title: "Payment Methods") { [weak self] in
            self?.didTapPaymentMethods()
        },*/
        /*SettingsCell(title: "Link Contacts") { [weak self] in
            self?.didTapContacts()
        },*/
        /*,
        SettingsCell(title: "Squads") { [weak self] in
            self?.didTapSquads()
        },
        SettingsCell(title: "Payment Methods") { [weak self] in
            self?.didTapPaymentMethods()
        }*/
        
        
       /*SettingsCell(title: "Redeem Rewards") { [weak self] in
            self?.didTapRedeemAwards()
        },
        SettingsCell(title: "Refer For Awards") { [weak self] in
            self?.didTapReferForAwards()
        }])*/
        
        
        settings.append([SettingsCell(title: "Privacy Policy") { [weak self] in
            self?.didTapPrivacyPolicy()
        },
        SettingsCell(title: "Terms of Service") { [weak self] in
            self?.didTapTermsOfUse()
        }])
        
        settings.append([ SettingsCell(title: "Logout") { [weak self] in
            //self?.didTapLogout()
        }])
    }
    
    // this function does work now
    func didTapEditProfile() {
        /*let vc = EditProfileVC()
        vc.user = CQUserFunctions.getUserFromDefaults()
        vc.isSettings = true
        //vc.delegate = self
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)*/
        //self.performSegue(withIdentifier: "changeProfile", sender: self)
        /*let vc = PostEventResultsVC()
        CQEventFunctions.getEventsForUser() { (events, error) in
            if let events = events {
                vc.event = events[0]
                vc.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }*/
        
        
    }
    
    private func didTapSquads() {
        
    }
    
    private func didTapContactUs() {
        
        //let vc = ComplaintViewController()
        //navigationController?.pushViewController(vc, animated: true)
    }
    
    private func didTapRedeemAwards() {
        
    }
    
    
    // this button does not appear on the page at the moment - will be added down the line
    private func didTapPaymentMethods() {
        
        //self.createAlert(with: "Password Required", message: "Your password is required to access your payment Methods")
        
        /*let alert = UIAlertController(title: "Password Required", message: "Your password is required to access your payment Methods", preferredStyle: .alert)
        alert.addTextField() { (textfield) in
            textfield.placeholder = "Password"
            textfield.isSecureTextEntry = true
        }
        
        let continueAction = UIAlertAction(title: "Submit", style: .default) { [weak alert] _ in
            let vc = PaymentMethodsViewController() // will be changed to the PaymentMethodsViewController once that is created
            vc.title = "Payment Methods"
            self.navigationController?.pushViewController(vc, animated: true)
        }
        alert.addAction(continueAction)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)*/
        
    }
        
        
        
        
    
    
    
    // currently is just takes you to a VC with a webview showing the conquer website homepage
    // will change it to show the privacy policy and terms of use respectively from the website once they are on the website
    private func didTapPrivacyPolicy() {
        
    }
    private func didTapTermsOfUse() {
        
    }
    /*private func didTapLogout() {
        if let _ = UserDefaults.standard.value(forKey: "notification_token") as? String {
            CQNotificationFunctions.deleteToken { (success, error) in
                if let success = success {
                    if success {
                        UserDefaults.standard.set(nil, forKey: "uid")
                        GLOBAL_USERS_CONTAINER.friends = nil
                        GLOBAL_USERS_CONTAINER.outgoingRequests = nil
                        GLOBAL_USERS_CONTAINER.incomingRequests = nil
                        let sb = UIStoryboard(name: "Main", bundle: nil)
                        if let vc = sb.instantiateViewController(withIdentifier: "ViewController") as? OpeningVC {
                            self.present(vc, animated: true) {
                                self.view.window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
                            }
                        }
                    } else {
                        self.createAlert(with: "Logout Error", message: "Sorry, but your account could not be logged out at this time. Please contact Conquer. support.")
                    }
                } else {
                    self.createAlert(with: "Logout Error", message: "Sorry, but your account could not be logged out at this time. Please contact Conquer. support.")
                }
            }
        } else {
            UserDefaults.standard.set(nil, forKey: "uid")
            let sb = UIStoryboard(name: "Main", bundle: nil)
            if let vc = sb.instantiateViewController(withIdentifier: "ViewController") as? OpeningVC {
                self.present(vc, animated: true) {
                    self.view.window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
                }
            }
        }
    }*/
    
    

}

extension SetttingsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = settings[indexPath.section][indexPath.row].title
        
        // this sets up header cells with larger and bold font
        if cell.textLabel?.text == "Referrals" || cell.textLabel?.text == "Using Conquer." || cell.textLabel?.text == "User Info" {
            cell.textLabel?.font = .boldSystemFont(ofSize: 18)
            cell.textLabel?.textColor = .black
            cell.accessoryType = UITableViewCell.AccessoryType.none
        }
        else if cell.textLabel?.text == "Logout"  {
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.font = .systemFont(ofSize: 18)
            cell.textLabel?.textColor = .red
        }
        else {
            cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
            cell.accessoryType = .disclosureIndicator
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let model = settings[indexPath.section][indexPath.row]
        model.handler()
    }
    
    
    
}
