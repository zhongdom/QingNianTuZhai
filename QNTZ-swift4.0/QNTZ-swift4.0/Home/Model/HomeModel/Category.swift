//
//	Category.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import SwiftyJSON


class Category : NSObject, NSCoding{

	var descriptionField : String!
	var icon : String!
	var id : Int!
	var name : String!
	var postCounts : Int!
	var slug : String!


	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
		descriptionField = json["description"].stringValue
		icon = json["icon"].stringValue
		id = json["id"].intValue
		name = json["name"].stringValue
		postCounts = json["post_counts"].intValue
		slug = json["slug"].stringValue
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if descriptionField != nil{
			dictionary["description"] = descriptionField
		}
		if icon != nil{
			dictionary["icon"] = icon
		}
		if id != nil{
			dictionary["id"] = id
		}
		if name != nil{
			dictionary["name"] = name
		}
		if postCounts != nil{
			dictionary["post_counts"] = postCounts
		}
		if slug != nil{
			dictionary["slug"] = slug
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         descriptionField = aDecoder.decodeObject(forKey: "description") as? String
         icon = aDecoder.decodeObject(forKey: "icon") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         name = aDecoder.decodeObject(forKey: "name") as? String
         postCounts = aDecoder.decodeObject(forKey: "post_counts") as? Int
         slug = aDecoder.decodeObject(forKey: "slug") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if descriptionField != nil{
			aCoder.encode(descriptionField, forKey: "description")
		}
		if icon != nil{
			aCoder.encode(icon, forKey: "icon")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if name != nil{
			aCoder.encode(name, forKey: "name")
		}
		if postCounts != nil{
			aCoder.encode(postCounts, forKey: "post_counts")
		}
		if slug != nil{
			aCoder.encode(slug, forKey: "slug")
		}

	}

}
