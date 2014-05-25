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
#import "MembershipCardViewController2.h"
#import "MyPageViewController.h"
@interface OneCardViewController ()
@property (weak, nonatomic) IBOutlet UIView *CardView;
@property (strong,nonatomic) CardContent *cardContentsInfo;
@property (weak, nonatomic) IBOutlet UISwipeGestureRecognizer *swipeGesture;
@property (weak, nonatomic) IBOutlet UISwipeGestureRecognizer *swipeRight;

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
    [self.view bringSubviewToFront:self.CardView];
    self.CardView.backgroundColor=[UIColor yellowColor];
    self.BottomView.backgroundColor=[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    self.cardContents.backgroundColor=[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];

    [self initWithIndex:self.index];
    [self setLeftButtonItems];
    self.cardContents.dataSource=self ;
    
    
 }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewWillAppear:(BOOL)animated{
    [self.view addGestureRecognizer:self.swipeGesture];
    [self.view addGestureRecognizer:self.swipeRight];

    
}
-(void) viewWillDisappear:(BOOL)animated{
    
    [self.view removeGestureRecognizer:self.swipeGesture];
    [self.view removeGestureRecognizer:self.swipeRight];

 
}

#pragma mark init actions
-(void) setLeftButtonItems{
    
    UIBarButtonItem  *leftBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"❮会员卡"
                                                                           style:UIBarButtonItemStyleBordered
                                                                          target:self
                                                                          action:@selector(segueToPageViewController)];
    [leftBarButtonItem  setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Palatino-Roman"  size:16.0],NSForegroundColorAttributeName:[UIColor darkGrayColor],  NSBackgroundColorAttributeName:[UIColor clearColor]} forState:UIControlStateNormal];

    [self.navigationItem setLeftBarButtonItem:leftBarButtonItem];


}
-(void) setIndex:(NSInteger)index {
    _index=index;
  //  [self initWithIndex:_index];
    
}
-(void) initWithIndex:(NSInteger)index{
    NSLog(@"oneCardViewController ,the index is %ld",(long)index);
    Badge *badge=[[BadgeInfos shareInstance] badgeAtIndex:index];
    [self initCard:badge];
}

-(void) initCard :(Badge *) badgeInfo{
    self.CardView.backgroundColor=badgeInfo.badgeBackgroundColor;

    //cardName
    if([badgeInfo.cardNameLocation simpleLayout] ){
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
    if([badgeInfo.cardNumberlocation simpleLayout]){
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
    
    //cardContentGroup
    self.cardContentsInfo=badgeInfo.cardContent;
   // NSLog(@"badgeInfo.content.groupNumber=%d",[badgeInfo.cardContent count]);
    
}


#pragma mark swipe segue
- (IBAction)swipe:(UISwipeGestureRecognizer *)sender {
    NSLog(@"swipe begin");
    if(sender.direction==UISwipeGestureRecognizerDirectionLeft){
        NSLog(@"it is a left swipe!");
        [self showRightOneCardView];
    }
}
- (IBAction)swipeRight:(UISwipeGestureRecognizer *)sender {
    NSLog(@"swipe begin");
    if(sender.direction==UISwipeGestureRecognizerDirectionRight){
        NSLog(@"it is a right swipe!");
        [self showLeftOneCardView];
    }
}

-(void) showLeftOneCardView{
    [self showOneCardViewAtIndex:self.index-1 animated:YES];
}

-(void) showRightOneCardView{
    
    [self showOneCardViewAtIndex:self.index+1 animated:NO];
}

-(void) showOneCardViewAtIndex:(NSInteger)index animated:(BOOL) leftToRight{
    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    OneCardViewController *vc=[sb instantiateViewControllerWithIdentifier:@"oneCardViewController"];
    if(index>0 && index<[BadgeInfos shareInstance].badgesCount){
        vc.index=index;
    }
    else return;
    CATransition* transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade; //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
    transition.subtype = leftToRight? kCATransitionFromLeft : kCATransitionFromRight ; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
    [self.navigationController.view.layer addAnimation:transition
                                                forKey:kCATransition];
    [self.navigationController pushViewController:vc animated:NO];
    
}


-(void)segueToPageViewController {
    NSLog(@"segueToPageViewController happened");
    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MyPageViewController *mcvc2=[sb instantiateViewControllerWithIdentifier:@"MyPageViewController"];
    mcvc2.indexOnScreen=self.index/badgesCountInOnePage;
     CATransition* transition = [CATransition animation];
    transition.duration = 1.00;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionMoveIn; //kCATransitionMoveIn; //, kCATransitionPush, kCATransitionReveal, kCATransitionFade
    transition.subtype = kCATransitionFromLeft; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
    [self.navigationController.view.layer addAnimation:transition
                                                                forKey:kCATransition];
    
    [self.navigationController  pushViewController:mcvc2 animated:NO];
    
}


#pragma  mark TableView datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
     return self.cardContentsInfo.contentInGroup.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section<self.cardContentsInfo.contentInGroup.count){
        NSDictionary *dictionary=self.cardContentsInfo.contentInGroup[section];
        return dictionary.count;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableViewCell" forIndexPath:indexPath];
    NSInteger section=indexPath.section;
    NSInteger row=indexPath.row;
    NSArray *array=self.cardContentsInfo.contentInGroup[section];
    NSString *leftText=[(NSArray *)array[0] objectAtIndex:row];
    NSString *rightText=[(NSArray*)array[1] objectAtIndex:row];
    cell.textLabel.text=leftText ;
    cell.detailTextLabel.text=rightText;
    
    
    
    return cell;
}



@end
