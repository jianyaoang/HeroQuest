//
//  QuestDetailViewController.m
//  HeroQuest
//
//  Created by Jian Yao Ang on 5/10/14.
//  Copyright (c) 2014 Jian Yao Ang. All rights reserved.
//

#import "QuestDetailViewController.h"
#import <MapKit/MapKit.h>

@interface QuestDetailViewController () <MKMapViewDelegate>
{
    IBOutlet MKMapView *questMapView;
    IBOutlet UITextView *questDescription;
    IBOutlet UILabel *questName;
    IBOutlet UILabel *questGiver;
    MKPointAnnotation *questGiverLocation;
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
    
    [self displayingQuestLocationAndQuestGiverOnMap];
}

-(void)displayingQuestLocationAndQuestGiverOnMap
{
    questMapView.showsUserLocation = YES;
    
    CLLocationCoordinate2D centerCoordinate = CLLocationCoordinate2DMake(self.quest.QuestGiverLatitude, self.quest.QuestGiverLongitude);
    MKCoordinateSpan coordinateSpan = MKCoordinateSpanMake(0.01, 0.01);
    MKCoordinateRegion region = MKCoordinateRegionMake(centerCoordinate, coordinateSpan);
    questMapView.region = region;
    
    questGiverLocation = [MKPointAnnotation new];
    questGiverLocation.coordinate = centerCoordinate;
    questGiverLocation.title = self.quest.questGiver;
    [questMapView addAnnotation:questGiverLocation];
}





@end
