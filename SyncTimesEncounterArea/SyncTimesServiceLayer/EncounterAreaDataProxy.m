//
//  EncounterProxy.m
//  SyncTimesBusinessLayer
//
//  Created by Dhanaraj on 28/05/15.
//  Copyright (c) 2015 iLink-Systems. All rights reserved.
//

#import "EncounterAreaDataProxy.h"
#import "InitServiceClient.h"

@implementation EncounterAreaDataProxy

- (instancetype)init{
    self = [super initWithClient:[InitServiceClient ENCOUNTER_DATA_SERVICE]];
    
    if (self) {
        [self initEncounterDataOperation];
    }
    
    return self;
}

- (void)initEncounterDataOperation {
    Endpoint * encounterDataEndpoint = [self getEndPointForOperation:@"GET_ENCOUNTER_DATA"];
    
    
    /********************************************* ENCOUNTER DATA MAPPING STARTS HERE *********************************************/
    
    /*********************** 1. ORGANIZATION DATA MAPPING STARTS HERE ***********************/
    RKObjectMapping * EncounterDataMapping = [RKObjectMapping mappingForClass:[EncounterAreaData class]];
    
    RKObjectMapping * OrganizationMapping = [RKObjectMapping mappingForClass:[Organization class]];
    [OrganizationMapping addAttributeMappingsFromDictionary:@{
                                                              @"OrganizationId" : @"OrganizationID",
                                                              @"ProviderId" : @"ProviderID",
                                                              @"ProviderImage" : @"ProviderImageURL",
                                                              @"PatientId" : @"PatientID",
                                                              @"GroupId" : @"GroupID",
                                                              @"EncounterAreaId" : @"EncounterAreaID",
                                                              @"EncounterAreaName" : @"EncounterAreaName",
                                                              @"IsActive" : @"IsActive"}];
    // Add relationship to encounter data
    RKRelationshipMapping * organizationRelationEncounter = [RKRelationshipMapping relationshipMappingFromKeyPath:@"Data" toKeyPath:@"OrganizationData" withMapping:OrganizationMapping];
    [EncounterDataMapping addPropertyMapping:organizationRelationEncounter];
    /*********************** ORGANIZATION DATA MAPPING ENDS HERE ***********************/
    
    /*********************** 2. ACTION MAPPING STARTS HERE ***********************/
    RKObjectMapping * ActionMapping = [RKObjectMapping mappingForClass:[Action class]];
    [ActionMapping addAttributeMappingsFromDictionary:@{
                                                        @"ActionId" : @"ActionID",
                                                        @"Name" : @"Name",
                                                        @"ActionImagePath" : @"ActionImageURL",
                                                        @"ActionOrder" : @"ActionOrder",
                                                        @"IsActive" : @"IsActive",
                                                        @"Priority" : @"Priority",
                                                        @"IsActionAdded" : @"IsActionAdded"
                                                        }];
    // Add relationship to encounter data
    RKRelationshipMapping * actionRelationEncounter = [RKRelationshipMapping relationshipMappingFromKeyPath:@"Data.ActionList" toKeyPath:@"ActionList" withMapping:ActionMapping];
    [EncounterDataMapping addPropertyMapping:actionRelationEncounter];
    /*********************** ACTION MAPPING ENDS HERE ***********************/
    
    /*********************** 3. CURRENT ACTION MAPPING STARTS HERE ***********************/
    RKObjectMapping * CurrentActionMapping = [RKObjectMapping mappingForClass:[CurrentAction class]];
    [CurrentActionMapping addAttributeMappingsFromDictionary:@{
                                                               @"Name" : @"Name",
                                                               @"ActionImagePath" : @"ActionImageURL",
                                                               @"IsActiveAction" : @"IsActiveAction",
                                                               @"IsActionComplete" : @"IsActionCompleted",
                                                               @"Priority" : @"Priority"
                                                               }];
    // Add relationship to encounter data
    RKRelationshipMapping * currentActionRelationEncounter = [RKRelationshipMapping relationshipMappingFromKeyPath:@"Data.CurrentActions" toKeyPath:@"CurrentActions" withMapping:CurrentActionMapping];
    [EncounterDataMapping addPropertyMapping:currentActionRelationEncounter];
    /*********************** CURRENT ACTION MAPPING ENDS HERE ***********************/
    
    /*********************** 4. OCCUPANT MAPPING STARTS HERE ***********************/
    RKObjectMapping * OccupantMapping = [RKObjectMapping mappingForClass:[Occupant class]];
    [OccupantMapping addAttributeMappingsFromDictionary:@{
                                                               @"UserId" : @"UserID",
                                                               @"TokenId" : @"TokenID",
                                                               @"OrganizationId" : @"OrganizationID"
                                                               }];
    // Add relationship to encounter data
    RKRelationshipMapping * occupantRelationEncounter = [RKRelationshipMapping relationshipMappingFromKeyPath:@"Data" toKeyPath:@"OccupantList" withMapping:OccupantMapping];
    [EncounterDataMapping addPropertyMapping:occupantRelationEncounter];
    /*********************** OCCUPANT MAPPING ENDS HERE ***********************/
    
    /********************************************* ENCOUNTER DATA MAPPING ENDS HERE *********************************************/

    
    RKResponseDescriptor * responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:EncounterDataMapping method:RKRequestMethodAny pathPattern:[NSString stringWithFormat:@"%@%@", encounterDataEndpoint.ResourceComponent, encounterDataEndpoint.RoutingFormat] keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [self.ObjectManager addResponseDescriptor:responseDescriptor];
    [self.ObjectManager.router.routeSet addRoute:[RKRoute routeWithClass:[EncounterAreaDataRequest class] pathPattern:[NSString stringWithFormat:@"%@%@", encounterDataEndpoint.ResourceComponent, encounterDataEndpoint.RoutingFormat] method:RKRequestMethodGET]];
}

