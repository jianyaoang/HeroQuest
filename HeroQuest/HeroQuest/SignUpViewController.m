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
}

@end

@implementation SignUpViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view endEditing:YES];
    
    usernameTextField.delegate = self;
    passwordTextField.delegate = self;
    nameTextField.delegate     = self;

}

- (IBAction)onSignUpButtonPressed:(UIButton*)sender
{
    PFUser *user = [PFUser new];
    user.username = usernameTextField.text;
    user.password = passwordTextField.text;
    user[@"name"] = nameTextField.text;
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
    {
        if (!error)
        {
            [self performSegueWithIdentifier:@"showQuestListView" sender:sender];
        }
        else
        {
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Sign Up Error" message:@"Please check fields entered" delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
            [av show];
        }
    }];
    
    [nameTextField resignFirstResponder];
    [usernameTextField resignFirstResponder];
    [passwordTextField resignFirstResponder];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    usernameTextField.placeholder = @"";
    passwordTextField.placeholder = @"";
    passwordTextField.secureTextEntry = YES;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    QuestListViewController *qlvc = segue.destinationViewController;
    qlvc.navigationItem.title = @"Quest List";
}






@end
