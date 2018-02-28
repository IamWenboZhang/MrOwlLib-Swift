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
    
    //根据Url获取网络图片
    //参数：URL（图片的网络路径）
    //返回值: 获得到的UIImage
    static func getUIImageByUrl(URL: String) -> UIImage? {
        var result:UIImage?
        let data = NSData(contentsOfURL: NSURL(string: URL)!)
        if(data != nil){
            result = UIImage(data: data!)
        }else{
            result = nil
        }
        return result
    }
    
    //本地缓存偏好设置
    static func setDefault(key:String,value:AnyObject?){
        if value == nil{
            NSUserDefaults.standardUserDefaults().removeObjectForKey(key)
        }else{
            NSUserDefaults.standardUserDefaults().setObject(value, forKey: key)
            NSUserDefaults.standardUserDefaults().synchronize() //同步
        }
    }
    
    //删除
    static func removeUserDefault(key:String?){
        if key != nil{
            NSUserDefaults.standardUserDefaults().removeObjectForKey(key!)
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    //获取设置
    static func getDefault(key:String) ->AnyObject?{
        return NSUserDefaults.standardUserDefaults().valueForKey(key)
    }
}



class LibOfSuanfa:NSObject{
    static func KMP(BigStr:String,SmallStr:String) -> Int{
        var i = 0
        var j = 0
        var next:[Int]
        LibOfSuanfa.GetNext(&next, Str: SmallStr)
        while(i < BigStr.length && j < SmallStr.length){
            if(j == -1 || BigStr[i] = SmallStr[j]){
                i += 1
                j += 1
            }
            else{
                j = next[i]
            }
        }
        if(j >= SmallStr.length){
            return i - SmallStr.length
        }
        return -1
    }
    
    private static func GetNext(inout next:[Int],Str:String){
        var i = 0
        var j = -1
        next[0] = -1
        while(j < Str.length - 1){
            if(j == -1 || Str[i] == Str[j]){
                i += 1
                j += 1
                if(Str[i] == Str[j]){
                    next[i] = next[j]
                }
                else{
                    next[i] = j
                }
            }
            else{
                j = next[j]
            }
        }
    }
}



//扩展
extension String{
    
    func split(splitStr: String) -> [String]{
        let result = self.componentsSeparatedByString(splitStr)
        return result
    }
    
    var length:Int{
        return self.characters.count
    }
    
    subscript(index:Int) -> Character{
        let charIndex = self.startIndex.advancedBy(index)
        return self[charIndex]
    }
}

extension UIImage {
    /**
     *  重设图片大小
     */
    func reSizeImage(reSize:CGSize)->UIImage {
        //UIGraphicsBeginImageContext(reSize);
        UIGraphicsBeginImageContextWithOptions(reSize,false,UIScreen.mainScreen().scale);
        self.drawInRect(CGRectMake(0, 0, reSize.width, reSize.height));
        let reSizeImage:UIImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return reSizeImage;
    }
    
    /**
     *  等比率缩放
     */
    func scaleImage(scaleSize:CGFloat)->UIImage {
        let reSize = CGSizeMake(self.size.width * scaleSize, self.size.height * scaleSize)
        return reSizeImage(reSize)
    }
}