- (void)GetEncounterAreaData:(id<EncounterAreaDataRequestProtocol>)requestParams onSuccess:(void (^)(id<EncounterAreaDataProtocol>))success onFailure:(void (^)(NSError *, int))failure onProgressUpdate:(void (^)(float))progressPercentage {
    
    __block double progress = 10;
    __block double step = (float)0;
    __block NSMutableDictionary * actionImages;
    __block EncounterAreaData * encounterAreaComponents;
    
    Endpoint * encounterDataEndpoint = [self getEndPointForOperation:@"GET_ENCOUNTER_DATA"];
    [self setHTTPHeaders:encounterDataEndpoint];
    
    if (progressPercentage) {
        progressPercentage(progress += step);
    }
    
    dispatch_group_t taskGroup = dispatch_group_create();
    dispatch_group_enter(taskGroup);
    
    [self.ObjectManager getObject:(EncounterAreaDataRequest *)requestParams path:nil parameters:nil success:^(RKObjectRequestOperation * operation, RKMappingResult * mappingResult){
        encounterAreaComponents = mappingResult.firstObject;
        actionImages = [[NSMutableDictionary alloc] initWithCapacity:[encounterAreaComponents.ActionList count]];
        for (Action * action in [encounterAreaComponents ActionList]) {
            step = (float)100 / [encounterAreaComponents.ActionList count];
            dispatch_group_enter(taskGroup);
            [self.ObjectManager.HTTPClient getPath:[action ActionImageURL] parameters:nil success:^(AFHTTPRequestOperation * operation, id responseObject){
                [actionImages setObject:responseObject forKey:[action ActionImageURL]];
                if (progressPercentage) {
                    progressPercentage(progress += step);
                }
                dispatch_group_leave(taskGroup);
            }failure:^(AFHTTPRequestOperation * operation, NSError * error){
                [actionImages setObject:@"" forKey:[action ActionImageURL]];
                if (progressPercentage) {
                    progressPercentage(progress += step);
                }
                dispatch_group_leave(taskGroup);
            }];
        }
        dispatch_group_leave(taskGroup);
    }failure:^(RKObjectRequestOperation * operation, NSError * error){
        dispatch_group_leave(taskGroup);
        failure(error, (int)operation.HTTPRequestOperation.response.statusCode);
    }];
    
    dispatch_queue_t waitingQueue = dispatch_queue_create("com.synctimes.waitingQueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(waitingQueue, ^{
        //waiting for threads
        dispatch_group_wait(taskGroup, DISPATCH_TIME_FOREVER);
        dispatch_async(dispatch_get_main_queue(), ^{
            EncounterAreaData * encounterAreaData = [EncounterAreaData new];
            encounterAreaData.OrganizationData = [encounterAreaComponents OrganizationData];
            encounterAreaData.ActionList = [encounterAreaComponents ActionList];
            encounterAreaData.CurrentActions = [encounterAreaComponents CurrentActions];
            encounterAreaData.OccupantList = [encounterAreaComponents OccupantList];
            encounterAreaData.actionImages = actionImages;
            success(encounterAreaData);
        });
    });
}

@end
