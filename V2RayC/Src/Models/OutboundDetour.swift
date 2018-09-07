//
//	OutboundDetour.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class OutboundDetour : NSObject, NSCoding, Mappable{

	var protocolStr : String?
	var settings : Setting?
	var tag : String?


	class func newInstance(map: Map) -> Mappable?{
		return OutboundDetour()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		protocolStr <- map["protocol"]
		settings <- map["settings"]
		tag <- map["tag"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         protocolStr = aDecoder.decodeObject(forKey: "protocol") as? String
         settings = aDecoder.decodeObject(forKey: "settings") as? Setting
         tag = aDecoder.decodeObject(forKey: "tag") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if protocolStr != nil{
			aCoder.encode(protocolStr, forKey: "protocol")
		}
		if settings != nil{
			aCoder.encode(settings, forKey: "settings")
		}
		if tag != nil{
			aCoder.encode(tag, forKey: "tag")
		}

	}

}
