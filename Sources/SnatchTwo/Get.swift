//
//  Get.swift
//  SnatchTwo
//
//  Created by Isaac Weisberg on 5/30/18.
//

import SnatchBase
import RxSwift
import Foundation

public extension Snatch.Get {
    public subscript(url: URL) -> Observable<Result> {
        return self [ url, nil, nil ]
    }
    
    public subscript(url: URL, params: URLQueryEncoding.Parameters?) -> Observable<Result> {
        return self [ url, params, nil ]
    }
    
    public subscript(url: URL, params: URLQueryEncoding.Parameters?, headers: [String: String]?) -> Observable<Result> {
        let request: URLRequest
        do {
            request = try generate(url, params, headers)
        } catch {
            return errornousObservable(error)
        }
        return father.request(request)
    }
}
