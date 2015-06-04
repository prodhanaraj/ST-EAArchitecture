//
//  Action.h
//  SyncTimesInternalModels
//
//  Created by Dhanaraj on 03/06/15.
//  Copyright (c) 2015 iLink-Systems. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Action : NSObject

@property (nonatomic, strong) NSString * ActionID;
@property (nonatomic, strong) NSString * Name;
@property (nonatomic, strong) NSString * ActionImageURL;
@property (nonatomic, strong) NSString * ActionOrder;
@property (nonatomic, strong) NSString * IsActive;
@property (nonatomic, strong) NSString * IsActionNeeded;
@property (nonatomic, strong) NSString * IsHighPriorityAction;
@property (nonatomic, strong) NSString * IsActionCompleted;

@end
