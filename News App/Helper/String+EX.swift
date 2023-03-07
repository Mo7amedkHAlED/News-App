//
//  String+EX.swift
//  News App
//
//  Created by Mohamed Khaled on 07/03/2023.
//

import Foundation

extension String {
    
    func timeConvert()-> String{
        if self != " " {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            let date = dateFormatter.date(from: self)
            let passedTimeInSecond = Date().timeIntervalSince(date!)
            let minutes = round(passedTimeInSecond/60)
            if minutes > 59.0{
                let hour = round(minutes/60)
                if hour>23{
                    let day = round(hour/24)
                    return ("\(Int(day)) days ago")
                }else{
                    return ("\(Int(hour)) hours ago")
                }
                
            }else {
                return ("\(Int(minutes)) minutes ago")
            }
        }else{
            return " "
        }
    }

    
}
