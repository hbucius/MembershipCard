//
//  LoginViewController.m
//  MembershipCard
//
//  Created by mstr on 5/28/14.
//  Copyright (c) 2014 com.hbu.com. All rights reserved.
//

#import "LoginViewController.h"
#import "CustomSegue.h"
#import "Constants.h"
 @interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *passwordText;

@property (weak, nonatomic) IBOutlet UITextField *emailText;
@property (weak, nonatomic) IBOutlet UIButton *Login;
@property (weak, nonatomic) IBOutlet UIButton *clearEmailText;
@property (weak, nonatomic) IBOutlet UIButton *clearPasswordText;
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
    [self initEmailText];
    [self initPasswordText];
    [self initBounds];
    [self initLoginButton];
    
}

-(void) viewDidAppear:(BOOL)animated {
  
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) initBounds{
    
    CGRect frame=CGRectMake(13,80,287,88);
    UIView *view=[[UIView alloc]initWithFrame:frame];
    view.backgroundColor=[UIColor clearColor];
    [self.view insertSubview:view belowSubview:self.passwordText];
    view.layer.borderColor=[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0].CGColor;
    view.layer.borderWidth=1.0f;
    [view.layer setMasksToBounds:YES];
    [view.layer setCornerRadius:3.5];
    // the line in the middle
    CGRect frame1=CGRectMake(13,124,287,1);
    UIView *view1=[[UIView alloc]initWithFrame:frame1];
    [view1.layer setBackgroundColor:[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1].CGColor];
    [self.view insertSubview:view1 belowSubview:self.passwordText];

 }

-(void) initEmailText{
    
    [self showInitStateForEmailText];

}

-(void) initPasswordText{
    [self showInitStateForPasswordText];
}

-(void) initLoginButton{
    CALayer *layer=self.Login.layer;
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:2.5];
    [self.Login setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [self updateLoginButtonState];
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
    [self beginToEditEmail];
}

- (IBAction)editPassword:(UITextField *)sender {    [self beginToEditPassword];

}

- (IBAction)emailTextChanged:(UITextField *)sender {
    if ([self.emailText.text isEqualToString:@""] || [self.emailText.text isEqualToString:DefaultEmailText]) {
        self.clearEmailText.hidden=YES;
        self.clearEmailText.enabled=NO;
    }
    else {
        self.clearEmailText.hidden=NO;
        self.clearEmailText.enabled=YES;
  }
    [self updateLoginButtonState];
}


- (IBAction)passwordTextChanged:(UITextField *)sender {
    if ([self.passwordText.text isEqualToString:@""] || [self.passwordText.text isEqualToString:DefaultPasswordText]) {
        self.clearPasswordText.hidden=YES;
        self.clearPasswordText.enabled=NO;
    }
    else {
        self.clearPasswordText.hidden=NO;
        self.clearPasswordText.enabled=YES;
    }
    [self updateLoginButtonState];
}

- (IBAction)EmailTextEnd:(UITextField *)sender {
    if ([self.emailText.text isEqualToString:@""]) {
        [self showInitStateForEmailText];
    }
    self.clearEmailText.hidden=YES;
    self.clearEmailText.enabled=NO;
}

- (IBAction)passwordTextEnd:(UITextField *)sender {
    if ([self.passwordText.text isEqualToString:@""]) {
        [self showInitStateForPasswordText];
    }
    self.clearPasswordText.hidden=YES;
    self.clearPasswordText.enabled=NO;
}

- (IBAction)deleteEmailText:(UIButton *)sender {
    [self showInitStateForEmailText];
    [self beginToEditEmail];
    [self updateLoginButtonState];
}


- (IBAction)deletePaswordText:(UIButton *)sender {
    [self showInitStateForPasswordText];
    [self beginToEditPassword];
    [self updateLoginButtonState];

}


-(void) beginToEditEmail{
    if([self.emailText.text isEqualToString:DefaultEmailText]){
        self.emailText.text=@"";
        self.emailText.defaultTextAttributes=@{NSForegroundColorAttributeName: [UIColor blackColor]};
        [self.emailText setTintColor:[UIColor colorWithRed:0 green:0 blue:1.0 alpha:0.7]];
    }
    else if (![self.emailText.text isEqualToString:@""]){
        self.clearEmailText.hidden=NO;
        self.clearEmailText.enabled=YES;
    }
}
-(void) beginToEditPassword{
    if([self.passwordText.text isEqualToString:DefaultPasswordText]){
        self.passwordText.text=@"";
        [self.passwordText setTintColor:[UIColor colorWithRed:0 green:0 blue:1.0 alpha:0.7]];
        self.passwordText.defaultTextAttributes=@{NSForegroundColorAttributeName: [UIColor blackColor]};
    }
    else if (![self.passwordText.text isEqualToString:@""]){
        self.clearPasswordText.hidden=NO;
        self.clearPasswordText.enabled=YES;
    }
}
-(void) showInitStateForEmailText{
    self.emailText.textColor=[UIColor lightGrayColor];
    self.emailText.text=DefaultEmailText;
    self.clearEmailText.hidden=YES;
    self.clearEmailText.enabled=NO;
}

-(void) showInitStateForPasswordText{
    self.passwordText.textColor=[UIColor lightGrayColor];
    self.passwordText.text=DefaultPasswordText;
    self.clearPasswordText.hidden=YES;
    self.clearPasswordText.enabled=NO;
}

-(void) updateLoginButtonState{
    if (![self.emailText.text isEqualToString:DefaultEmailText] &&![self.emailText.text isEqualToString:@""] && ![self.passwordText.text isEqual:DefaultPasswordText] && ![self.passwordText.text isEqualToString:@""]){
        self.Login.enabled=YES;
    //    self.Login.alpha=1.0;
     }
    else {
        self.Login.enabled=NO;
   //    self.Login.alpha=0.4;
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
