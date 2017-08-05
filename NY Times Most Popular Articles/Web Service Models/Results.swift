/* 
Copyright (c) 2017 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

import Foundation
 
/* For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar */

public class Results {
	public var url : String?
	public var adx_keywords : String?
	public var column : String?
	public var section : String?
	public var byline : String?
	public var type : String?
	public var title : String?
	public var abstract : String?
	public var published_date : String?
	public var source : String?
	public var id : Int?
	public var asset_id : Int?
	public var views : Int?
	public var des_facet : Array<String>?
	public var org_facet : String?
	public var per_facet : Array<String>?
	public var geo_facet : Array<String>?
	public var media : Array<Media>?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let results_list = Results.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of Results Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [Results]
    {
        var models:[Results] = []
        for item in array
        {
            models.append(Results(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let results = Results(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: Results Instance.
*/
	required public init?(dictionary: NSDictionary) {

		url = dictionary["url"] as? String
		adx_keywords = dictionary["adx_keywords"] as? String
		column = dictionary["column"] as? String
		section = dictionary["section"] as? String
		byline = dictionary["byline"] as? String
		type = dictionary["type"] as? String
		title = dictionary["title"] as? String
		abstract = dictionary["abstract"] as? String
		published_date = dictionary["published_date"] as? String
		source = dictionary["source"] as? String
		id = dictionary["id"] as? Int
		asset_id = dictionary["asset_id"] as? Int
		views = dictionary["views"] as? Int
       /* if (dictionary["des_facet"] != nil) { des_facet = Des_facet.modelsFromDictionaryArray(array: dictionary["des_facet"] as! NSArray) }
		org_facet = dictionary["org_facet"] as? String
		if (dictionary["per_facet"] != nil) { per_facet = Per_facet.modelsFromDictionaryArray(array: dictionary["per_facet"] as! NSArray) }
		if (dictionary["geo_facet"] != nil) { geo_facet = Geo_facet.modelsFromDictionaryArray(array: dictionary["geo_facet"] as! NSArray) }
		if (dictionary["media"] != nil) { media = Media.modelsFromDictionaryArray(array: dictionary["media"] as! NSArray) } */
        
        let media = dictionary["media"]
        if media is Array<Any> {
            self.media = Media.modelsFromDictionaryArray(array: dictionary["media"] as! NSArray)
        }
	}

		
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.url, forKey: "url")
		dictionary.setValue(self.adx_keywords, forKey: "adx_keywords")
		dictionary.setValue(self.column, forKey: "column")
		dictionary.setValue(self.section, forKey: "section")
		dictionary.setValue(self.byline, forKey: "byline")
		dictionary.setValue(self.type, forKey: "type")
		dictionary.setValue(self.title, forKey: "title")
		dictionary.setValue(self.abstract, forKey: "abstract")
		dictionary.setValue(self.published_date, forKey: "published_date")
		dictionary.setValue(self.source, forKey: "source")
		dictionary.setValue(self.id, forKey: "id")
		dictionary.setValue(self.asset_id, forKey: "asset_id")
		dictionary.setValue(self.views, forKey: "views")
		dictionary.setValue(self.org_facet, forKey: "org_facet")

		return dictionary
	}

}
