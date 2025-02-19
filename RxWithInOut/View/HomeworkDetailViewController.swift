//
//  HomeworkDetailViewController.swift
//  RxWithInOut
//
//  Created by 조우현 on 2/19/25.
//

import UIKit

final class HomeworkDetailViewController: UIViewController {
    
    var nameContents: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .gray
        navigationItem.title = nameContents
    }


}

