//
//	WsSetting.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class WsSetting : NSObject, NSCoding, Mappable{

	var connectionReuse : Bool?
	var headers : Header?
	var path : String?


	class func newInstance(map: Map) -> Mappable?{
		return WsSetting()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		connectionReuse <- map["connectionReuse"]
		headers <- map["headers"]
		path <- map["path"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         connectionReuse = aDecoder.decodeObject(forKey: "connectionReuse") as? Bool
         headers = aDecoder.decodeObject(forKey: "headers") as? Header
         path = aDecoder.decodeObject(forKey: "path") as? String

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
		if headers != nil{
			aCoder.encode(headers, forKey: "headers")
		}
		if path != nil{
			aCoder.encode(path, forKey: "path")
		}

	}

}