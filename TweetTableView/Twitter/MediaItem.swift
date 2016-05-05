//
//  MediaItem.swift
//  Twitter
//
//  Created by CS193p Instructor.
//  Copyright (c) 2015 Stanford University. All rights reserved.
//

import Foundation

// holds the network url and aspectRatio of an image attached to a Tweet
// created automatically when a Tweet object is created

public struct MediaItem
{
    public var url: NSURL?
    public var aspectRatio: Double = 0
    
    public var description: String? {
        if let url = url {
            return (url.absoluteString ?? "no url") + " (aspect ratio = \(aspectRatio))"
        }
        return nil
    }
    
    // MARK: - Private Implementation

    init?(data: NSDictionary?) {
        var valid = false
        if let urlString = data?.valueForKeyPath(TwitterKey.MediaURL) as? NSString {
            if let urlString = urlString as? String {
                if let url = NSURL(string: urlString) {
                    self.url = url
                    let h = data?.valueForKeyPath(TwitterKey.Height) as? NSNumber
                    let w = data?.valueForKeyPath(TwitterKey.Width) as? NSNumber
                    if h != nil && w != nil && h?.doubleValue != 0 {
                        aspectRatio = w!.doubleValue / h!.doubleValue
                        valid = true
                    }
                
            }
            
            }
        } else {
            self.url = nil
        }
        
        if !valid {
            return nil
        }
    }
    
    struct TwitterKey {
        static let MediaURL = "media_url_https"
        static let Width = "sizes.small.w"
        static let Height = "sizes.small.h"
    }
}
