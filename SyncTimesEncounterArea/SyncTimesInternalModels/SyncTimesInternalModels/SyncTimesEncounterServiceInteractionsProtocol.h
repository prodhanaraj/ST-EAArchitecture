//
//  SyncTimesServiceInteractionsProtocol.h
//  SyncTimesInternalModels
//
//  Created by Dhanaraj on 28/05/15.
//  Copyright (c) 2015 iLink-Systems. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Entities.h"

@protocol SyncTimesEncounterServiceInteractionsProtocol <NSObject>

@optional
- (void)didGetEncounterData:(id<EncounterDataProtocol>)encounterData;
-(void)onSyncTimesServiceError:(NSError *)error StatusCode:(int)statusCode;
-(void)onSyncTimesServiceWarning:(NSString *)warning;
@end
