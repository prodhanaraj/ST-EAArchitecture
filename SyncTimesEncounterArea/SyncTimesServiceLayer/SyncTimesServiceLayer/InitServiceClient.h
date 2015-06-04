//
//  InitServiceClient.h
//  SyncTimesServiceLayer
//
//  Created by Dhanaraj on 04/06/15.
//  Copyright (c) 2015 iLink-Systems. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServiceClient.h"

@interface InitServiceClient : NSObject

+ (NSString * )BASE_URL;
+ (NSString * )INSTANCE_URL;

+ (ServiceClient * ) ENCOUNTER_DATA_SERVICE;

@end
