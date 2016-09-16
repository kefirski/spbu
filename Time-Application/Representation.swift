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
            networkingBrain.loadDataWith(target) { result in
                switch result {
                case .success(let data):
                    let rawJSON = JSON(data: data)
                    let (dataJSON, metadataJSON) = self.extractDataAndMetadata(from: rawJSON)

                    self._metadata = Metadata(from: metadataJSON)
                    // sorry
                    let range = 1...dataJSON.count
                    switch level {
                    case .l1:
                        self._data = range.map {
                            let item = dataJSON["\($0)"]
                            return UDataElement(from: item)
                        }
                    default: break
                    }
                    // everything is ok
                    callback(.success())
                    
                case .failure(let error):
                    // callback with error
                    callback(.failure(error))
                    
                }
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
