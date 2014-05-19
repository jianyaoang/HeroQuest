//
//  SettingsViewController.h
//  HeroQuest
//
//  Created by Jian Yao Ang on 5/10/14.
//  Copyright (c) 2014 Jian Yao Ang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Quest.h"

@interface SettingsViewController : UIViewController //<NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) Quest *quest;

//@property NSManagedObjectContext *managedObjectContext;
//@property NSFetchedResultsController *fetchedResultsController;

@end
