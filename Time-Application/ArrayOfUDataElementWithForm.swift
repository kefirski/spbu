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
        
        let forms: Set<String> = Set(self.map {$0.form}) // unique forms form data
        
        var result: [GroupedUDataElement] = []
        
        for form in forms {
            // find appropriate to form elements
            let elementsWithForm = self.filter {element in
                let dataElement = element as UDataElementWithForm
                return dataElement.form == form
            }
            // instance groupedUDataElement with appropriate elements and append it to result
            let groupedElement = GroupedUDataElement(form: form, elements: elementsWithForm)
            result.append(groupedElement)
        }
        return result
    }
}
