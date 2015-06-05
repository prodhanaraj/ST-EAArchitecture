//
//  EncounterRequest.h
//  SyncTimesInternalModels
//
//  Created by Dhanaraj on 28/05/15.
//  Copyright (c) 2015 iLink-Systems. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol EncounterAreaDataRequestProtocol

@required
@property (nonatomic, strong) NSString * URL;

@end

@interface EncounterAreaDataRequest : NSObject<EncounterAreaDataRequestProtocol>

@end
