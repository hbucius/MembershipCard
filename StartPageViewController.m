//
//  StartPageViewController.m
//  MembershipCard
//
//  Created by mstr on 5/27/14.
//  Copyright (c) 2014 com.hbu.com. All rights reserved.
//

#import "StartPageViewController.h"
#import "CustomSegue.h"
@interface StartPageViewController ()

@end

@implementation StartPageViewController

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
    [[UIColor blackColor] setStroke];
    [[UIColor blackColor] setFill];
    
 
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (IBAction)addCard:(UIButton *)sender forEvent:(UIEvent *)event {
    
}

- (IBAction)login:(UIButton *)sender forEvent:(UIEvent *)event {
}


-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"segueToAddCardAtStartPage"] ) {
        if([segue isKindOfClass:[CustomSegue class]]){
            CustomSegue *cSegue=(CustomSegue *) segue ;
            cSegue.direction=@"RIGHTTOLEFT";
        }
        
    }
    else if([segue.identifier isEqualToString:@"segueToLoginPage"] ) {
        if([segue isKindOfClass:[CustomSegue class]]){
            CustomSegue *cSegue=(CustomSegue *) segue ;
            cSegue.direction=@"RIGHTTOLEFT";
        }
        
    }

    
}
@end
