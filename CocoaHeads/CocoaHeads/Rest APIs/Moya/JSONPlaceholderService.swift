//
//  MyService.swift
//  CocoaHeads
//
//  Created by Stefan Kaczmarek on 1/25/18.
//  Copyright © 2018 The Zonie, LLC. All rights reserved.
//

import Moya

// derived from https://github.com/Moya/Moya/blob/master/docs/Examples/Basic.md

enum JSONPlaceholderService {
    case getUsers
    case createPost(post: Post)
    case getPosts(userId: Int)
    case deletePost(postId: Int)
    case getComments(postId: Int)
}

extension JSONPlaceholderService: TargetType {
    var baseURL: URL { return URL(string: "http://jsonplaceholder.typicode.com")! }
    var path: String {
        switch self {
        case .getUsers:
            return "/users"
        case .createPost, .getPosts:
            return "/posts"
        case .deletePost(let id):
            return "/posts/\(id)"
        case .getComments:
            return "/comments"
        }
    }
    var method: Method {
        switch self {
        case .createPost:
            return .post
        case .getUsers, .getPosts, .getComments:
            return .get
        case .deletePost:
            return .delete
        }
    }
    var task: Task {
        switch self {
        case .getUsers, .deletePost:
            return .requestPlain
        case let .getPosts(userId):
            return .requestParameters(parameters: ["userId": userId], encoding: URLEncoding.queryString)
        case .createPost(let post):
            return .requestJSONEncodable(post)
        case let .getComments(postId):
            return .requestParameters(parameters: ["postId": postId], encoding: URLEncoding.queryString)
        }
    }
    var sampleData: Data {
        switch self {
        case .getUsers:
            guard let url = Bundle.main.url(forResource: "users", withExtension: "json"), let data = try? Data(contentsOf: url) else { return Data() }
            return data
        case .createPost:
            guard let url = Bundle.main.url(forResource: "post", withExtension: "json"), let data = try? Data(contentsOf: url) else { return Data() }
            return data
        case .getPosts:
            guard let url = Bundle.main.url(forResource: "posts", withExtension: "json"), let data = try? Data(contentsOf: url) else { return Data() }
            return data
        case .deletePost:
            return "{}".data(using: .utf8)!
        case .getComments:
            guard let url = Bundle.main.url(forResource: "comments", withExtension: "json"), let data = try? Data(contentsOf: url) else { return Data() }
            return data
        }
    }
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
}
