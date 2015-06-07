//
//  EncounterData.h
//  SyncTimesInternalModels
//
//  Created by Dhanaraj on 28/05/15.
//  Copyright (c) 2015 iLink-Systems. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EncounterAreaDataRequest.h"

#import "Organization.h"

@protocol EncounterAreaDataProtocol

@optional
@property (nonatomic, strong) id<EncounterAreaDataRequestProtocol> RequestParameters;

@required
@property (nonatomic, strong) Organization *OrganizationData;
@property (nonatomic, strong) NSArray * ActionList;
@property (nonatomic, strong) NSArray * CurrentActions;
@property (nonatomic, strong) NSArray * OccupantList;

@property (nonatomic, strong) NSMutableDictionary * actionImages;

@end

@interface EncounterAreaData : NSObject<EncounterAreaDataProtocol>

@end
