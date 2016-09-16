//
//  Representation.swift
//  Time-Application
//
//  Created by Даниил on 16.09.16.
//  Copyright © 2016 Daniil Gavrilov. All rights reserved.
//

import Foundation
import SwiftyJSON
import Result
import Async

class URepresentation {
    
    fileprivate var _data: [AnyObject]?
    fileprivate var _metadata: Metadata?
    
    let networkingBrain = UNetworking()
    
    func loadDataWith(_ target: UService, callback: @escaping (Result<Void, UNetworkingError>) -> Void) {
        // representation with different target should prepare data in different way
        switch target {
        case .getData(_, let level):
            switch level {
            case .l1:
                networkingBrain.loadDataWith(target) { result in
                    switch result {
                    case .success(let data):
                        let rawJSON = JSON(data: data)
                        let (dataJSON, metadataJSON) = self.extractDataAndMetadata(from: rawJSON)
    
                        self._metadata = Metadata(from: metadataJSON)
                        // sorry
                        let range = 1...dataJSON.count
                        self._data = range.map {
                            let item = dataJSON["\($0)"]
                            return UDataElement(from: item)
                        }
                        
                        // everything is ok
                        callback(.success())
                        
                    case .failure(.responseCodeError):
                        // callback with error
                        callback(.failure(.responseCodeError))
                        
                    case .failure(.networkFailure):
                        // callback with error
                        callback(.failure(.networkFailure))
                        // try to get data again
                        Async.background {
                            sleep(4)
                            self.loadDataWith(target, callback: callback)
                        }
                    }
                }
            default:
                break
            }
        }
    }
    
    var data: [AnyObject] {
        if let qdata = _data {
            return qdata
        } else {
            return []
        }
    }
    
    var metadata: Metadata? {
        return _metadata
    }
    
    fileprivate func extractDataAndMetadata(from: JSON) -> (JSON, JSON) {
        return (from["data"], from["metadata"])
    }
}
