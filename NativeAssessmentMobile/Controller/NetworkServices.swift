//
//  NetworkServices.swift
//  NativeAssessmentMobile
//
//  Created by KAMAL KUMAR BEHERA on 22/11/18.
//  Copyright © 2018 KAMAL KUMAR BEHERA. All rights reserved.
//

import UIKit

class NetworkServices: NSObject {
    
    //Fetch and load all data model with also fetch title of the tableview..
    class func loadNetworkData(success:@escaping(_ data:[DataModel])->Void){
        
        let nfirstStr = "http://samples.openweathermap.org/data/2.5/forecast?q="
        let nMiddleStr = TableViewController.cityName
        let nLastStr = ",DE&appid=b6907d289e10d714a6e88b30761fae22"
        var nfinalStr = (nfirstStr + nMiddleStr! + nLastStr)
        
        var model: [DataModel] = [DataModel]()
        let session: URLSession = URLSession.shared
        var task:URLSessionDownloadTask = URLSessionDownloadTask()
        let url:URL! = URL(string: nfinalStr)
        

        task = session.downloadTask(with: url, completionHandler: { (location: URL?, response: URLResponse?, error: Error?) -> Void in
            if location != nil{
                let data:Data! = try? Data(contentsOf: location!)
                do{
                    let responseJSONDict = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String:AnyObject]
                    let listObject = responseJSONDict["list"] as? [AnyObject]
                    for object in listObject!{
                        
                        let dateAndTime = object["dt_txt"] as? String
                        let weatherObj = object["weather"] as? [AnyObject]
                        
                        let mainObj = object["main"] as? [String:AnyObject]
                        let temperture = (mainObj!["temp"] as! Double)
                        var weatherDescription : String!
                        for wObject in weatherObj! {
                            weatherDescription = wObject["description"] as? String
                        }
                        
                        let humdity = mainObj!["humidity"] as? Int
                        
                        model.append(DataModel(description: weatherDescription, dateAndTime: dateAndTime, temperture: temperture, humdity: humdity))
                    }
                    success(model)
                    
                }catch let error as NSError {
                    print(error)
                }
            }
        })
        task.resume()
    }
        
}
