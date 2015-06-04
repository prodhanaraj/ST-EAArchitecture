//
//  InitServiceClient.m
//  SyncTimesServiceLayer
//
//  Created by Dhanaraj on 04/06/15.
//  Copyright (c) 2015 iLink-Systems. All rights reserved.
//

#import "InitServiceClient.h"
#import "BaseProxyProtected.h"

@implementation InitServiceClient

static NSDictionary * _servicesConfig;
NSString * const SERVICES_CONFIG = @"Services_Config";
NSString * const CONFIG_EXT = @"plist";

// App Constants - STARTS
NSString * const BASE_URL_INSTANCE_KEY = @"{INSTANCE_URL}";
// App Constants - ENDS

+ (NSDictionary * )servicesConfig {
    if (!_servicesConfig) {
        NSString * path = [[NSBundle mainBundle] pathForResource:SERVICES_CONFIG ofType:CONFIG_EXT];
        _servicesConfig = [NSDictionary dictionaryWithContentsOfFile:path];
    }
    return _servicesConfig;
}

+ (NSString *)INSTANCE_URL {
    NSString * instanceName = [BaseProxy getInstanceURL];
    return instanceName == nil ? @"" : instanceName;
}

+ (NSString *)BASE_URL {
    NSString * baseURL = (NSString * )[[self servicesConfig] valueForKey:@"BASE_URL"];
    if ([baseURL containsString:BASE_URL_INSTANCE_KEY]) {
        baseURL = [baseURL stringByReplacingOccurrencesOfString:BASE_URL_INSTANCE_KEY withString:[self INSTANCE_URL]];
    }
    return baseURL;
}

+ (ServiceClient *)ENCOUNTER_DATA_SERVICE {
    return [InitServiceClient GetServiceClientForService:@"ENCOUNTER"];
}

+ (ServiceClient * )GetServiceClientForService:(NSString * )serviceName{
    NSURL *url = [NSURL URLWithString:[self BASE_URL]];
    
    NSDictionary * serviceDict = [self servicesConfig][@"SERVICES"];
    NSDictionary * service = (NSDictionary * )[serviceDict valueForKey:serviceName];
    NSDictionary * operations = service[@"OPERATIONS"];
    NSMutableDictionary *endpoints = [NSMutableDictionary new];
    
    for (NSString *operationName in operations) {
        NSDictionary * operation= operations[operationName];
        endpoints[operationName] = [self GetEndpointForOperation:operation ResourceComponent:service[@"RESOURCE_COMPONENT"]];
    }
    
    NSDictionary <Endpoint> *endpointsDictionary = (NSDictionary <Endpoint> *)[NSDictionary dictionaryWithDictionary:endpoints];
    ServiceClient * serviceClient = [[ServiceClient alloc] initWithURL:url Services:endpointsDictionary];
    
    return serviceClient;
}

+ (Endpoint *)GetEndpointForOperation:(NSDictionary *)operation ResourceComponent:(NSString *)resource {
    Endpoint * endpoint = [[Endpoint alloc] initWithResource:resource parameters:operation[@"PARAMETERS"] headers:operation[@"HEADERS"] route:operation[@"ROUTE_FORMAT"]];
    return endpoint;
}

@end
