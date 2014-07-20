//
//  VerifyCode.m
//  MembershipCard
//
//  Created by hbucius on 7/20/14.
//  Copyright (c) 2014 com.hbu.com. All rights reserved.
//

#import "VerifyCode.h"

@interface VerifyCode ()

@property (weak, nonatomic) IBOutlet UITextField *codeText;
@property (weak, nonatomic) IBOutlet UIButton *nextStep;

@end

@implementation VerifyCode

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
    [self initLoginButton];
    
}

-(void) viewDidAppear:(BOOL)animated {
    
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






-(void) initLoginButton{
    CALayer *layer=self.nextStep.layer;
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:2.5];
    [self.nextStep setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [self updateLoginButtonState];
}







- (IBAction)codeTextChanged:(UITextField *)sender {
    if ([self.codeText.text isEqualToString:@""] ) {
      
    }
    [self updateLoginButtonState];
}





-(void) updateLoginButtonState{
    if (![self.codeText.text isEqualToString:@""]){
        self.nextStep.enabled=YES;
        //    self.Login.alpha=1.0;
    }
    else {
        self.nextStep.enabled=NO;
        //    self.Login.alpha=0.4;
    }
    
}



@end
