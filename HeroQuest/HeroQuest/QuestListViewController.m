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
#import <Parse/Parse.h>

@interface QuestListViewController () <UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView *questTableView;
    NSMutableArray *questNames;
    NSMutableArray *questGivers;
    NSMutableArray *quests;
    NSArray *filteredArray;
    IBOutlet UISegmentedControl *questMenuSegmentedControl;
}
@end

@implementation QuestListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    filteredArray = [NSArray new];
    quests = [NSMutableArray new];
    self.availableQuests = [NSMutableArray new];
    
    [self assigningQuestDetails];
    
    [self.availableQuests removeAllObjects];
    [self.availableQuests addObjectsFromArray:quests];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotificationEvil:) name:@"FilterArrayEvil" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotificationGood:) name:@"FilterArrayGood" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotificationNeutral:) name:@"FilterArrayNeutral" object:nil];
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:@"Redressed" size:15]};
    [questMenuSegmentedControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
}

-(void)handleNotificationEvil:(NSNotification*)notification
{
    NSPredicate *filterArray = [NSPredicate predicateWithFormat:@"%K = %@", @"alignment",@"EVIL"];
    NSLog(@"alignment : %@", [quests filteredArrayUsingPredicate:filterArray]);
    filteredArray = [quests filteredArrayUsingPredicate:filterArray];
    [questTableView reloadData];
}

-(void)handleNotificationGood:(NSNotification*)notification
{
    NSPredicate *filterArray = [NSPredicate predicateWithFormat:@"%K = %@", @"alignment",@"GOOD"];
    NSLog(@"alignment : %@", [quests filteredArrayUsingPredicate:filterArray]);
    filteredArray = [quests filteredArrayUsingPredicate:filterArray];
    [questTableView reloadData];
}

-(void)handleNotificationNeutral:(NSNotification*)notification
{
    NSPredicate *filterArray = [NSPredicate predicateWithFormat:@"%K = %@", @"alignment",@"NEUTRAL"];
    NSLog(@"alignment : %@", [quests filteredArrayUsingPredicate:filterArray]);
    filteredArray = [quests filteredArrayUsingPredicate:filterArray];
    [questTableView reloadData];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationItem.hidesBackButton = YES;
    [super viewWillAppear:animated];
}

