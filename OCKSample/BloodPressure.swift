//
//  BloodPressure.swift
//  OCKSample
//
//  Created by Greg Ledbetter on 5/31/16.
//  Copyright © 2016 Apple. All rights reserved.
//

import Foundation


import ResearchKit
import CareKit

/**
 Struct that conforms to the `Assessment` protocol to define a blood glucose
 assessment.
 */
struct BloodPressure: Assessment {
    // MARK: Activity
    
    let activityType: ActivityType = .BloodPressure
    let systolicActivityType: ActivityType = .BloodPressureSystolic
    let diastolicActivityType: ActivityType = .BloodPressureDiastolic
    
    func carePlanActivity() -> OCKCarePlanActivity {
        // Create a weekly schedule.
        let startDate = NSDateComponents(year: 2016, month: 01, day: 01)
        let schedule = OCKCareSchedule.weeklyScheduleWithStartDate(startDate, occurrencesOnEachDay: [1, 1, 1, 1, 1, 1, 1])
        
        // Get the localized strings to use for the assessment.
        let title = NSLocalizedString("Blood Pressure", comment: "")
        let summary = NSLocalizedString("Before breakfast", comment: "")
        
        let activity = OCKCarePlanActivity.assessmentWithIdentifier(
            activityType.rawValue,
            groupIdentifier: nil,
            title: title,
            text: summary,
            tintColor: Colors.Blue.color,
            resultResettable: false,
            schedule: schedule,
            userInfo: nil
        )
        
        return activity
    }
    
    // MARK: Assessment
    
    func task() -> ORKTask {
        
        let titleText = NSLocalizedString("Input your blood pressure", comment: "")
        
        let step = ORKFormStep(identifier: activityType.rawValue, title: titleText, text: nil)
        
        // first field is systolic blood pressure
        let systolicText = NSLocalizedString("Systolic (top number)", comment: "Upper number")
        
        // Get the localized strings to use for the task.
        var type = HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBloodPressureSystolic)!
        var unit = HKUnit(fromString: "mmHg")
        var answerFormat = ORKHealthKitQuantityTypeAnswerFormat(quantityType: type, unit: unit, style: .Decimal)
        let systolicFormItem = ORKFormItem(identifier: systolicActivityType.rawValue, text: systolicText, answerFormat: answerFormat)
        systolicFormItem.placeholder = NSLocalizedString("", comment: "")
        
        // second field is diastolic blood pressure
        let diastolicText = NSLocalizedString("Diastolic (bottom number)", comment: "")
        type = HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBloodPressureDiastolic)!
        unit = HKUnit(fromString: "mmHg")
        answerFormat = ORKHealthKitQuantityTypeAnswerFormat(quantityType: type, unit: unit, style: .Decimal)
        let diastolicFormItem = ORKFormItem(identifier: diastolicActivityType.rawValue, text: diastolicText, answerFormat: answerFormat)
        diastolicFormItem.placeholder = NSLocalizedString("", comment: "")
        
        step.formItems = [systolicFormItem, diastolicFormItem]
        
        return ORKOrderedTask(identifier: activityType.rawValue, steps: [step])
    }
    
    
}
