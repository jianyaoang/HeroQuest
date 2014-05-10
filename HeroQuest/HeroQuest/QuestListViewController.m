//
//  QuestListViewController.m
//  HeroQuest
//
//  Created by Jian Yao Ang on 5/10/14.
//  Copyright (c) 2014 Jian Yao Ang. All rights reserved.
//

#import "QuestListViewController.h"

@interface QuestListViewController () <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *questNames;
    NSMutableArray *questGivers;
}
@end

@implementation QuestListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    questNames = [NSMutableArray new];
    questGivers = [NSMutableArray new];
    [self questName];
    [self questGiver];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.title = @"Quest List";
    [super viewWillAppear:animated];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return questNames.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QuestListCellID"];
    cell.textLabel.text = [questNames objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Quest Giver: %@",[questGivers objectAtIndex:indexPath.row]];
    return cell;
}

-(void)questName
{
    NSString *questName1 = @"Bandits in the Woods";
    NSString *questName2 = @"Special Delivery";
    NSString *questName3 = @"Filthy Mongrel";
    questNames = [NSMutableArray arrayWithObjects:questName1, questName2, questName3, nil];
}

-(void)questGiver
{
    NSString *questGiver1 = @"HotDogg The Bounty Hunter";
    NSString *questGiver2 = @"Sir Jimmy The Swift";
    NSString *questGiver3 = @"Prince Jack, The Iron Horse";
    questGivers = [NSMutableArray arrayWithObjects:questGiver1, questGiver2, questGiver3, nil];
}






@end
