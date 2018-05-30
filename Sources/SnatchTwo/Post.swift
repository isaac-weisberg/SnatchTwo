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
    public subscript<Parameters: Encodable>(url: URL, params: Parameters) -> Observable<Result> {
        return self [ url, params, nil ]
    }
    
    public subscript<Parameters: Encodable>(url: URL, params: Parameters?, headers: [String: String]?) -> Observable<Result> {
        let request: URLRequest
        do {
            request = try generate(url, params, headers)
        } catch {
            return errornousObservable(error)
        }
        return father.request(request)
    }
}
