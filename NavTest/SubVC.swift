//
//  SubVC.swift
//  NavTest
//
//  Created by Alex on 13/04/21.
//

import UIKit

class SubVC: UIViewController {

    let colorView = UIScrollView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.prefersLargeTitles = false

    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Sub VC"
        self.view.backgroundColor = .white
        // Do any additional setup after loading the view.
        
        self.colorView.backgroundColor = .cyan
        self.view.addSubview(self.colorView)
        self.colorView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
