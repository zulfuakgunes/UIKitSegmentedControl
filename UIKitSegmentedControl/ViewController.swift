//
//  ViewController.swift
//  UIKitSegmentedControl
//
//  Created by Zülfü Akgüneş on 12.02.2024.
//

import UIKit

class ViewController: UIViewController {
    lazy var homeSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["1","2","3"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        return segmentedControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBlue
        setLayout()
    }

    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        // Seçili segmentin index değerini kullanarak bir işlem yapabilirsiniz
        print("Seçilen segment indexi: \(sender.selectedSegmentIndex)")
    }
    
    func setLayout() {
        NSLayoutConstraint.activate(
            [homeSegmentedControl.topAnchor.constraint(
                    equalTo: view.safeAreaLayoutGuide.topAnchor,
                    constant: 30),
                homeSegmentedControl.leadingAnchor.constraint(
                    equalTo: view.leadingAnchor),
                homeSegmentedControl.trailingAnchor.constraint(
                    equalTo: view.trailingAnchor),
             homeSegmentedControl.heightAnchor.constraint(equalToConstant: 10)
            ]
        )
    }

}

#Preview{
    ViewController()
}
