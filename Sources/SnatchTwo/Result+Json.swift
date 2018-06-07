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
    func json<Target: Decodable>(_ type: Target.Type) -> Single<Target> {
        return Single.create { single in
            do {
                let obj: Target = try self.json(type)
                single(.success(obj))
            } catch {
                single(.error(error))
                
            }
            
            return Disposables.create()
        }
    }
}
