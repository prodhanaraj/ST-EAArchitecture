//
//  Endpoint.m
//  SyncTimesServiceLayer
//
//  Created by Dhanaraj on 03/06/15.
//  Copyright (c) 2015 iLink-Systems. All rights reserved.
//

#import "Endpoint.h"

@interface Endpoint()
@property (nonatomic, strong, readwrite) NSString * ResourceComponent;
@property (nonatomic, strong, readwrite) NSDictionary * Parameters;
@property (nonatomic, strong, readwrite) NSDictionary * Headers;
@property (nonatomic, strong, readwrite) NSString * RoutingFormat;
@end

@implementation Endpoint
@synthesize ResourceComponent, Parameters, Headers;

- (id)initWithResource:(NSString *)resourceComponent parameters:(NSDictionary *)httpParameters headers:(NSDictionary *)httpHeaders route:(NSString *)routingFormat {
    self = [super init];
    if (self) {
        self.ResourceComponent = resourceComponent;
        self.Parameters = httpHeaders;
        self.Headers = httpHeaders;
        self.RoutingFormat = routingFormat;
    }
    return self;
}
@end
