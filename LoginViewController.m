//
//  LoginViewController.m
//  MembershipCard
//
//  Created by mstr on 5/28/14.
//  Copyright (c) 2014 com.hbu.com. All rights reserved.
//

#import "LoginViewController.h"
#import "CustomSegue.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"segueBackToStartPageFromLoginPage"] ) {
        if([segue isKindOfClass:[CustomSegue class]]){
            CustomSegue *cSegue=(CustomSegue *) segue ;
            cSegue.direction=@"LEFTTORIGHT";
        }
        
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
