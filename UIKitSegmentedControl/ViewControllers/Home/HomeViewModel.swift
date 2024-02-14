//
//  HomeViewModel.swift
//  UIKitSegmentedControl
//
//  Created by Zülfü Akgüneş on 13.02.2024.
//

import Foundation

protocol HomeViewModelProtocol {
    var delegate: HomeViewDelegate? { get set }
    var posts: [Posts] { get }
    var todos: [Todos] { get }
    var albums: [Albums] { get }
    func fetchPosts()
    func fetchToDos()
    func fetchAlbums()
    func changeSegmentedControl(at index: Int)
}

class HomeViewModel: HomeViewModelProtocol {
    
    weak var delegate: HomeViewDelegate?
    
    var posts: [Posts] = []
    var todos: [Todos] = []
    var albums: [Albums] = []
    
    func changeSegmentedControl(at index: Int) {
        switch index {
        case 0:
            fetchPosts()
        case 1:
            fetchToDos()
        case 2:
            fetchAlbums()
        default:
            break
        }
    }
    
    func fetchPosts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error { print(error.localizedDescription) }
            
            guard let data else { return }
            
            do {
                let decodePosts = try JSONDecoder().decode([Posts].self, from: data)
                self.posts = decodePosts
                self.delegate?.didUpdatePosts()
            }
            catch {
                print(error.localizedDescription)
            }
            
        }.resume()
    }
    
    func fetchToDos() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/todos") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error { print(error.localizedDescription) }
            
            guard let data else { return }
            
            do {
                let decodeTodos = try JSONDecoder().decode([Todos].self, from: data)
                self.todos = decodeTodos
                self.delegate?.didUpdatePosts()
            }
            catch {
                print(error.localizedDescription)
            }
            
        }.resume()
    }
    
    func fetchAlbums() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/albums") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error { print(error.localizedDescription) }
            
            guard let data else { return }
            
            do {
                let decodeAlbums = try JSONDecoder().decode([Albums].self, from: data)
                self.albums = decodeAlbums
                self.delegate?.didUpdatePosts()
            }
            catch {
                print(error.localizedDescription)
            }
            
        }.resume()
    }
    
    
}
