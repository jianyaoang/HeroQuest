//
//  Quests.h
//  HeroQuest
//
//  Created by Jian Yao Ang on 5/12/14.
//  Copyright (c) 2014 Jian Yao Ang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Quests : NSManagedObject

@property (nonatomic, retain) NSString * questName;
@property (nonatomic, retain) NSString * questGiver;
@property (nonatomic, retain) NSString * questDescription;
@property (nonatomic, retain) NSString * alignment;
@property (nonatomic, retain) NSNumber * locationLatitude;
@property (nonatomic, retain) NSNumber * locationLongitude;
@property (nonatomic, retain) NSNumber * questGiverLatitude;
@property (nonatomic, retain) NSNumber * questGiverLongitude;

@end
