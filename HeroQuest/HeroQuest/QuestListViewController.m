//
//  QuestListViewController.m
//  HeroQuest
//
//  Created by Jian Yao Ang on 5/10/14.
//  Copyright (c) 2014 Jian Yao Ang. All rights reserved.
//

#import "QuestListViewController.h"
#import "QuestDetailViewController.h"
#import "Quest.h"

@interface QuestListViewController () <UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView *questTableView;
    NSMutableArray *questNames;
    NSMutableArray *questGivers;
    NSMutableArray *quests;
}
@end

@implementation QuestListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    quests = [NSMutableArray new];
//    questNames = [NSMutableArray new];
//    questGivers = [NSMutableArray new];
//    [self questName];
//    [self questGiver];
    [self assigningQuestDetails];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.title = @"Quest List";
    [super viewWillAppear:animated];
}

-(void)assigningQuestDetails
{
    Quest *quest1 = [Quest new];
    quest1.questName = @"Bandits in the Woods";
    quest1.questGiver = @"HotDogg The Bounty Hunter";
    
    Quest *quest2 = [Quest new];
    quest2.questName = @"Special Delivery";
    quest2.questGiver = @"Sir Jimmy The Swift";
    
    Quest *quest3 = [Quest new];
    quest3.questName = @"Filthy Mongrel";
    quest3.questGiver = @"Prince Jack, The Iron Horse";
    
    quests = [NSMutableArray arrayWithObjects:quest1,quest2,quest3, nil];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return quests.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Quest *quest = [quests objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QuestListCellID"];
    cell.textLabel.text = quest.questName;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Quest Giver: %@",quest.questGiver];
    return cell;
}

//
//-(void)questName
//{
//    NSString *questName1 = @"Bandits in the Woods";
//    NSString *questName2 = @"Special Delivery";
//    NSString *questName3 = @"Filthy Mongrel";
//    questNames = [NSMutableArray arrayWithObjects:questName1, questName2, questName3, nil];
//}
//
//-(void)questGiver
//{
//    NSString *questGiver1 = @"HotDogg The Bounty Hunter";
//    NSString *questGiver2 = @"Sir Jimmy The Swift";
//    NSString *questGiver3 = @"Prince Jack, The Iron Horse";
//    questGivers = [NSMutableArray arrayWithObjects:questGiver1, questGiver2, questGiver3, nil];
//}
//
//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if ([segue.identifier isEqualToString:@"showQuestDetailViewController"])
//    {
//        QuestDetailViewController *dvc = segue.destinationViewController;
//        NSIndexPath *indexPath = [questTableView indexPathForSelectedRow];
//        dvc.questName.text = [questNames objectAtIndex:indexPath.row];
//        dvc.questGiver.text = [questGivers objectAtIndex:indexPath.row];
//    }
//}




@end
