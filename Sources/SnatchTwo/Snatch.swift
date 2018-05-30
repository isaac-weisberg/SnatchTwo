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

internal func createHandler(_ observer: AnyObserver<Result>) -> Snatch.SnatchTaskCallback {
    return { result, error in
        if let error = error {
            observer.onError(error)
        }
        if let result = result {
            observer.onNext(result)
        } else {
            observer.onError(SnatchError.spooks)
        }
        observer.onCompleted()
    }
}
