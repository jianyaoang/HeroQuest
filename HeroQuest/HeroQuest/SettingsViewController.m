//
//  SettingsViewController.m
//  HeroQuest
//
//  Created by Jian Yao Ang on 5/10/14.
//  Copyright (c) 2014 Jian Yao Ang. All rights reserved.
//

#import "SettingsViewController.h"
//#import "Quests.h"

@interface SettingsViewController ()
{
    IBOutlet UISegmentedControl *questSegmentedControl;
}

@end

@implementation SettingsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (IBAction)onQuestSegmentedControlPressed:(id)sender
{
    if (questSegmentedControl.selectedSegmentIndex  == 0) //Good
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"FilterArray" object:self];
    }
    else if (questSegmentedControl.selectedSegmentIndex == 1) //Neutral
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"FilterArray" object:self];
    }
    else if (questSegmentedControl.selectedSegmentIndex == 2) //Evil
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"FilterArray" object:self];
    }
}



@end
