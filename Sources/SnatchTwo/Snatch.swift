//
//  Snatch.swift
//  SnatchTwo
//
//  Created by Isaac Weisberg on 5/30/18.
//

import Foundation
import RxSwift
import SnatchBase

public extension Snatch {
    public func request(_ request: URLRequest) -> Observable<Result> {
        return Observable.create { observer in
            let task = self.task(with: request, createHandler(observer))
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}

internal func createHandler(_ observer: AnyObserver<Result>) -> Snatch.DataTaskCallback {
    return { data, response, error in
        if let error = error {
            observer.onError(error)
        }
        if let response = response as? HTTPURLResponse {
            let packedResponse = Result(from: response, data)
            observer.onNext(packedResponse)
        } else {
            observer.onError(SnatchError.spooks)
        }
        observer.onCompleted()
    }
}
