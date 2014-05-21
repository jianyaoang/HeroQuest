//
//  QuestDetailViewController.m
//  HeroQuest
//
//  Created by Jian Yao Ang on 5/10/14.
//  Copyright (c) 2014 Jian Yao Ang. All rights reserved.
//

#import "QuestDetailViewController.h"
#import <MapKit/MapKit.h>
#import <Parse/Parse.h>

@interface QuestDetailViewController () <MKMapViewDelegate>
{
    IBOutlet UIBarButtonItem *questBarButtonItem;
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
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    questMapView.showsUserLocation = YES;
    
    CLLocationCoordinate2D centerCoordinate = CLLocationCoordinate2DMake(self.quest.QuestGiverLatitude, self.quest.QuestGiverLongitude);
    MKCoordinateSpan coordinateSpan = MKCoordinateSpanMake(0.09, 0.09);
    MKCoordinateRegion region = MKCoordinateRegionMake(centerCoordinate, coordinateSpan);
    questMapView.region = region;
    
    questGiverLocation = [MKPointAnnotation new];
    questGiverLocation.coordinate = centerCoordinate;
    questGiverLocation.title = self.quest.questGiver;
    [questMapView addAnnotation:questGiverLocation];
    

    CLGeocoder *geocoder = [CLGeocoder new];
    CLLocation *location = [[CLLocation alloc] initWithLatitude:self.quest.locationLatitude longitude:self.quest.locationLongitude];
    
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error)
    {
        if (error)
        {
            NSLog(@"Connection Error");
            
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Unexpected Error" message:@"Unable to detect location" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
            [av show];
        }
        
        for (CLPlacemark *place in placemarks)
        {
            MKPointAnnotation *annotation = [MKPointAnnotation new];
            annotation.coordinate = place.location.coordinate;
            annotation.title = self.quest.questName;
            [questMapView addAnnotation:annotation];
        }
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }];
}

- (IBAction)onAcceptBarButtonPressed:(UIBarButtonItem*)sender
{
    [sender setTitle:@"Complete"];
    
    PFObject *acceptedQuest = [PFObject objectWithClassName:@"AcceptedQuest"];
    acceptedQuest[@"questName"] = self.quest.questName;
    acceptedQuest[@"questGiver"] = self.quest.questGiver;
    acceptedQuest[@"questDescription"] = self.quest.questDescription;
    
    [acceptedQuest saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
    {
        if (error)
        {
            NSLog(@"saving error: %@", [error userInfo]);
        }
        else
        {
            NSLog(@"quest saved");
            [acceptedQuest saveInBackground];
        }
    }];
}





@end
