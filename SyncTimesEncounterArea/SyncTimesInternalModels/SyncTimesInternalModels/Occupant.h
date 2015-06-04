//
//  Occupant.h
//  SyncTimesInternalModels
//
//  Created by Dexter on 03/06/15.
//  Copyright (c) 2015 iLink-Systems. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Occupant : NSObject

@property (nonatomic, strong) NSString * UserID;
@property (nonatomic, strong) NSString * TokenID;
@property (nonatomic, strong) NSString * OccupantImageURL;
@property (nonatomic, strong) NSString * OrganizationID;

@end
