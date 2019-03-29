//
//  TimelineDataSource.swift
//  gabbie-ios
//
//  Created by Tomoya Hirano on 2018/10/21.
//  Copyright © 2018 Tomoya Hirano. All rights reserved.
//

import GabKit
import SwiftDate
import DifferenceKit
import AsyncDisplayKit

enum UpvotePatchKind {
  case upvote
  case downvote
  case even
}

//差分計算用の構造体
struct PostCupsule: Differentiable {
  let postResponse: PostResponse
  let durtyFlag: Bool
  
  var differenceIdentifier: String {
    return postResponse.id
  }
  func isContentEqual(to source: PostCupsule) -> Bool {
    guard !durtyFlag else { return false }
    return self.postResponse == source.postResponse
  }
}

final class TimelineDataSource {
  private var _posts: [PostResponse] = []
  var posts: [PostResponse] {
    get { return _posts }
    set {
      let oldValue = _posts.map({ PostCupsule(postResponse: $0, durtyFlag: false) })
      let newValue = newValue.map({ PostCupsule(postResponse: $0, durtyFlag: isDurty(postResponse: $0)) })
      
      let changeset = StagedChangeset(source: oldValue, target: newValue)
      tableView?.reload(using: changeset, with: .automatic, setData: { [weak self] (data) in
        self?._posts = data.map({ $0.postResponse })
      })
    }
  }
  private(set) var relativeTimeTexts: [String : String] = [:]
  private(set) var upvotePatches: [Int : UpvotePatchKind] = [:]
  private(set) var repostedPathces: [Int : Bool] = [:]
  private(set) var uncensoredPatches: Set<Int> = .init()
  private(set) var sentimentData: [Int : Sentiment] = [:]
  private var mutedUserIds: [Int] = []
  private var filteredPostResponseIds: [String] = []
  private weak var tableView: ASTableNode? = nil
  private let classificationService = ClassificationService()
  
  private func isDurty(postResponse: PostResponse) -> Bool {
    guard !upvotePatches.keys.contains(where: { $0 == postResponse.post.id }) else { return true }
    guard !repostedPathces.keys.contains(where: { $0 == postResponse.post.id }) else { return true }
    guard !uncensoredPatches.contains(where: { $0 == postResponse.post.id }) else { return true }
    return false
  }
  
  init(with tableView: ASTableNode) {
    self.tableView = tableView
  }
  
  func update(posts: [PostResponse]) {
    clearPatch()
    let newValue = applyFiltering(source: posts)
    //make relative times
    relativeTimeTexts = newValue.reduce(into: [String:String](), { $0[$1.id] = $1.publishedAt.toRelative() })
    //make sentiment data
    newValue.forEach({ addSentiment(post: $0.post.id, post: $0.post.body) })
    
    self.posts = newValue
  }
  
  private func applyFiltering(source: [PostResponse]) -> [PostResponse] {
    return source
      .filter({ !filteredPostResponseIds.contains($0.id) })
      .filter({ !mutedUserIds.contains($0.actuser.id) && !mutedUserIds.contains($0.post.user.id) })
//    この時点では弾かない
//      .filter({ classificationService.predictSentiment(from: $0.post.body) != .negative })
  }
  
  func addSentiment(post id: Int, post body: String) {
    guard sentimentData[id] == nil else { return }
    let sentiment = classificationService.predictSentiment(from: body)
    sentimentData[id] = sentiment
  }
  
  func addUpvotePatch(post id: Int) {
    upvotePatches[id] = .upvote
  }
  
  func removeUpvotePatch(post id: Int) {
    upvotePatches[id] = .even
  }
  
  func addDownvotePatch(post id: Int) {
    upvotePatches[id] = .downvote
  }
  
  func removeDownvotePatch(post id: Int) {
    upvotePatches[id] = .even
  }
  
  func addRepostPatch(post id: Int) {
    repostedPathces[id] = true
  }
  
  func removeRepostPatch(post id: Int) {
    repostedPathces[id] = false
  }
  
  func configure(unsensoredPost id: Int) {
    uncensoredPatches.insert(id)
  }
  
  #warning("Not impl api. It's dummy")
  func addUserMutePatch(user id: Int) {
    mutedUserIds.append(id)
    update(posts: posts)
  }
  
  #warning("Not impl api. It's dummy")
  func addPostFilterPatch(postResponse id: String) {
    filteredPostResponseIds.append(id)
    update(posts: posts)
  }
  
  func userId(forPostResponseId id: String) -> Int? {
    return posts.first(where: { $0.id == id })?.actuser.id
  }
  
  private func clearPatch() {
    upvotePatches = [:]
    repostedPathces = [:]
  }
}
