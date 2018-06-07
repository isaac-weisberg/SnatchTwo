//
//  Snatch.swift
//  SnatchTwo
//
//  Created by Isaac Weisberg on 5/30/18.
//

import Foundation
import RxSwift
import Snatch

public extension Snatch.SnatchTaskResult {
    var asSingleEvent: SingleEvent<Result> {
        switch self {
        case .success(let res):
            return .success(res)
        case .failure(let error):
            return .error(error)
        }
    }
}

public extension Snatch {
    public func request(_ request: URLRequest) -> Single<Result> {
        return Single.create { single in
            let task = self.task(with: request, createHandler(single))
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}

internal func createHandler(_ single: @escaping (SingleEvent<Result>) -> Void) -> Snatch.SnatchTaskCallback {
    return { result in
        single(result.asSingleEvent)
    }
}
