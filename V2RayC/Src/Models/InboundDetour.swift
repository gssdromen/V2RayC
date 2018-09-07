//
//	InboundDetour.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class InboundDetour : NSObject, NSCoding, Mappable{

	var allocate : Allocate?
	var domainOverride : [String]?
	var listen : String?
	var port : Int?
	var protocolStr : String?
	var settings : Setting?
	var streamSettings : StreamSetting?
	var tag : String?


	class func newInstance(map: Map) -> Mappable?{
		return InboundDetour()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		allocate <- map["allocate"]
		domainOverride <- map["domainOverride"]
		listen <- map["listen"]
		port <- map["port"]
		protocolStr <- map["protocol"]
		settings <- map["settings"]
		streamSettings <- map["streamSettings"]
		tag <- map["tag"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         allocate = aDecoder.decodeObject(forKey: "allocate") as? Allocate
         domainOverride = aDecoder.decodeObject(forKey: "domainOverride") as? [String]
         listen = aDecoder.decodeObject(forKey: "listen") as? String
         port = aDecoder.decodeObject(forKey: "port") as? Int
         protocolStr = aDecoder.decodeObject(forKey: "protocol") as? String
         settings = aDecoder.decodeObject(forKey: "settings") as? Setting
         streamSettings = aDecoder.decodeObject(forKey: "streamSettings") as? StreamSetting
         tag = aDecoder.decodeObject(forKey: "tag") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if allocate != nil{
			aCoder.encode(allocate, forKey: "allocate")
		}
		if domainOverride != nil{
			aCoder.encode(domainOverride, forKey: "domainOverride")
		}
		if listen != nil{
			aCoder.encode(listen, forKey: "listen")
		}
		if port != nil{
			aCoder.encode(port, forKey: "port")
		}
		if protocolStr != nil{
			aCoder.encode(protocolStr, forKey: "protocol")
		}
		if settings != nil{
			aCoder.encode(settings, forKey: "settings")
		}
		if streamSettings != nil{
			aCoder.encode(streamSettings, forKey: "streamSettings")
		}
		if tag != nil{
			aCoder.encode(tag, forKey: "tag")
		}

	}

}
