//
//  OneCardViewController.m
//  MembershipCard
//
//  Created by mstr on 4/29/14.
//  Copyright (c) 2014 com.hbu.com. All rights reserved.
//

#import "OneCardViewController.h"

@interface OneCardViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation OneCardViewController

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
    self.imageView.image=self.image;

    // Do any additional setup after loading the view.
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

-(void) setImage:(UIImage *)image{
    _image=image;
    self.imageView.image=image;
    NSLog(@"has been set IMage");
}

@end
