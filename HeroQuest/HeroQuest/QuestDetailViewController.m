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
    IBOutlet UIImageView *questImage;
    IBOutlet UIBarButtonItem *questBarButtonItem;
    IBOutlet MKMapView *questMapView;
    IBOutlet UITextView *questDescription;
    IBOutlet UILabel *questName;
    IBOutlet UILabel *questGiver;
    IBOutlet UIBarButtonItem *questAcceptAndCompleteBarButton;
    MKPointAnnotation *questGiverLocation;
}
@end

@implementation QuestDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    questName.text = [NSString stringWithFormat:@"Quest Name: %@",self.quest.questName];
    questName.numberOfLines = 0;
    questName.font = [UIFont fontWithName:@"Redressed" size:15];

    questImage.layer.cornerRadius = questImage.frame.size.width/2;
    questImage.layer.borderWidth = 2.0;
    questImage.layer.borderColor = [[UIColor darkGrayColor]CGColor];
    questImage.layer.masksToBounds = YES;
    questImage.clipsToBounds = YES;
    questImage.image = self.quest.questImage;
    
    questGiver.text = [NSString stringWithFormat:@"Quest Giver: %@",self.quest.questGiver];
    questGiver.numberOfLines = 0;
    questGiver.font = [UIFont fontWithName:@"Redressed" size:15];
    
    questDescription.text = self.quest.questDescription;
    questDescription.font = [UIFont fontWithName:@"Redressed" size:15];
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:@"Redressed" size:20]};
    [questAcceptAndCompleteBarButton setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
    [[UIBarButtonItem appearance] setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
    [self displayingQuestLocationAndQuestGiverOnMap];
}

-(void)displayingQuestLocationAndQuestGiverOnMap
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    questMapView.showsUserLocation = YES;
    
    CLLocationCoordinate2D centerCoordinate = CLLocationCoordinate2DMake(self.quest.questGiverLatitude, self.quest.questGiverLongitude);
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

-(MKAnnotationView*)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if (annotation != questGiverLocation)
    {
        return nil;
    }
    
    MKPinAnnotationView *pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:nil];

    pin.enabled = YES;
    pin.image = self.quest.questImage;
    pin.canShowCallout = YES;
    return pin;
}

- (IBAction)onAcceptBarButtonPressed:(UIBarButtonItem*)sender
{
    
    if ([sender.title isEqualToString:@"Accept"])
    {
        [sender setTitle:@"Complete"];
        
        NSData *imageData = UIImagePNGRepresentation(self.quest.questImage);
        PFFile *questImageFile = [PFFile fileWithName:@"questImageFiled" data:imageData];
        
        PFObject *acceptedQuest = [PFObject objectWithClassName:@"AcceptedQuest"];
        acceptedQuest[@"questName"] = self.quest.questName;
        acceptedQuest[@"questGiver"] = self.quest.questGiver;
        acceptedQuest[@"questDescription"] = self.quest.questDescription;
        acceptedQuest[@"locationLatitude"] = [NSNumber numberWithFloat:self.quest.locationLatitude];
        acceptedQuest[@"locationLongitude"] = [NSNumber numberWithFloat:self.quest.locationLongitude];
        acceptedQuest[@"questGiverLatitude"] = [NSNumber numberWithFloat:self.quest.questGiverLatitude];
        acceptedQuest[@"questGiverLongitude"] = [NSNumber numberWithFloat:self.quest.questGiverLongitude];
        acceptedQuest[@"questImage"] = questImageFile;
        
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
        
        [self.qlvc.availableQuests removeObjectAtIndex:self.index];
    }
    else if ([sender.title isEqualToString:@"Complete"])
    {
        NSData *imageData = UIImagePNGRepresentation(self.quest.questImage);
        PFFile *questImageFile = [PFFile fileWithName:@"questImageFiled" data:imageData];
        
        PFObject *completeQuest = [PFObject objectWithClassName:@"CompleteQuest"];
        completeQuest[@"questName"] = self.quest.questName;
        completeQuest[@"questGiver"] = self.quest.questGiver;
        completeQuest[@"questDescription"] = self.quest.questDescription;
        completeQuest[@"locationLatitude"] = [NSNumber numberWithFloat:self.quest.locationLatitude];
        completeQuest[@"locationLongitude"] = [NSNumber numberWithFloat:self.quest.locationLongitude];
        completeQuest[@"questGiverLatitude"] = [NSNumber numberWithFloat:self.quest.questGiverLatitude];
        completeQuest[@"questGiverLongitude"] = [NSNumber numberWithFloat:self.quest.questGiverLongitude];
        completeQuest[@"questImage"] = questImageFile;
        
        [completeQuest saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
        {
            if (error)
            {
                NSLog(@"Complete Quest saving error: %@", [error userInfo]);
            }
            else
            {
                NSLog(@"completeQuest succesfully saved");
                [completeQuest saveInBackground];
            }
        }];
    }
}





@end
