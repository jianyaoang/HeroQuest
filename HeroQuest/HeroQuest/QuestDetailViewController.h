//
//  QuestDetailViewController.h
//  HeroQuest
//
//  Created by Jian Yao Ang on 5/10/14.
//  Copyright (c) 2014 Jian Yao Ang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Quest.h"

#import "QuestListViewController.h"

@interface QuestDetailViewController : UIViewController

@property (strong, nonatomic) Quest *quest;
@property CFIndex index;
@property QuestListViewController *qlvc;

@end
