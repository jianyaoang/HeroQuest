//
//  Quest.h
//  HeroQuest
//
//  Created by Jian Yao Ang on 5/10/14.
//  Copyright (c) 2014 Jian Yao Ang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Quest : NSObject
@property (nonatomic,strong)  NSString *questName;
@property (nonatomic,strong)  NSString *questGiver;
@property (nonatomic,strong)  NSString *questDescription;
@property (nonatomic, strong) NSString *alignment;
@property (nonatomic, strong) UIImage *questImage;
@property float locationLatitude;
@property float locationLongitude;
@property float questGiverLatitude;
@property float questGiverLongitude;

@end
