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

@property (weak, nonatomic) IBOutlet UITextField *emailText;

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
 
    
    self.emailText.textColor=[UIColor lightGrayColor];
    self.emailText.text=@"请输入邮箱 ";
     //email
    
    CGRect frame1=CGRectMake(13,77,287,46);
    UIView *view1=[[UIView alloc]initWithFrame:frame1];
    view1.backgroundColor=[UIColor clearColor];
    [self.view addSubview:view1];
    view1.layer.borderColor=[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0].CGColor;
    view1.layer.borderWidth=1.0f;
  
    CGRect frame2=CGRectMake(13,125,287,42);
    UIView *view2=[[UIView alloc]initWithFrame:frame2];
    view2.backgroundColor=[UIColor clearColor];
    [self.view addSubview:view2];
    
   
    view2.layer.borderColor=[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0].CGColor;
    view2.layer.borderWidth=1.0f;
}

-(void) viewDidAppear:(BOOL)animated {
  
    
    
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
- (IBAction)editEmail:(UITextField *)sender {
    sender.text=@" ";
    sender.textColor=[UIColor blackColor];
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
