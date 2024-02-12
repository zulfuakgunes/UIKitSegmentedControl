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
    
    lazy var homeTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        return tableView
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
             homeSegmentedControl.heightAnchor.constraint(equalToConstant: 50),
             
             
             homeTableView.topAnchor.constraint(equalTo: homeSegmentedControl.bottomAnchor, constant: -30),
             homeTableView.leadingAnchor.constraint(
                 equalTo: view.leadingAnchor),
             homeTableView.trailingAnchor.constraint(
                 equalTo: view.trailingAnchor),
             homeTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ]
        )
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - UITableViewDataSource
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // Burada satır sayısını döndürün
            return 10 // Örnek olarak 10 satır
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            // Hücre oluşturma ve yapılandırma
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = "Satır \(indexPath.row)"
            return cell
        }
}

#Preview{
    ViewController()
}
