//
//  ServiceClient.m
//  SyncTimesServiceLayer
//
//  Created by Dhanaraj on 04/06/15.
//  Copyright (c) 2015 iLink-Systems. All rights reserved.
//

#import "ServiceClient.h"
#import "RestKit/RestKit.h"

@interface ServiceClient()
@property (nonatomic, strong, readwrite) NSDictionary<Endpoint> * Operations;
@end

@implementation ServiceClient : NSObject
@synthesize URL, Operations, HTTPClient;

- (id)initWithURL:(NSURL *)baseURL Services:(NSDictionary<Endpoint> *)endpoints {
    self = [super init];
    if (self) {
        self.URL = baseURL;
        self.Operations = endpoints;
        self.HTTPClient = [[AFHTTPClient alloc] initWithBaseURL:baseURL];
    }
    return self;
}

@end
