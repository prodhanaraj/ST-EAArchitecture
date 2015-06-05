//
//  EncounterProtocol.h
//  SyncTimesInternalModels
//
//  Created by Dhanaraj on 28/05/15.
//  Copyright (c) 2015 iLink-Systems. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseProxyProtocol.h"
#import "EncounterAreaData.h"
#import "EncounterAreaDataRequest.h"


#import "Organization.h"

@protocol EncounterAreaDataProxyProtocol <BaseProxyProtocol>

- (void)GetEncounterAreaData:(id <EncounterAreaDataRequestProtocol>)requestParams onSuccess:(void (^)(id <EncounterAreaDataProtocol> encounterAreaData))success onFailure:(void (^)(NSError * error, int statusCode))failure onProgressUpdate:(void(^)(float progress))progressPercentage;

@end
