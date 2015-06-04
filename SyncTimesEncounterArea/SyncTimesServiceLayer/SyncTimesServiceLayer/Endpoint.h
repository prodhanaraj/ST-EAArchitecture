//
//  Endpoint.h
//  SyncTimesServiceLayer
//
//  Created by Dhanaraj on 03/06/15.
//  Copyright (c) 2015 iLink-Systems. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Endpoint <NSObject>

@required
@property (nonatomic, strong, readonly) NSString * ResourceComponent;
@property (nonatomic, strong, readonly) NSDictionary * Parameters;
@property (nonatomic, strong, readonly) NSDictionary * Headers;
@property (nonatomic, strong, readonly) NSString * RoutingFormat;

@end

@interface Endpoint : NSObject<Endpoint>

- (id)initWithResource:(NSString * )resourceComponent parameters:(NSDictionary * )httpParameters headers:(NSDictionary * )httpHeaders route:(NSString * )routingFormat;

@end
