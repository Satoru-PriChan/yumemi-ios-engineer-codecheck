//
//  DetailViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var languageLabel: UILabel!
    
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var watchersLabel: UILabel!
    @IBOutlet weak var forksLabel: UILabel!
    @IBOutlet weak var openIssuesLabel: UILabel!
    
    var searchViewController: SearchViewController!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let selectedRepository = searchViewController.fetchedRepositories[searchViewController.selectedIndex]
        
        languageLabel.text = "Written in \(selectedRepository["language"] as? String ?? "")"
        starsLabel.text = "\(selectedRepository["stargazers_count"] as? Int ?? 0) stars"
        watchersLabel.text = "\(selectedRepository["wachers_count"] as? Int ?? 0) watchers"
        forksLabel.text = "\(selectedRepository["forks_count"] as? Int ?? 0) forks"
        openIssuesLabel.text = "\(selectedRepository["open_issues_count"] as? Int ?? 0) open issues"
        fetchAndSetImage()
        
    }
    
    func fetchAndSetImage(){
        
        let selectedRepository = searchViewController.fetchedRepositories[searchViewController.selectedIndex]
        
        titleLabel.text = selectedRepository["full_name"] as? String
        
        if let owner = selectedRepository["owner"] as? [String: Any] {
            if let imgURL = owner["avatar_url"] as? String {
                URLSession.shared.dataTask(with: URL(string: imgURL)!) { (data, res, err) in
                    let image = UIImage(data: data!)!
                    DispatchQueue.main.async {
                        self.imageView.image = image
                    }
                }.resume()
            }
        }
        
    }
    
}
