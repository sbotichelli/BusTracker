//
//  ViewController.swift
//  BusTracker
//
//  Created by botichelli on 6/11/20.
//  Copyright © 2020 Oleksandra Sildushkina. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let apiService = BusServiceImpl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .red
        fetchBuses()
    }

    func fetchBuses() {
        apiService.getBuses(.all, completion: {
            result in
            switch result {
            case .success(let busResponse):
                print(busResponse)
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
}

