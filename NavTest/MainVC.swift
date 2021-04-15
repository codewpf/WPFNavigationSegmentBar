//
//  MainVC.swift
//  NavTest
//
//  Created by Alex on 13/04/21.
//

import UIKit
import SnapKit

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var toolBar: UIToolbar?
    var shadow: UIView?
    
    let tableView = UITableView(frame: CGRect.zero, style: .plain)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.largeTitleDisplayMode = .automatic
        self.navigationController?.navigationBar.prefersLargeTitles = true

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Test VC"

        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.verticalScrollIndicatorInsets = UIEdgeInsets(top: DTProgressNavigationBar.height, left: 0, bottom: 0, right: 0)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "testcell")
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
              
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            if let bar = self.navigationController?.navigationBar as? DTProgressNavigationBar {
                bar.block = { [weak self] (color, alpha) in
                    self?.toolBar?.barTintColor = color
                    self?.shadow?.alpha = alpha
                }
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "testcell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.section) \(indexPath.row)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = SubVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section == 0 else {
            return nil
        }
        
        guard self.toolBar == nil else {
            return self.toolBar!
        }
        
        let seg = UISegmentedControl(items: ["3天", "7天", "2周", "5周"])
        seg.selectedSegmentIndex = 0
        let item = UIBarButtonItem(customView: seg)
        
        let seg2 = UISegmentedControl(items: ["天","次数"])
        seg2.selectedSegmentIndex = 0
        let item2 = UIBarButtonItem(customView: seg2)

        let bar = UIToolbar()
        bar.setShadowImage(UIImage(), forToolbarPosition: .any)
        bar.items = [item, item2]
        bar.barTintColor = UIColor(white: 1, alpha: 1)
        
        let shadow = UIView(frame: CGRect(x: 0, y: DTProgressNavigationBar.height-0.33, width: UIScreen.main.bounds.width, height: 0.33))
        shadow.alpha = 0
        shadow.backgroundColor = UIColor(white: 0.7, alpha: 1)
        bar.addSubview(shadow)
        
        self.shadow = shadow
        self.toolBar = bar
        return bar
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return DTProgressNavigationBar.height
    }

}

