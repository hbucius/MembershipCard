//
//  MembershipCardViewController.m
//  MembershipCard
//
//  Created by mstr on 4/28/14.
//  Copyright (c) 2014 com.hbu.com. All rights reserved.
//

#import "MembershipCardViewController.h"
#import "Cell.h"
#import "OneCardViewController.h"
#import "BadgeInfo.h"
#import "BadgeInfos.h"
#import "Constants.h"
@interface MembershipCardViewController ()
@property(nonatomic,weak) BadgeInfos *badgeInfos;
@end


NSString *kCellId=@"cellID";
NSString *kDetailViewControllerID=@"OneCardView";


@implementation MembershipCardViewController

 #pragma mark lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [[self collectionView]setBackgroundColor:[UIColor   whiteColor]];
 }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark properties

-(void) setIndex:(int)index{
    _index=index;
    
    //set the special according the index ; need to be done here       
}

-(BadgeInfos *) badgeInfos{
    NSLog(@"getBadgeInfos has been called");
    if(_badgeInfos==nil)
        _badgeInfos=[BadgeInfos shareInstance];
    return _badgeInfos;
}


#pragma mark collectionView delegate

-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return badgesCountInOnePage;
}

-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    Cell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:kCellId forIndexPath:indexPath];
    BadgeInfo *badge=[self.badgeInfos badgeAtIndex:(indexPath.row+self.index*badgesCountInOnePage)];
    cell.CellLabel.text=badge.badgeName;
    cell.backgroundColor=badge.badgeBackgroundColor;
    NSLog(@"badgeName is %@",badge.badgeName);
 
    
    //  cell.CellLabel.text=[NSString stringWithFormat:@"%d.jpg",indexPath.row];
   // NSString *imageToLoad=[NSString stringWithFormat:@"%d.jpg",indexPath.row];
 //   cell.CellImage.image=[UIImage imageNamed:imageToLoad];
    return cell;
}



#pragma mark PageView delegate


-(MembershipCardViewController *) MembershipCardViewControllerForPageIndex{
  
    return self;
    
}


-(MembershipCardViewController *) initWithPageIndex:(NSInteger)index{
    return self;
    
}





#pragma mark Segue to OneCard

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    NSLog(@"I am out for segue");

    if([[segue identifier] isEqualToString:@"showOneCard"]){
        if([[segue destinationViewController] isKindOfClass:[OneCardViewController class]]){
            //set the image
            NSLog(@"I am in prepair for segue");
            OneCardViewController *oneCardController=segue.destinationViewController;
            NSIndexPath *selectedIndexPath = [[self.collectionView indexPathsForSelectedItems] objectAtIndex:0];
            NSString *imageToLoad=[NSString stringWithFormat:@"%d_full",selectedIndexPath.row];
            NSString *imagePath=[[NSBundle mainBundle]pathForResource:imageToLoad ofType:@"JPG"];
            oneCardController.image=[[UIImage alloc] initWithContentsOfFile:imagePath];        }
    }
}


@end
