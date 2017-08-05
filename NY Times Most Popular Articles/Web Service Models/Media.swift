/*
Copyright (c) 2017 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

import Foundation
 
/* For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar */

public class Media {
	public var type : String?
	public var subtype : String?
	public var caption : String?
	public var copyright : String?
	public var approved_for_syndication : Int?
	public var media_metadata : Array<Media_metadata>?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let media_list = Media.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of Media Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [Media]
    {
        var models:[Media] = []
        for item in array
        {
            models.append(Media(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let media = Media(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: Media Instance.
*/
	required public init?(dictionary: NSDictionary) {

		type = dictionary["type"] as? String
		subtype = dictionary["subtype"] as? String
		caption = dictionary["caption"] as? String
		copyright = dictionary["copyright"] as? String
		approved_for_syndication = dictionary["approved_for_syndication"] as? Int
		if (dictionary["media-metadata"] != nil) { media_metadata = Media_metadata.modelsFromDictionaryArray(array: dictionary["media-metadata"] as! NSArray) }
	}

		
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.type, forKey: "type")
		dictionary.setValue(self.subtype, forKey: "subtype")
		dictionary.setValue(self.caption, forKey: "caption")
		dictionary.setValue(self.copyright, forKey: "copyright")
		dictionary.setValue(self.approved_for_syndication, forKey: "approved_for_syndication")

		return dictionary
	}

}
