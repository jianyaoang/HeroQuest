//
//  QuestDetailViewController.m
//  HeroQuest
//
//  Created by Jian Yao Ang on 5/10/14.
//  Copyright (c) 2014 Jian Yao Ang. All rights reserved.
//

#import "QuestDetailViewController.h"

@interface QuestDetailViewController ()
{
    IBOutlet UITextView *questDescription;
    IBOutlet UILabel *questName;
    IBOutlet UILabel *questGiver;
}
@end

@implementation QuestDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    questName.text = [NSString stringWithFormat:@"Quest Name: %@",self.quest.questName];
    
    questGiver.text = [NSString stringWithFormat:@"Quest Giver: %@",self.quest.questGiver];
    questGiver.numberOfLines = 0;
    
    questDescription.text = self.quest.questDescription;
}





@end
