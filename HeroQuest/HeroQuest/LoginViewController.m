//
//  ViewController.m
//  HeroQuest
//
//  Created by Jian Yao Ang on 5/10/14.
//  Copyright (c) 2014 Jian Yao Ang. All rights reserved.
//

#import "LoginViewController.h"
#import "QuestListViewController.h"
#import <Parse/Parse.h>
@interface LoginViewController () <UITextFieldDelegate>
{
    IBOutlet UISwitch *rememberMeSwitch;
    IBOutlet UIButton *loginButton;
    IBOutlet UIButton *signUpButton;
    IBOutlet UIButton *FacebookSignUpButton;
    IBOutlet UITextField *usernameTextField;
    IBOutlet UITextField *passwordTextField;
}

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [PFFacebookUtils initializeFacebook];
    
    usernameTextField.font = [UIFont fontWithName:@"Redressed" size:20];
    passwordTextField.font = [UIFont fontWithName:@"Redressed" size:20];
    
    loginButton.titleLabel.font = [UIFont fontWithName:@"Redressed" size:20];
    signUpButton.titleLabel.font = [UIFont fontWithName:@"Redressed" size:20];
    FacebookSignUpButton.titleLabel.font = [UIFont fontWithName:@"Redressed" size:20];
    
    usernameTextField.delegate = self;
    passwordTextField.delegate = self;
    [self.navigationController setNavigationBarHidden:YES];
    
    if ([PFUser currentUser] || [PFFacebookUtils isLinkedWithUser:[PFUser currentUser]])
    {
        [self performSegueWithIdentifier:@"showQuestList" sender:self];
    }
}

- (IBAction)onLoginButtonPressed:(UIButton*)sender
{
    NSString *username = [usernameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSString *password = [passwordTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if (username.length == 0 || password.length == 0)
    {
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Login Error" message:@"Please check username and password field" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles: nil];
        [av show];
    }
    else
    {
        [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser *user, NSError *error)
        {
            if (!error)
            {
                [self performSegueWithIdentifier:@"showQuestList" sender:sender];
            }
            else
            {
                UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Login Error" message:@"Please check username and password field" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles: nil];
                [av show];
            }
        }];
    }
    [usernameTextField resignFirstResponder];
    [passwordTextField resignFirstResponder];
}

//- (IBAction)onRememberMeSwitchSlide:(id)sender
//{
//
//}

- (IBAction)onFacebookSignUpButtonPressed:(id)sender
{
    NSArray *permissionArray = @[@"user_about_me",@"user_relationships", @"user_birthday", @"user_location"];
    
    [PFFacebookUtils logInWithPermissions:permissionArray block:^(PFUser *user, NSError *error) {
        
        if (!user)
        {
            if (!error)
            {
                NSLog(@"The user cancelled FB login");
            }
            else
            {
                NSLog(@"An error has occured: %@", error);
            }
        }
        else if (user.isNew)
        {
            NSLog(@"User with facebook signed up and logged in!");
            [self performSegueWithIdentifier:@"showQuestList" sender:sender];
        }
        else
        {
            NSLog(@"User with facebook logged in!");
            [self performSegueWithIdentifier:@"showQuestList" sender:sender];
        }
    }];
}

- (IBAction)onSignUpButtonPressed:(UIButton*)sender
{
    [self performSegueWithIdentifier:@"showSignUpView" sender:sender];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    usernameTextField.placeholder = @"";
    passwordTextField.placeholder = @"";
    passwordTextField.secureTextEntry = YES;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    
    if ([identifier isEqualToString:@"showQuestList"])
    {
        BOOL segueShouldOccur = YES;
        
        if (!segueShouldOccur)
        {
            UIAlertView *preventSegue = [[UIAlertView alloc] initWithTitle:@"Login Error" message:@"Please check username and password" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
            
            [preventSegue show];
            
            return NO;
        }
    }
    return YES;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showQuestList"])
    {
        QuestListViewController *qlvc = segue.destinationViewController;
//        qlvc.managedObjectContext = self.managedObjectContext;
        qlvc.navigationItem.title = @"Quest List";
    }
}




@end
