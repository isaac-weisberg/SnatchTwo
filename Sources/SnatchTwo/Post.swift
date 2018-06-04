//
//  Post.swift
//  SnatchTwo
//
//  Created by Isaac Weisberg on 5/30/18.
//

import RxSwift
import SnatchBase
import Foundation

public extension Snatch.Post {
    public subscript<Parameters: Encodable>(url: URL, params: Parameters) -> Single<Result> {
        return self [ url, params, nil ]
    }
    
    public subscript<Parameters: Encodable>(url: URL, params: Parameters?, headers: [String: String]?) -> Single<Result> {
        let request: URLRequest
        do {
            request = try generate(url, params, headers)
        } catch {
            return errornousSingle(error)
        }
        return father.request(request)
    }
}
