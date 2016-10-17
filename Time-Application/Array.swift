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
        let groupedElements = groupByFeature { (dataElement: UDataElementWithForm) in
            return dataElement.form
        }
        
        // instance GroupedUDataElement from each group
        let result = groupedElements.map { dataElements -> GroupedUDataElement in
            let form = dataElements.first!.form
            return GroupedUDataElement(form: form, elements: dataElements)
        }
        
        return result
    }
}

extension Array where Element: UDataElementStudyDay {
    
    func actualDay() -> UDataElementStudyDay? {
        
        guard !isEmpty else { return nil }
        
        for day in self {
            if !day.isEnded {
                return day
            }
        }
        
        return last
    }
    
}


extension Array {
    
    func groupByFeature <T: Hashable, R> (_ feature: (R) -> T) -> [[R]] {
        
        // cast [Element] to [R]
        let elements = map { $0 as! R }
        
        // find unique features of [R]
        let uniqueFeatures = Set(elements.map(feature))
        
        // group elements by its unique features
        let result = uniqueFeatures.reduce([]) { (resultAccumulator: [[R]], nextFeature: T) in
            // find appropriate elements to every single unique feature
            let appropriateElements = elements.filter {feature($0) == nextFeature}
            // accomulate result with appropriate elements
            return resultAccumulator + [appropriateElements]
        }
        
        return result
    }
}
