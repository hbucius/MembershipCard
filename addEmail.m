//
//  addEmail.m
//  MembershipCard
//
//  Created by hbucius on 7/20/14.
//  Copyright (c) 2014 com.hbu.com. All rights reserved.
//

#import "addEmail.h"
#import "Constants.h"

@interface addEmail ()
@property (weak, nonatomic) IBOutlet UITextField *emailText;
@property (weak, nonatomic) IBOutlet UIButton *nextStep;
@property (weak, nonatomic) IBOutlet UIButton *clearEmailText;
@end

@implementation addEmail

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
    [self initLoginButton];
    
}

-(void) viewDidAppear:(BOOL)animated {
    
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) initEmailText{
    
    [self showInitStateForEmailText];
    
}



-(void) initLoginButton{
    CALayer *layer=self.nextStep.layer;
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:2.5];
    [self.nextStep setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [self updateLoginButtonState];
}


- (IBAction)editEmail:(UITextField *)sender {
    [self beginToEditEmail];
}



- (IBAction)emailTextChanged:(UITextField *)sender {
    if ([self.emailText.text isEqualToString:@""] || [self.emailText.text isEqualToString:DefaultOnlyEmailText]) {
        self.clearEmailText.hidden=YES;
        self.clearEmailText.enabled=NO;
    }
    else {
        self.clearEmailText.hidden=NO;
        self.clearEmailText.enabled=YES;
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



- (IBAction)deleteEmailText:(UIButton *)sender {
    [self showInitStateForEmailText];
    [self beginToEditEmail];
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


-(void) showInitStateForEmailText{
    self.emailText.textColor=[UIColor lightGrayColor];
    self.emailText.text=DefaultOnlyEmailText;
    self.clearEmailText.hidden=YES;
    self.clearEmailText.enabled=NO;
}



-(void) updateLoginButtonState{
    if (![self.emailText.text isEqualToString:DefaultOnlyEmailText] &&![self.emailText.text isEqualToString:@""]){
        self.nextStep.enabled=YES;
        //    self.Login.alpha=1.0;
    }
    else {
        self.nextStep.enabled=NO;
        //    self.Login.alpha=0.4;
    }
    
}




@end
