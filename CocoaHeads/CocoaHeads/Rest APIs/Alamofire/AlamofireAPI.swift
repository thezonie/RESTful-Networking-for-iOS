//
//  AlamofireAPI.swift
//  CocoaHeads
//
//  Created by Stefan Kaczmarek on 1/27/18.
//  Copyright © 2018 The Zonie, LLC. All rights reserved.
//

import Foundation
import Alamofire

class AlamofireAPI: RestAPI {
    private var baseUrl: String

    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }

    // MARK: - RestAPI Methods

    // MARK: Users

    func getUsers(completion: @escaping UsersClosure) {
        let url = "\(baseUrl)/users"
        Alamofire.request(url).responseData { response in
            if let data = response.data, let users = try? JSONDecoder().decode([User].self, from: data) {
                completion(users)
            } else {
                completion(nil)
            }
        }
    }

    // MARK: Posts

    func createPost(_ post: Post, completion: @escaping PostClosure) {
        let url = "\(baseUrl)/posts"

        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(post)

        Alamofire.request(request).responseData { response in
            if let data = response.data, let post = try? JSONDecoder().decode(Post.self, from: data) {
                completion(post)
            } else {
                completion(nil)
            }
        }
    }

    func getPosts(userId: Int, completion: @escaping PostsClosure) {
        let url = "\(baseUrl)/posts"
        let parameters = ["userId": userId]
        Alamofire.request(url, parameters: parameters).responseData { response in
            if let data = response.data, let posts = try? JSONDecoder().decode([Post].self, from: data) {
                completion(posts)
            } else {
                completion(nil)
            }
        }
    }

    func deletePost(postId: Int, completion: @escaping DeleteClosure) {
        let url = "\(baseUrl)/posts/\(postId)"
        Alamofire.request(url, method: .delete).responseData { response in
            completion(response.error)
        }
    }

    // MARK: Comments

    func getComments(postId: Int, completion: @escaping CommentsClosure) {
        let url = "\(baseUrl)/comments"
        let parameters = ["postId": postId]
        Alamofire.request(url, parameters: parameters).responseData { response in
            if let data = response.data, let comments = try? JSONDecoder().decode([Comment].self, from: data) {
                completion(comments)
            } else {
                completion(nil)
            }
        }
    }
}
