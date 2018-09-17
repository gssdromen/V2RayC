//
//	TcpSetting.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class TcpSetting : NSObject, NSCoding, Mappable{

	var connectionReuse : Bool?
	var header : Header?


	class func newInstance(map: Map) -> Mappable?{
		return TcpSetting()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		connectionReuse <- map["connectionReuse"]
		header <- map["header"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         connectionReuse = aDecoder.decodeObject(forKey: "connectionReuse") as? Bool
         header = aDecoder.decodeObject(forKey: "header") as? Header

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if connectionReuse != nil{
			aCoder.encode(connectionReuse, forKey: "connectionReuse")
		}
		if header != nil{
			aCoder.encode(header, forKey: "header")
		}

	}

}