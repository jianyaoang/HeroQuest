//
//  SignUpViewController.m
//  HeroQuest
//
//  Created by Jian Yao Ang on 5/18/14.
//  Copyright (c) 2014 Jian Yao Ang. All rights reserved.
//

#import "SignUpViewController.h"
#import <Parse/Parse.h>
#import "QuestListViewController.h"

@interface SignUpViewController () <UITextFieldDelegate>
{
    IBOutlet UITextField *nameTextField;
    IBOutlet UITextField *usernameTextField;
    IBOutlet UITextField *passwordTextField;
    IBOutlet UISegmentedControl *alignmentSegmentedControl;
    IBOutlet UIButton *signUpButton;
}

@end

@implementation SignUpViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    usernameTextField.delegate = self;
    passwordTextField.delegate = self;
    nameTextField.delegate     = self;
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName: [UIFont fontWithName:@"Redressed" size:20]};
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"Redressed" size:20]} forState:UIControlStateNormal];
    
    
    usernameTextField.font = [UIFont fontWithName:@"Redressed" size:20];
    passwordTextField.font = [UIFont fontWithName:@"Redressed" size:20];
    nameTextField.font = [UIFont fontWithName:@"Redressed" size:20];
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:@"Redressed" size:20]};
    
    [alignmentSegmentedControl setTitle:@"GOOD" forSegmentAtIndex:0];
    [alignmentSegmentedControl setTitle:@"NEUTRAL" forSegmentAtIndex:1];
    [alignmentSegmentedControl setTitle:@"EVIL" forSegmentAtIndex:2];
    [alignmentSegmentedControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
    signUpButton.titleLabel.font = [UIFont fontWithName:@"Redressed" size:20];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

- (IBAction)onSignUpButtonPressed:(UIButton*)sender
{
    NSString *username = [usernameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *password = [passwordTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *name = [nameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if (username.length == 0 || password.length == 0 || name.length == 0)
    {
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Sign Up Error" message:@"Please check username, password, and name field" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles: nil];
        [av show];
    }
    else
    {
        PFUser *newUser = [PFUser user];
        newUser.username = username;
        newUser.password = password;
        newUser[@"name"] = name;
        newUser[@"alignment"] = [alignmentSegmentedControl titleForSegmentAtIndex:alignmentSegmentedControl.selectedSegmentIndex];
        
        [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error)
            {
                [self performSegueWithIdentifier:@"showQuestListView" sender:sender];
            }
            else
            {
                UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Sign Up Error" message:@"Please check username, password, and name field" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles: nil];
                [av show];
            }
        }];
    }
    
    [nameTextField resignFirstResponder];
    [usernameTextField resignFirstResponder];
    [passwordTextField resignFirstResponder];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    usernameTextField.placeholder = @"";
    passwordTextField.placeholder = @"";
    nameTextField.placeholder = @"";
    passwordTextField.secureTextEntry = YES;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showQuestList"])
    {
        QuestListViewController *qlvc = segue.destinationViewController;
        qlvc.navigationItem.title = @"Quest List";
    }
}






@end
