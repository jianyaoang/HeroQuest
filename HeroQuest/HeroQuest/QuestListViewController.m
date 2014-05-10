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
#import "SettingsViewController.h"
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
    quest1.questDescription = @"The famed bounty hunter HotDog has requested the aid of a hero in ridding the woods of terrifying bandits who have thus far eluded his capture, as he is actually a dog, and cannot actually grab things more than 6 feet off the ground.";
    
    Quest *quest2 = [Quest new];
    quest2.questName = @"Special Delivery";
    quest2.questGiver = @"Sir Jimmy The Swift";
    quest2.questDescription = @"Sir Jimmy was once the fastest man in the kingdom, brave as any soldier and wise as a king. Unfortunately, age catches us all in the end, and he has requested that I, his personal scribe, find a hero to deliver a package of particular importance--and protect it with their life.";
    
    Quest *quest3 = [Quest new];
    quest3.questName = @"Filthy Mongrel";
    quest3.questGiver = @"Prince Jack, The Iron Horse";
    quest3.questDescription = @"That strange dog that everyone is treating like a bounty-hunter must go. By the order of Prince Jack, that smelly, disease ridden mongrel must be removed from our streets by any means necessary. He is disrupting the lives of ordinary citizens, and it's just really weird. Make it gone.";
    
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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showQuestDetailViewController"])
    {
        NSIndexPath *indexPath = [questTableView indexPathForCell:sender];
        Quest *quest = [quests objectAtIndex:indexPath.row];
        
        QuestDetailViewController *dvc = segue.destinationViewController;
        dvc.quest = quest;
        dvc.navigationItem.title = quest.questName;
    }
    else if ([segue.identifier isEqualToString:@"showSettingsViewController"])
    {
        SettingsViewController *svc  = segue.destinationViewController;
        svc.navigationItem.title = @"Settings";
    }
    
}




@end
