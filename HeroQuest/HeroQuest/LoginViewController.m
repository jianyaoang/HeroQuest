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
    IBOutlet UIButton *loginButton;
    IBOutlet UITextField *usernameTextField;
    IBOutlet UITextField *passwordTextField;
}

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    usernameTextField.delegate = self;
    passwordTextField.delegate = self;
    [self.navigationController setNavigationBarHidden:YES];
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
                UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Login Error" message:@"Please cehck username and password field" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles: nil];
                [av show];
            }
        }];
    }
    [usernameTextField resignFirstResponder];
    [passwordTextField resignFirstResponder];
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
        qlvc.managedObjectContext = self.managedObjectContext;
        qlvc.navigationItem.title = @"Quest List";
    }
}




@end
