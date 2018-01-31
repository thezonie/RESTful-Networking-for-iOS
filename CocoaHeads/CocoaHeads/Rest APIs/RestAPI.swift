//
//  RestAPI.swift
//  CocoaHeads
//
//  Created by Stefan Kaczmarek on 1/27/18.
//  Copyright © 2018 The Zonie, LLC. All rights reserved.
//

import Foundation

typealias UsersClosure = ([User]?) -> Void

typealias PostClosure = (Post?) -> Void
typealias PostsClosure = ([Post]?) -> Void
typealias DeleteClosure = (Error?) -> Void

typealias CommentsClosure = ([Comment]?) -> Void

protocol RestAPI {
    func getUsers(completion: @escaping UsersClosure)

    func createPost(_ post: Post, completion: @escaping PostClosure)
    func getPosts(userId: Int, completion: @escaping PostsClosure)
    func deletePost(postId: Int, completion: @escaping DeleteClosure)

    func getComments(postId: Int, completion: @escaping CommentsClosure)
}
