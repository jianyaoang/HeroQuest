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
    PFUser *user = [PFUser new];
    user.username = usernameTextField.text;
    user.password = passwordTextField.text;
    
    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
    {
        if (!error)
        {
            [self performSegueWithIdentifier:@"showQuestList" sender:sender];
        }
        else
        {
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Login Error" message:@"Please check username and password" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
            [av show];
        }
    }];
//    if ([usernameTextField.text isEqualToString:@"Lancelot"] && [passwordTextField.text isEqualToString:@"arthurDoesntKnow"])
//    {
//        [self performSegueWithIdentifier:@"showQuestList" sender:sender];
//    }
//    else
//    {
//        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Login Error" message:@"Please check username and password" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
//        [av show];
//    }
    [usernameTextField resignFirstResponder];
    [passwordTextField resignFirstResponder];
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
