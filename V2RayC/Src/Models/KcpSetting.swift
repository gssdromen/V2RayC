//
//	KcpSetting.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class KcpSetting : NSObject, NSCoding, Mappable{

	var congestion : Bool?
	var downlinkCapacity : Int?
	var header : Header?
	var mtu : Int?
	var readBufferSize : Int?
	var tti : Int?
	var uplinkCapacity : Int?
	var writeBufferSize : Int?


	class func newInstance(map: Map) -> Mappable?{
		return KcpSetting()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		congestion <- map["congestion"]
		downlinkCapacity <- map["downlinkCapacity"]
		header <- map["header"]
		mtu <- map["mtu"]
		readBufferSize <- map["readBufferSize"]
		tti <- map["tti"]
		uplinkCapacity <- map["uplinkCapacity"]
		writeBufferSize <- map["writeBufferSize"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         congestion = aDecoder.decodeObject(forKey: "congestion") as? Bool
         downlinkCapacity = aDecoder.decodeObject(forKey: "downlinkCapacity") as? Int
         header = aDecoder.decodeObject(forKey: "header") as? Header
         mtu = aDecoder.decodeObject(forKey: "mtu") as? Int
         readBufferSize = aDecoder.decodeObject(forKey: "readBufferSize") as? Int
         tti = aDecoder.decodeObject(forKey: "tti") as? Int
         uplinkCapacity = aDecoder.decodeObject(forKey: "uplinkCapacity") as? Int
         writeBufferSize = aDecoder.decodeObject(forKey: "writeBufferSize") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if congestion != nil{
			aCoder.encode(congestion, forKey: "congestion")
		}
		if downlinkCapacity != nil{
			aCoder.encode(downlinkCapacity, forKey: "downlinkCapacity")
		}
		if header != nil{
			aCoder.encode(header, forKey: "header")
		}
		if mtu != nil{
			aCoder.encode(mtu, forKey: "mtu")
		}
		if readBufferSize != nil{
			aCoder.encode(readBufferSize, forKey: "readBufferSize")
		}
		if tti != nil{
			aCoder.encode(tti, forKey: "tti")
		}
		if uplinkCapacity != nil{
			aCoder.encode(uplinkCapacity, forKey: "uplinkCapacity")
		}
		if writeBufferSize != nil{
			aCoder.encode(writeBufferSize, forKey: "writeBufferSize")
		}

	}

}