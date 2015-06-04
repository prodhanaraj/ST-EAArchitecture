//
//  EncounterProxy.m
//  SyncTimesBusinessLayer
//
//  Created by Dhanaraj on 28/05/15.
//  Copyright (c) 2015 iLink-Systems. All rights reserved.
//

#import "EncounterDataProxy.h"
#import "InitServiceClient.h"

@implementation EncounterDataProxy

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
    RKObjectMapping * EncounterDataMapping = [RKObjectMapping mappingForClass:[EncounterData class]];
    
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
                                                        @"IsActionAdded" : @"IsActionNeeded"
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
                                                               @"ISActionComplete" : @"ISActionComplete",
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
    [self.ObjectManager.router.routeSet addRoute:[RKRoute routeWithClass:[EncounterDataRequest class] pathPattern:[NSString stringWithFormat:@"%@%@", encounterDataEndpoint.ResourceComponent, encounterDataEndpoint.RoutingFormat] method:RKRequestMethodGET]];
}

-(void)GetEncounterData:(id<EncounterDataRequestProtocol>)requestParams onSuccess:(void (^)(id<EncounterDataProtocol>))success onFailure:(void (^)(NSError *, int))failure{
    
    Endpoint * encounterDataEndpoint = [self getEndPointForOperation:@"GET_ENCOUNTER_DATA"];
    [self setHTTPHeaders:encounterDataEndpoint];
    
    [self.ObjectManager getObject:(EncounterDataRequest *)requestParams path:nil parameters:nil success:^(RKObjectRequestOperation * operation, RKMappingResult * mappingResult){
        success(mappingResult.firstObject);
    }failure:^(RKObjectRequestOperation * operation, NSError * error){
        failure(error, (int)operation.HTTPRequestOperation.response.statusCode);
    }];
    
}

@end
