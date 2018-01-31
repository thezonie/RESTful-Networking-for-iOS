//
//  URLSessionAPI.swift
//  CocoaHeads
//
//  Created by Stefan Kaczmarek on 1/28/18.
//  Copyright © 2018 The Zonie, LLC. All rights reserved.
//

import Foundation

class URLSessionAPI: RestAPI {
    private var baseUrl: String

    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }

    // MARK: - RestAPI Methods

    // MARK: Users

    func getUsers(completion: @escaping UsersClosure) {
        let url = URL(string: "\(baseUrl)/users")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let data = data, let users = try? JSONDecoder().decode([User].self, from: data) {
                    completion(users)
                } else {
                    completion(nil)
                }
            }
        }.resume()
    }

    // MARK: Posts

    func createPost(_ post: Post, completion: @escaping PostClosure) {
        let url = URL(string: "\(baseUrl)/posts")!

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(post)

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let data = data, let post = try? JSONDecoder().decode(Post.self, from: data) {
                    completion(post)
                } else {
                    completion(nil)
                }
            }
        }.resume()
    }

    func getPosts(userId: Int, completion: @escaping PostsClosure) {
        var components = URLComponents(string: "\(baseUrl)/posts")!
        components.queryItems = [
            URLQueryItem(name: "userId", value: "\(userId)")
        ]
        let request = URLRequest(url: components.url!)

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let data = data, let posts = try? JSONDecoder().decode([Post].self, from: data) {
                    completion(posts)
                } else {
                    completion(nil)
                }
            }
        }.resume()
    }

    func deletePost(postId: Int, completion: @escaping DeleteClosure) {
        let url = URL(string: "\(baseUrl)/posts/\(postId)")!

        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                completion(error)
            }
        }.resume()
    }

    // MARK: Comments

    func getComments(postId: Int, completion: @escaping CommentsClosure) {
        var components = URLComponents(string: "\(baseUrl)/comments")!
        components.queryItems = [
            URLQueryItem(name: "postId", value: "\(postId)")
        ]
        let request = URLRequest(url: components.url!)

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let data = data, let comments = try? JSONDecoder().decode([Comment].self, from: data) {
                    completion(comments)
                } else {
                    completion(nil)
                }
            }
        }.resume()
    }
}
