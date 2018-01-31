//
//  RestManager.swift
//  CocoaHeads
//
//  Created by Stefan Kaczmarek on 1/27/18.
//  Copyright © 2018 The Zonie, LLC. All rights reserved.
//

import Foundation

enum RestFramework {
    case urlSession
    case alamofire
    case moya
}

class RestManager {
    static let shared = RestManager()

    let urlSessionAPI = URLSessionAPI(baseUrl: "http://jsonplaceholder.typicode.com")
    let alamofireAPI = AlamofireAPI(baseUrl: "http://jsonplaceholder.typicode.com")
    let moyaAPI = MoyaAPI()

    var restFramework: RestFramework = .urlSession

    // MARK: - Users

    func getUsers(completion: @escaping UsersClosure) {
        switch restFramework {
        case .urlSession:
            urlSessionAPI.getUsers(completion: completion)
        case .alamofire:
            alamofireAPI.getUsers(completion: completion)
        case.moya:
            moyaAPI.getUsers(completion: completion)
        }
    }

    // MARK: - Posts

    func createPost(_ post: Post, completion: @escaping PostClosure) {
        switch restFramework {
        case .urlSession:
            urlSessionAPI.createPost(post, completion: completion)
        case .alamofire:
            alamofireAPI.createPost(post, completion: completion)
        case .moya:
            moyaAPI.createPost(post, completion: completion)
        }
    }

    func getPosts(userId: Int, completion: @escaping PostsClosure) {
        switch restFramework {
        case .urlSession:
            urlSessionAPI.getPosts(userId: userId, completion: completion)
        case .alamofire:
            alamofireAPI.getPosts(userId: userId, completion: completion)
        case .moya:
            moyaAPI.getPosts(userId: userId, completion: completion)
        }
    }

    func deletePost(postId: Int, completion: @escaping DeleteClosure) {
        switch restFramework {
        case .urlSession:
            urlSessionAPI.deletePost(postId: postId, completion: completion)
        case .alamofire:
            alamofireAPI.deletePost(postId: postId, completion: completion)
        case .moya:
            moyaAPI.deletePost(postId: postId, completion: completion)
        }
    }

    // MARK: - Comments

    func getComments(postId: Int, completion: @escaping CommentsClosure) {
        switch restFramework {
        case .urlSession:
            urlSessionAPI.getComments(postId: postId, completion: completion)
        case .alamofire:
            alamofireAPI.getComments(postId: postId, completion: completion)
        case .moya:
            moyaAPI.getComments(postId: postId, completion: completion)
        }
    }
}
