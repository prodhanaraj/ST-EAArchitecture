//
//  ServiceClient.h
//  SyncTimesServiceLayer
//
//  Created by Dhanaraj on 04/06/15.
//  Copyright (c) 2015 iLink-Systems. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "Endpoint.h"

@class AFHTTPClient;

@interface ServiceClient : NSObject

@property (nonatomic, strong) NSURL * URL;
@property (nonatomic, strong, readonly) NSDictionary <Endpoint> *Operations;
@property (nonatomic, strong) AFHTTPClient * HTTPClient;

- (id)initWithURL:(NSURL * )baseURL Services:(NSDictionary <Endpoint> * )endpoints;


@end
