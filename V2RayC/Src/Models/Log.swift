//
//	Log.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class Log : NSObject, NSCoding, Mappable{

	var loglevel : String?


	class func newInstance(map: Map) -> Mappable?{
		return Log()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		loglevel <- map["loglevel"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         loglevel = aDecoder.decodeObject(forKey: "loglevel") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if loglevel != nil{
			aCoder.encode(loglevel, forKey: "loglevel")
		}

	}

}