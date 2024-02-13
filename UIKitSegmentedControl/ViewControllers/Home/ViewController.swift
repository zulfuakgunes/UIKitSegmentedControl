//
//  ViewController.swift
//  UIKitSegmentedControl
//
//  Created by Zülfü Akgüneş on 12.02.2024.
//

import UIKit

protocol HomeViewDelegate: AnyObject {
    func didUpdatePosts()
}

class ViewController: UIViewController {
    var viewModel: HomeViewModelProtocol = HomeViewModel()
    
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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.fetchPosts()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBlue
        setLayout()
    }

    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        // Seçili segmentin index değerini kullanarak bir işlem yapabilirsiniz
        switch sender.selectedSegmentIndex {
        case 0:
            viewModel.fetchPosts()
        case 1:
            viewModel.fetchToDos()
        case 2:
            viewModel.fetchAlbums()
        default:
            break
        }
        print("Seçilen segment indexi: \(sender.selectedSegmentIndex)")
    }
    
    func setLayout() {
        NSLayoutConstraint.activate(
            [homeSegmentedControl.topAnchor.constraint(
                    equalTo: view.safeAreaLayoutGuide.topAnchor),
                homeSegmentedControl.leadingAnchor.constraint(
                    equalTo: view.leadingAnchor),
                homeSegmentedControl.trailingAnchor.constraint(
                    equalTo: view.trailingAnchor),
             homeSegmentedControl.heightAnchor.constraint(equalToConstant: 50),
             
             
             homeTableView.topAnchor.constraint(equalTo: homeSegmentedControl.bottomAnchor, constant: 10),
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
            switch homeSegmentedControl.selectedSegmentIndex {
            case 0:
                return viewModel.posts.count
            case 1:
                return viewModel.todos.count
            case 2:
                return viewModel.albums.count
            default:
                return 0
            }
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            switch homeSegmentedControl.selectedSegmentIndex {
            case 0:
                cell.textLabel?.text = viewModel.posts[indexPath.row].title
            case 1:
                cell.textLabel?.text = viewModel.todos[indexPath.row].title
            case 2:
                cell.textLabel?.text = viewModel.albums[indexPath.row].title
            default:
                return UITableViewCell()
            }
            
            return cell
        }
}

extension ViewController: HomeViewDelegate {
    func didUpdatePosts() {
        DispatchQueue.main.async {
            self.homeTableView.reloadData()
        }
    }
}

#Preview{
    ViewController()
}
