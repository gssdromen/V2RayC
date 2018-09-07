//
//	Outbound.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class Outbound : NSObject, NSCoding, Mappable{

	var mux : Mux?
	var protocolStr : String?
	var settings : Setting?
	var streamSettings : StreamSetting?
	var tag : String?


	class func newInstance(map: Map) -> Mappable?{
		return Outbound()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		mux <- map["mux"]
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
         mux = aDecoder.decodeObject(forKey: "mux") as? Mux
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
		if mux != nil{
			aCoder.encode(mux, forKey: "mux")
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
