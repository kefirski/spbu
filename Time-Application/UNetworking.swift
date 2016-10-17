//
//  Networking.swift
//  Time-Application
//
//  Created by Даниил on 16.09.16.
//  Copyright © 2016 Daniil Gavrilov. All rights reserved.
//

import Foundation

import Moya
import Result
import Async

final class UNetworking {
    
    private let provider = MoyaProvider<UService>()
    
    func loadData(with target: UService, _ callback: @escaping UDataClosure) {
        
        print("start downloading – target = \(target.baseURL, target.path)")
        
        // perform data downloading and pass it through the callback
        provider.request(target) { result in
            
            print("test")
            
            switch result {
            case let .success(moyaResponse):
                
                print("succes with status code = \(moyaResponse.statusCode)")
                
                // if everything is ok, then pass the data through the callback
                if moyaResponse.statusCode <= 400 {
                    let data = moyaResponse.data
                    callback(.success(data))
                } else {
                    // probably not everything is ok
                    callback(.failure(.responseCodeError))
                }
                
            case .failure:
                
                print("faulture in downloading \(#file)")
                
                // this means there was a network failure - either the request
                // wasn't sent (connectivity), or no response was received (server
                // timed out). In this case wait not for a while and try to get data again
                callback(.failure(.networkFailure))
                // try to get data again
                Async.background(after: 4) {
                    self.loadData(with: target, callback)
                }
            }
        }
    }
}
