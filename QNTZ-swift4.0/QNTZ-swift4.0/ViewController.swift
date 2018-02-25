//
//  ViewController.swift
//  QNTZ-swift4.0
//
//  Created by zhongdong on 04/12/2017.
//  Copyright © 2017 zhongdong. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: BasicViewController {
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.dataSource = self
        view.delegate = self
        view.register(UITableViewCell.self, forCellReuseIdentifier: "123")
        return view
    }()
    
    private lazy var coverView: UILabel = {
        let view = UILabel()
        view.text = "这个是一段文字"
        return view
    }()
    
    override func setupUI() {
        self.view.addSubviews(tableView, coverView)
    }
    
    override func setupConstraints() {
        if #available(iOS 11, *) {
            tableView.snp.makeConstraints {
                $0.edges.equalTo(self.view.safeAreaLayoutGuide)
            }
        } else {
            tableView.snp.makeConstraints{
                $0.edges.equalToSuperview()
            }
        }
        
        if #available(iOS 11, *) {
            coverView.snp.makeConstraints{
                $0.right.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-15)
            }
        } else {
            coverView.snp.makeConstraints{
                $0.right.equalToSuperview().offset(-15) 
                $0.bottom.equalToSuperview().offset(-15 - self.bottomLayoutGuide.length)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationItem.title = "这个是标题"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "123", for: indexPath)
        cell.textLabel?.text = "这个是第\(indexPath.row)行"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = BasicViewController()
        vc.title = "第二个页面"
        vc.view.backgroundColor = UIColor.randomColor()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

