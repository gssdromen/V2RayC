//
//	Inbound.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class Inbound : NSObject, NSCoding, Mappable{

	var allowPassive : Bool?
	var listen : String?
	var port : Int?
	var protocolStr : String?
	var settings : Setting?


	class func newInstance(map: Map) -> Mappable?{
		return Inbound()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		allowPassive <- map["allowPassive"]
		listen <- map["listen"]
		port <- map["port"]
		protocolStr <- map["protocol"]
		settings <- map["settings"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         allowPassive = aDecoder.decodeObject(forKey: "allowPassive") as? Bool
         listen = aDecoder.decodeObject(forKey: "listen") as? String
         port = aDecoder.decodeObject(forKey: "port") as? Int
         protocolStr = aDecoder.decodeObject(forKey: "protocol") as? String
         settings = aDecoder.decodeObject(forKey: "settings") as? Setting

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if allowPassive != nil{
			aCoder.encode(allowPassive, forKey: "allowPassive")
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

	}

}
