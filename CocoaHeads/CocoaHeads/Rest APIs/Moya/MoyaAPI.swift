//
//  MoyaAPI.swift
//  CocoaHeads
//
//  Created by Stefan Kaczmarek on 1/28/18.
//  Copyright © 2018 The Zonie, LLC. All rights reserved.
//

import Foundation
import Moya

// derived from https://github.com/Moya/Moya/blob/master/docs/Examples/Basic.md

class MoyaAPI: RestAPI {
    private let provider = MoyaProvider<JSONPlaceholderService>()

    // MARK - Users

    func getUsers(completion: @escaping UsersClosure) {
        provider.request(.getUsers) { result in
            switch result {
            case let .success(response) :
                if let users = try? response.map([User].self) {
                    completion(users)
                } else {
                    completion(nil)
                }
            case .failure:
                completion(nil)
            }
        }
    }

    // MARK: - Posts

    func createPost(_ post: Post, completion: @escaping PostClosure) {
        provider.request(.createPost(post: post)) { result in
            switch result {
            case let .success(response) :
                if let post = try? response.map(Post.self) {
                    completion(post)
                } else {
                    completion(nil)
                }
            case .failure:
                completion(nil)
            }
        }
    }

    func getPosts(userId: Int, completion: @escaping PostsClosure) {
        provider.request(.getPosts(userId: userId)) { result in
            switch result {
            case let .success(response) :
                if let posts = try? response.map([Post].self) {
                    completion(posts)
                } else {
                    completion(nil)
                }
            case .failure:
                completion(nil)
            }
        }
    }

    func deletePost(postId: Int, completion: @escaping DeleteClosure) {
        provider.request(.deletePost(postId: postId)) { result in
            switch result {
            case .success:
                completion(nil)
            case let .failure(error):
                completion(error)
            }
        }
    }

    // MARK: - Comments

    func getComments(postId: Int, completion: @escaping CommentsClosure) {
        provider.request(.getComments(postId: postId)) { result in
            switch result {
            case let .success(response) :
                if let comments = try? response.map([Comment].self) {
                    completion(comments)
                } else {
                    completion(nil)
                }
            case .failure:
                completion(nil)
            }
        }
    }
}
