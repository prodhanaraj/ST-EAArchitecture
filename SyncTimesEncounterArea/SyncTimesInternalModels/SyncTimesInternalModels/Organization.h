//
//  Organization.h
//  SyncTimesInternalModels
//
//  Created by Dexter on 03/06/15.
//  Copyright (c) 2015 iLink-Systems. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Organization : NSObject

@property (nonatomic, strong) NSString * OrganizationID;
@property (nonatomic, strong) NSString * ProviderID;
@property (nonatomic, strong) NSString * ProviderImageURL;
@property (nonatomic, strong) NSString * PatientID;
@property (nonatomic, strong) NSString * GroupID;
@property (nonatomic, strong) NSString * EncounterAreaID;
@property (nonatomic, strong) NSString * EncounterAreaName;
@property (nonatomic) BOOL IsActive;

@end
