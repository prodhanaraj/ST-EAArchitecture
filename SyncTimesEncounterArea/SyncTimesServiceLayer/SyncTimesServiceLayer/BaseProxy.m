//
//  SyncTimesServiceLayer.m
//  SyncTimesServiceLayer
//
//  Created by Dexter on 04/06/15.
//  Copyright (c) 2015 iLink-Systems. All rights reserved.
//

#import "BaseProxyProtected.h"

@implementation BaseProxy

static NSString *_username, *_password, *_instanceURL;

@synthesize serviceClient = _serviceClient;
@synthesize ObjectManager;

+ (void)setInstanceURL:(NSString *)instanceUrl {
    _instanceURL = instanceUrl;
}

+ (NSString *)getInstanceURL {
    return _instanceURL;
}

- (id)initWithClient:(ServiceClient *)serviceClient {
    self = [super init];
    if (self) {
        _serviceClient = serviceClient;
        self.ObjectManager = [[WCObjectManager alloc] initWithHTTPClient:self.serviceClient.HTTPClient];
        self.ObjectManager.requestSerializationMIMEType = RKMIMETypeJSON;
        if (_username && _password)
            [[RKObjectManager sharedManager].HTTPClient setAuthorizationHeaderWithUsername:_username password:_password];
        //Parse as JSON
        [RKMIMETypeSerialization registerClass:[RKNSJSONSerialization class] forMIMEType:@"text/html"];
        [RKMIMETypeSerialization registerClass:[RKNSJSONSerialization class] forMIMEType:@"application/json"];
        
        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
        
    }
    return self;
}

+ (void)setAutorizationCredentials:(NSString *)username Password:(NSString *)password {
    _username = username;
    _password = password;
    
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    [[RKObjectManager sharedManager].HTTPClient clearAuthorizationHeader];
}

- (Endpoint *)getEndPointForOperation:(NSString *)operationName {
    return (Endpoint * )[self.serviceClient.Operations objectForKey:operationName];
}

- (void)setHTTPHeaders:(Endpoint *)endpoint {
    for (NSString * header in endpoint.Headers) {
        NSString * value = endpoint.Headers[header];
        [[self.ObjectManager HTTPClient] setDefaultHeader:header value:value];
    }
}

@end