-(void)assigningQuestDetails
{
    Quest *quest1 = [Quest new];
    quest1.questName = @"Bandits in the Woods";
    quest1.questGiver = @"HotDogg The Bounty Hunter";
    quest1.questDescription = @"The famed bounty hunter HotDog has requested the aid of a hero in ridding the woods of terrifying bandits who have thus far eluded his capture, as he is actually a dog, and cannot actually grab things more than 6 feet off the ground.";
    quest1.alignment = @"GOOD";
    quest1.questImage = [UIImage imageNamed:@"Bounty Hunter"];
    quest1.locationLatitude = 46.908588;
    quest1.locationLongitude = -96.808991;
    quest1.questGiverLatitude = 46.8541979;
    quest1.questGiverLongitude = -96.8285138;
    
    Quest *quest2 = [Quest new];
    quest2.questName = @"Special Delivery";
    quest2.questGiver = @"Sir Jimmy The Swift";
    quest2.questDescription = @"Sir Jimmy was once the fastest man in the kingdom, brave as any soldier and wise as a king. Unfortunately, age catches us all in the end, and he has requested that I, his personal scribe, find a hero to deliver a package of particular importance--and protect it with their life.";
    quest2.alignment = @"NEUTRAL";
    quest2.questImage = [UIImage imageNamed:@"cloudgate"];
    quest2.locationLatitude = 46.8657639;
    quest2.locationLongitude = -96.7363173;
    quest2.questGiverLatitude = 46.8739748;
    quest2.questGiverLongitude = -96.806112;
    
    Quest *quest3 = [Quest new];
    quest3.questName = @"Filthy Mongrel";
    quest3.questGiver = @"Prince Jack, The Iron Horse";
    quest3.questDescription = @"That strange dog that everyone is treating like a bounty-hunter must go. By the order of Prince Jack, that smelly, disease ridden mongrel must be removed from our streets by any means necessary. He is disrupting the lives of ordinary citizens, and it's just really weird. Make it gone.";
    quest3.alignment = @"EVIL";
    quest3.questImage = [UIImage imageNamed:@"cloudgate"];
    quest3.locationLatitude = 46.892386;
    quest3.locationLongitude = -96.799669;
    quest3.questGiverLatitude = 46.8739748;
    quest3.questGiverLongitude = -96.806112;
    
    quests = [NSMutableArray arrayWithObjects:quest1,quest2,quest3, nil];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([filteredArray count] == 0)
    {
        return quests.count;
    }
    else
    {
        return filteredArray.count;
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Quest *quest = [Quest new];
    
    if ([filteredArray count] == 0)
    {
        quest = [quests objectAtIndex:indexPath.row];
    }
    else
    {
        quest = [filteredArray objectAtIndex:indexPath.row];
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QuestListCellID"];
    
    cell.textLabel.font = [UIFont fontWithName:@"Redressed" size:15];
    cell.textLabel.text = quest.questName;
    
    cell.detailTextLabel.font = [UIFont fontWithName:@"Redressed" size:15];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Quest Giver: %@",quest.questGiver];
    
    cell.imageView.layer.backgroundColor = [[UIColor clearColor] CGColor];
    cell.imageView.layer.cornerRadius = 20.0;
    cell.imageView.layer.borderWidth = 2.0;
    cell.imageView.layer.masksToBounds = YES;
    cell.imageView.clipsToBounds = YES;
    cell.imageView.layer.borderColor = [[UIColor darkGrayColor]CGColor];
    
    cell.imageView.image = quest.questImage;
    
    return cell;
}

- (IBAction)onQuestMenuPressed:(UISegmentedControl*)sender
{
    if (sender.selectedSegmentIndex == 0)
    {
        [quests removeAllObjects];
        [quests addObjectsFromArray:self.availableQuests];
        
        [questTableView reloadData];
    }
    else if (sender.selectedSegmentIndex == 1)
    {
        [quests removeAllObjects];
        
        PFQuery *query = [PFQuery queryWithClassName:@"AcceptedQuest"];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
        {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
            
            if (!error)
            {
                NSLog(@"query done");
                for (PFObject *item in objects)
                {
                    Quest *quest = [Quest new];
                    PFFile *questImageFile = item[@"questImage"];
                    [questImageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error)
                    {
                        if (!error)
                        {
                            UIImage *questImage = [UIImage imageWithData:data];
                            quest.questImage = questImage;
                        }
                    }];
                    
                    quest.questName = [item objectForKey:@"questName"];
                    quest.questGiver = [item objectForKey:@"questGiver"];
                    quest.questDescription = [item objectForKey:@"questDescription"];
                    quest.locationLatitude = [[item objectForKey:@"locationLatitude"]floatValue];
                    quest.locationLongitude = [[item objectForKey:@"locationLongitude"]floatValue];
                    quest.questGiverLatitude = [[item objectForKey:@"questGiverLatitude"]floatValue];
                    quest.questGiverLongitude = [[item objectForKey:@"questGiverLongitude"]floatValue];
                    
                    [quests addObject:quest];
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [questTableView reloadData];
                });
            }
            else
            {
                NSLog(@"error: %@", [error userInfo]);
            }

            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        }];
        
    }
    else if (sender.selectedSegmentIndex == 2)
    {
        PFQuery *query = [PFQuery queryWithClassName:@"CompleteQuest"];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
        {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
            
            if (!error)
            {
                NSLog(@"complete objects successfully fetched");
                for (PFObject *item in objects)
                {
                    Quest *quest = [Quest new];
                    
                    PFFile *questImageFile = item[@"questImage"];
                    [questImageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error)
                    {
                        if (!error)
                        {
                            UIImage *questImage = [UIImage imageWithData:data];
                            quest.questImage = questImage;
                        }
                    }];
                    
                    quest.questName = [item objectForKey:@"questName"];
                    quest.questGiver = [item objectForKey:@"questGiver"];
                    quest.questDescription = [item objectForKey:@"questDescription"];
                    quest.locationLatitude = [[item objectForKey:@"locationLatitude"]floatValue];
                    quest.locationLongitude = [[item objectForKey:@"locationLongitude"]floatValue];
                    quest.questGiverLatitude = [[item objectForKey:@"questGiverLatitude"]floatValue];
                    quest.questGiverLongitude = [[item objectForKey:@"questGiverLongitude"]floatValue];
                    
                    [quests addObject:quest];
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [questTableView reloadData];
                });
            }
            else
            {
                NSLog(@"segmented index 2 (complete) error: %@", [error userInfo]);
            }
            
            [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:NO];
        }];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showQuestDetailViewController"])
    {
        NSIndexPath *indexPath = [questTableView indexPathForCell:sender];
        Quest *quest = [Quest new];
        
        if ([filteredArray count] == 0)
        {
            quest = [quests objectAtIndex:indexPath.row];
        }
        else
        {
            quest = [filteredArray objectAtIndex:indexPath.row];
        }
        
        QuestDetailViewController *dvc = segue.destinationViewController;
        dvc.quest = quest;
        dvc.navigationItem.title = quest.questName;
        dvc.qlvc = self;
        dvc.index = indexPath.row;

    }
    else if ([segue.identifier isEqualToString:@"showSettingsViewController"])
    {
        SettingsViewController *svc  = segue.destinationViewController;
        svc.navigationItem.title = @"Quest Settings";
    }
}




@end
