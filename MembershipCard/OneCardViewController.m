//
//  OneCardViewController.m
//  MembershipCard
//
//  Created by mstr on 4/29/14.
//  Copyright (c) 2014 com.hbu.com. All rights reserved.
//

#import "OneCardViewController.h"
#import "BadgeInfo.h"
#import "BadgeInfos.h"
@interface OneCardViewController ()
@property (weak, nonatomic) IBOutlet UIView *CardView;

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
    self.CardView.backgroundColor=[UIColor yellowColor];
    [self initWithIndex:self.index];
    
    
     // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




-(void) setIndex:(NSInteger)index {
    _index=index;
  //  [self initWithIndex:_index];
    
}
-(void) initWithIndex:(NSInteger)index{
    NSLog(@"oneCardViewController ,the index is %d",index);
    BadgeInfo *badgeInfo=[[BadgeInfos shareInstance] badgeAtIndex:index];
    [self initCard:badgeInfo];
}

-(void) initCard :(BadgeInfo *) badgeInfo{
    self.CardView.backgroundColor=badgeInfo.badgeBackgroundColor;

    //cardName
    if(badgeInfo.cardNameLocation.simpleLayout ){
        NSMutableParagraphStyle *paragraphCardName=[[NSMutableParagraphStyle alloc]init];
        if([badgeInfo.cardNameLocation isEqual:@"left"]){
            paragraphCardName.alignment=NSTextAlignmentLeft;
        }
        else if([badgeInfo.cardNameLocation isEqual:@"right"]){
            paragraphCardName.alignment=NSTextAlignmentRight;
        }
        else paragraphCardName.alignment=NSTextAlignmentLeft;  //default alignment
        self.cardName.attributedText=[[NSAttributedString alloc]initWithString:badgeInfo.cardName attributes:@{NSParagraphStyleAttributeName: paragraphCardName ,
                                                                                                               NSForegroundColorAttributeName:[UIColor whiteColor]  //cardName color
                                                                                                               }];
        
    }
    else {    }  // not simple layout
    
    //cardNumber
    if(badgeInfo.cardNumberlocation.simpleLayout ){
        NSMutableParagraphStyle *paragraphCardumber=[[NSMutableParagraphStyle alloc]init];
        if([badgeInfo.cardNumberlocation isEqual:@"left"]){
            paragraphCardumber.alignment=NSTextAlignmentLeft;
        }
        else if([badgeInfo.cardNumberlocation isEqual:@"right"]){
            paragraphCardumber.alignment=NSTextAlignmentRight;
        }
        else paragraphCardumber.alignment=NSTextAlignmentRight;  //default alignment
        self.cardNumber.attributedText=[[NSAttributedString alloc]initWithString:badgeInfo.cardNumber attributes:@{NSParagraphStyleAttributeName: paragraphCardumber,
                                                                                                                   NSForegroundColorAttributeName:[UIColor whiteColor]}];
    }
    else {    }  // not simple layout
    
    //cardBackgroundImage
    self.cardBackgroundImage.image=[UIImage imageNamed:badgeInfo.badgeImage];
    
    
    
    
}
@end
