//
//  ArrayOfUDataElementWithForm.swift
//  Time-Application
//
//  Created by Даниил on 17.09.16.
//  Copyright © 2016 Daniil Gavrilov. All rights reserved.
//

import Foundation

extension Array where Element: UDataElementWithForm {
    func groupByForm() -> [GroupedUDataElement] {
        
        // get grouped by form elements
        let groupedElements = self.groupByFeature { (dataElement: UDataElementWithForm) in
            return dataElement.form
        }
        
        // instance GroupedUDataElement from each group
        let result = groupedElements.map {dataElements -> GroupedUDataElement in
            let form = dataElements.first!.form
            return GroupedUDataElement(form: form, elements: dataElements)
        }
        
        return result
    }
}


extension Array {
    func groupByFeature<T: Hashable, R> (_ f: @escaping (R) -> T) -> [[R]] {
        // cast [Element] to [R]
        let elements = self.map {$0 as! R}
        
        // find unique features of [R]
        let uniqueFeatures = Set(elements.map {f($0)})
        
        // group elements by its unique features
        let result = uniqueFeatures.reduce([]) { (resultAccomulator: [[R]], nextFeature: T) in
            // find appropriate elements to every single unique feature
            let appropriateElements = elements.filter {f($0) == nextFeature}
            // accomulate result with appropriate elements
            return resultAccomulator + [appropriateElements]
        }
        
        return result
    }
}
