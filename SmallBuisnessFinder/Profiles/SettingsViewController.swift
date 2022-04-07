//
//  SettingsViewController.swift
//  SmallBuisnessFinder
//
//  Created by Joe Wentzel on 3/16/22.
//


// Happy Birthday Joe
import UIKit

// struct to help with the groupings of cells
struct SettingsCell {
    let title: String
    let handler: (() -> Void)
}

class SetttingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let settingsTable: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "settings")

        return tableView
    }()
    
    var user: UserObject!
    var settings = [SettingsCell]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settings.append(SettingsCell(title : "Edit User Profile", handler : editProfile))
        settings.append(SettingsCell(title : "Privacy", handler : testingVoid))
        settings.append(SettingsCell(title : "Terms of Service", handler : testingVoid))
        settings.append(SettingsCell(title : "Log Out", handler : logout))
        
        
        settingsTable.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        settingsTable.delegate = self
        settingsTable.dataSource = self
         
        view.backgroundColor = .white
        
        view.addSubview(settingsTable)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settings", for: indexPath)
        cell.textLabel?.text = settings[indexPath.row].title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let model = settings[indexPath.row]
        model.handler()
    }
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = FavoritesCell()
//        cell.initFavCell(img: UIImage(named: businessNames[indexPath.row])!, name: businessNames[indexPath.row], category: businessCategories[indexPath.row], location: "Ann Arbor, Michigan")
//        return cell
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        let vc = BusinessProfileViewController()
//        vc.business = BusinessObject(name: businessNames[indexPath.row], phoneNumber: "800-123-4567", busDescription: descriptions[indexPath.row], latCoord: nil, longCoord: nil, websiteLink: nil, following: nil, followers: nil)
//        vc.hidesBottomBarWhenPushed = true
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
    
    func testingVoid(){
        print("Happy Birthday Joe")
    }
    
    func logout(){
        let actionSheet = UIAlertController(title: "Log Out", message: "Are You Sure You Want To Log Out", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { _ in
            // then log them out
            AuthManager.sharedAuth.logOut(completion: { success in DispatchQueue.main.async {
                if success {
                    // present log in screen
                    let loginVC = LoginViewController()
                    loginVC.modalPresentationStyle = .fullScreen
                    self.present(loginVC, animated: true) {
                        self.navigationController?.popToRootViewController(animated: false)
                        self.tabBarController?.selectedIndex = 0
                    }
                } else {
                    print("Problem in settings view controller, user tried to log in when not logged in.")
                }
            }})
        }))
        //actionSheet.popoverPresentationController?.sourceView = tableView
        //actionSheet.popoverPresentationController?.sourceRect = tableView.bounds
        present(actionSheet, animated: true)
    }
    
    func termsofservice(){
        
    }
    
    func privacy(){
        
    }
    
    func editProfile(){
        let vc = EditProfileViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
