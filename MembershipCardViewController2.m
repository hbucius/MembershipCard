//
//  MembershipCardViewController2.m
//  MembershipCard
//
//  Created by mstr on 5/6/14.
//  Copyright (c) 2014 com.hbu.com. All rights reserved.
//

#import "MembershipCardViewController2.h"
#import "Cell.h"
#import "OneCardViewController.h"
#import "BadgeInfo.h"
#import "BadgeInfos.h"
#import "Constants.h"
@interface MembershipCardViewController2 ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property(nonatomic,weak) BadgeInfos *badgeInfos;
@end

NSString *kCellId=@"cellID";
NSString *kDetailViewControllerID=@"OneCardView";


@implementation MembershipCardViewController2

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
    [self.collectionView setDelegate:self];
    [self.collectionView setDataSource:self];
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
    NSLog(@"index become %d in collection",_index);
    //set the special according the index ; need to be done here
}

-(BadgeInfos *) badgeInfos{
//    NSLog(@"getBadgeInfos has been called");
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
    NSLog(@"cellForItemAtIndexPath :index=%d",self.index);
    BadgeInfo *badge=[self.badgeInfos badgeAtIndex:(indexPath.row+self.index*badgesCountInOnePage)];
    if(badge!=nil){
        cell.CellLabel.text=badge.badgeName;
        [cell.CellImage setBackgroundImage:[UIImage imageNamed:badge.badgeThumbImage] forState:UIControlStateNormal];
    }
    else {
        cell.CellImage.hidden=YES;
        cell.CellLabel.hidden=YES;
    }
    return cell;
}



#pragma mark PageView delegate


-(MembershipCardViewController2 *) MembershipCardViewControllerForPageIndex{
    
    return self;
    
}


-(MembershipCardViewController2 *) initWithPageIndex:(NSInteger)index{
    return self;
    
}



#pragma mark Segue to OneCard

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    NSLog(@"I am entering prepairing for segue");
    
    if([[segue identifier] isEqualToString:@"showOneCard"]){
        if([[segue destinationViewController] isKindOfClass:[OneCardViewController class]]){
            NSLog(@"I am in prepair for segue to showOneCard");
            [self prepareForShowOneCard:segue sender:sender];
           }
        
}

}

-(void) prepareForShowOneCard:(UIStoryboardSegue *) segue sender:(id) sender{
    
    OneCardViewController *oneCardController=segue.destinationViewController;
    if([sender isKindOfClass:[UIButton class]] && [[[sender superview]superview] isKindOfClass:[UICollectionViewCell class]]){
        UICollectionViewCell *selectedCell=(UICollectionViewCell *)([sender superview].superview);
        NSIndexPath *path=[self.collectionView indexPathForCell:selectedCell];
        oneCardController.index=path.row+self.index*badgesCountInOnePage;        
    }
    //NSArray *selectedItem=[self.collectionView indexPathsForSelectedItems];
 

}
@end
