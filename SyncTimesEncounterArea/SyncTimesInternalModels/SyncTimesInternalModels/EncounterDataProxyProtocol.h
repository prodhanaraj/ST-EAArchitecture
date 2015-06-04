//
//  EncounterProtocol.h
//  SyncTimesInternalModels
//
//  Created by Dhanaraj on 28/05/15.
//  Copyright (c) 2015 iLink-Systems. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseProxyProtocol.h"
#import "EncounterData.h"
#import "EncounterDataRequest.h"


#import "Organization.h"

@protocol EncounterDataProxyProtocol <BaseProxyProtocol>

- (void)GetEncounterData:(id <EncounterDataRequestProtocol>)requestParams onSuccess:(void (^)(id <EncounterDataProtocol> encounterData))success onFailure:(void (^)(NSError * error, int statusCode))failure;

@end
