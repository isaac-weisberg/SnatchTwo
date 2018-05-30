//
//  Result+Json.swift
//  SnatchTwo
//
//  Created by Isaac Weisberg on 5/30/18.
//

import Foundation
import SnatchBase
import RxSwift

public extension Result {
    func json<Target: Decodable>(_ type: Target.Type) -> Observable<Target> {
        return Observable.create { observer in
            let obj: Target
            do {
                obj = try self.json(type)
                observer.onNext(obj)
            } catch {
                observer.onError(error)
            }
            observer.onCompleted()
            return Disposables.create()
        }
    }
}

