//
//  LibByMrOwl.swift
//  OwnNews
//
//  Created by MrOwl on 15/12/10.
//  Copyright (c) 2015年 MrOwl. All rights reserved.
//

import UIKit


//编写者：张文博
//编写时间：2015-12-10
//描述：常用一些功能的包装简化
class LibByMrOwl: NSObject {
    
    //获取当前时间按照指定的格式格式化为字符串
    //参数：format（时间字符串的格式）
    static func getNowTimeToString(format : String) -> String
    {
        //获取当前时间
        let datetimeNow = NSDate()
        //设置时间输出的字符串格式
        let formatter = NSDateFormatter()
        formatter.dateFormat = format
        //转化为字符串
        let timestring = formatter.stringFromDate(datetimeNow) as String
        return timestring
    }
    
    //根据URL获取信息
    //参数：URL（要加载的Url）
    //参数：completionHandler（对于返回数据的操作）
    static func loadUrlData(URL:String , completionHandler:(NSURLResponse?,NSData?,NSError?) -> Void){
        let url = NSURL(string: URL)
        let loadRequest = NSURLRequest(URL: url!)
        let loadQueue = NSOperationQueue()
        NSURLConnection.sendAsynchronousRequest(loadRequest, queue: loadQueue, completionHandler: completionHandler)
    }
    
   
}
