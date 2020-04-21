//
//  InMemoryFeedStore.swift
//  FeedStoreChallenge
//
//  Created by Dim on 21.04.2020.
//  Copyright © 2020 Essential Developer. All rights reserved.
//

import Foundation

public class InMemoryFeedStore: FeedStore {

    private typealias Cache = (feed: [LocalFeedImage], timestamp: Date)

    private var cache: Cache?

    public init() {}

    public func deleteCachedFeed(completion: @escaping DeletionCompletion) {
        cache = nil
        completion(nil)
    }

    public func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion) {
        cache = Cache(feed: feed, timestamp: timestamp)
        completion(nil)
    }

    public func retrieve(completion: @escaping RetrievalCompletion) {
        guard let cache = cache else {
            return completion(.empty)
        }
        completion(.found(feed: cache.feed, timestamp: cache.timestamp))
    }
}
