//
//	Routing.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper

class Routing : NSObject, NSCoding, Mappable{

	var settings : Setting?
	var strategy : String?


	class func newInstance(map: Map) -> Mappable?{
		return Routing()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map) {
		settings <- map["settings"]
		strategy <- map["strategy"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         settings = aDecoder.decodeObject(forKey: "settings") as? Setting
         strategy = aDecoder.decodeObject(forKey: "strategy") as? String
	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if settings != nil{
			aCoder.encode(settings, forKey: "settings")
		}
		if strategy != nil{
			aCoder.encode(strategy, forKey: "strategy")
		}
	}
}
