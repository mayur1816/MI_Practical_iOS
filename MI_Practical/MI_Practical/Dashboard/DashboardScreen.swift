//
//  DashboardScreen.swift
//  MI_Practical
//
//  Created by SLS M2 on 19/12/23.
//

import UIKit

class DashboardScreen: UIViewController {
    
    @IBOutlet weak var btnGenerateFolder: UIButton!
    @IBOutlet weak var btnFeedView: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func btnGenerateFolderClick(_ sender: Any) {
        let folderViewController = CreateFolderViewController()
        navigationController?.pushViewController(folderViewController, animated: true)
        
    }
    
    @IBAction func btnFeedViewClick(_ sender: Any) {
        let feedViewController = FeedViewController()
        navigationController?.pushViewController(feedViewController, animated: true)
    }
    
}

