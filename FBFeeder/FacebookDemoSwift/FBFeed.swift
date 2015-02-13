//
//  FBFeed.swift
//  FacebookDemoSwift
//
//  Created by Anoop tomar on 2/11/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class FBFeed: NSObject {
    var message: NSString!;
    var picture: NSString!;
    
    func parseToModel(FBData: NSArray) -> [FBFeed]{
        var fbFeed  = [FBFeed]();
        
        for i in 0..<FBData.count {
            var message = (FBData[i] as NSDictionary)["message"];
            var picture = (FBData[i] as NSDictionary)["picture"];
            var fb = FBFeed();
            if (picture != nil && message != nil){
                fb.message = message as NSString;
                fb.picture = picture as NSString;
                fbFeed.append(fb);
            }else if(message != nil){
                fb.message = message as NSString;
                fbFeed.append(fb);
            }
        }
        
        return fbFeed;
    }
}
