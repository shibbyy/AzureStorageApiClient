//
//  ListQueuesRequest.swift
//  AzureStorageApiClient
//
//  Created by Hiromasa Ohno on 2015/08/06.
//  Copyright (c) 2015 Hiromasa Ohno. All rights reserved.
//

import Foundation

public extension AzureQueue {
    public class ListQueuesRequest:  Request {
        public let method = "GET"
        
        public typealias Response = Collection<Queue>
        
        public init() {
        }
        
        public func path() -> String {
            return "/?comp=list"
        }
        
        public func body() -> NSData? {
            return nil
        }
        
        public func additionalHeaders() -> [String : String] {
            return [:]
        }
        
        public func convertResponseObject(object: AnyObject?) -> Response? {
            return ResponseUtility.responseItems(object, keyPath: "Queues.Queue")
        }
        
        public func responseTypes() -> Set<String>? {
            return ["application/xml"]
        }
    }
}
