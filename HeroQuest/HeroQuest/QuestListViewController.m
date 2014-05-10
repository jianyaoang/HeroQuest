//
//  QuestListViewController.m
//  HeroQuest
//
//  Created by Jian Yao Ang on 5/10/14.
//  Copyright (c) 2014 Jian Yao Ang. All rights reserved.
//

#import "QuestListViewController.h"

@interface QuestListViewController ()

@end

@implementation QuestListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.title = @"Quest List";
    [super viewWillAppear:animated];
}




@end
