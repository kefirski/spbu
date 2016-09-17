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
    
    func loadDataWith(_ target: UService, usingRawData: Bool = false, andThen performCallback: @escaping UVoidClojure) {
        // representation with different target should prepare data in different way
        // raw data uses when it is necessary to store in UDataElement not only main data
        // UVoidClojure is discribed in UResult file
        switch target {
        case .getData(_, let level):
            networkingBrain.loadDataWith(target) { result in
                switch result {
                case .success(let data):
                    let rawJSON = JSON(data: data)
                    let (dataJSON, metadataJSON) = self.extractDataAndMetadata(from: rawJSON)
                    
                    if level == .l3 {
                        print(dataJSON)
                    }

                    self._metadata = Metadata(from: metadataJSON)
                    // sorry
                    let range = 1...dataJSON.count
                    switch level {
                    case .l1, .l2:
                        self._data = range.map {
                            let item = dataJSON["\($0)"]
                            return UDataElement(from: item, withRawData: usingRawData)
                        }
                    case .l3:
                        self._data = range.map {
                            let item = dataJSON["\($0)"]
                            return UDataElementWithForm(from: item)
                        }
                    default: break
                    }
                    // everything is ok
                    performCallback(.success())
                    
                case .failure(let error):
                    // callback with error
                    self.clearData()
                    performCallback(.failure(error))
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
    
    fileprivate func clearData() {
        _data = nil
        _metadata = nil
    }
}
