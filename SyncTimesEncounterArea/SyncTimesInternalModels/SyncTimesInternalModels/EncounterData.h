//
//  EncounterData.h
//  SyncTimesInternalModels
//
//  Created by Dhanaraj on 28/05/15.
//  Copyright (c) 2015 iLink-Systems. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EncounterDataRequest.h"

#import "Organization.h"

@protocol EncounterDataProtocol

@optional
@property (nonatomic, strong) id<EncounterDataRequestProtocol> RequestParameters;

@required
//@property (nonatomic, strong) NSArray * OrganizationData;
@property (nonatomic, strong) Organization *OrganizationData;
@property (nonatomic, strong) NSArray * ActionList;
@property (nonatomic, strong) NSArray * CurrentActions;
@property (nonatomic, strong) NSArray * OccupantList;

@end

@interface EncounterData : NSObject<EncounterDataProtocol>

@end
