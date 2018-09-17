//
//	StreamSetting.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class StreamSetting : NSObject, NSCoding, Mappable{

	var kcpSettings : KcpSetting?
	var network : String?
	var security : String?
	var tcpSettings : TcpSetting?
	var tlsSettings : TlsSetting?
	var wsSettings : WsSetting?


	class func newInstance(map: Map) -> Mappable?{
		return StreamSetting()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		kcpSettings <- map["kcpSettings"]
		network <- map["network"]
		security <- map["security"]
		tcpSettings <- map["tcpSettings"]
		tlsSettings <- map["tlsSettings"]
		wsSettings <- map["wsSettings"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         kcpSettings = aDecoder.decodeObject(forKey: "kcpSettings") as? KcpSetting
         network = aDecoder.decodeObject(forKey: "network") as? String
         security = aDecoder.decodeObject(forKey: "security") as? String
         tcpSettings = aDecoder.decodeObject(forKey: "tcpSettings") as? TcpSetting
         tlsSettings = aDecoder.decodeObject(forKey: "tlsSettings") as? TlsSetting
         wsSettings = aDecoder.decodeObject(forKey: "wsSettings") as? WsSetting

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if kcpSettings != nil{
			aCoder.encode(kcpSettings, forKey: "kcpSettings")
		}
		if network != nil{
			aCoder.encode(network, forKey: "network")
		}
		if security != nil{
			aCoder.encode(security, forKey: "security")
		}
		if tcpSettings != nil{
			aCoder.encode(tcpSettings, forKey: "tcpSettings")
		}
		if tlsSettings != nil{
			aCoder.encode(tlsSettings, forKey: "tlsSettings")
		}
		if wsSettings != nil{
			aCoder.encode(wsSettings, forKey: "wsSettings")
		}

	}

}