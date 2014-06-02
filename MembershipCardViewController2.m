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

-(void) setIndex:(NSInteger)index{
    _index=index;
    NSLog(@"index become %ld in collection",(long)_index);
    //set the special according the index ; need to be done here
}

-(BadgeInfos *) badgeInfos{
//    NSLog(@"getBadgeInfos has been called");
    if(_badgeInfos==nil)
        _badgeInfos=[BadgeInfos shareInstance];
    return _badgeInfos;
}


#pragma mark collectionView datasource

-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return badgesCountInOnePage;
}

-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    Cell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:kCellId forIndexPath:indexPath];
    NSLog(@"cellForItemAtIndexPath :index=%ld",(long)self.index);
    Badge *badge=[self.badgeInfos badgeAtIndex:(indexPath.row+self.index*badgesCountInOnePage)];
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

#pragma mark UICollectionViewDelegateFlowLayout protocal

-(CGFloat) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    CGRect screenBounds=[[UIScreen mainScreen]bounds];
    if(screenBounds.size.height==568) //4 inch
    {
        return 20.0;
    }
    
    else{ //3.5 inch
        return 5.0;
    }
}

-(CGFloat) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    CGRect screenBounds=[[UIScreen mainScreen]bounds];
    if(screenBounds.size.height==568)
    {
        return 10.0;
    }
    
    else{
        return 10.0;
    }
}

-(UIEdgeInsets) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    CGRect screenBounds=[[UIScreen mainScreen]bounds];
    if(screenBounds.size.height==568)
    {
        return UIEdgeInsetsMake(20, 20, 0, 20);
    }
    
    else{
        return UIEdgeInsetsMake(9, 20, 0, 20);
    }
    
}

#


#pragma mark PageView delegate

/**
-(MembershipCardViewController2 *) MembershipCardViewControllerForPageIndex{
    
    return self;
    
}


-(MembershipCardViewController2 *) initWithPageIndex:(NSInteger)index{
    return self;
    
}

**/
#pragma mark - LXReorderableCollectionViewDataSource methods

- (void)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)fromIndexPath willMoveToIndexPath:(NSIndexPath *)toIndexPath {
    
    Badge *badge=[self.badgeInfos badgeAtIndex:(fromIndexPath.row+self.index*badgesCountInOnePage)];

        [self.badgeInfos.badges removeObjectAtIndex:fromIndexPath.item];
    [self.badgeInfos.badges insertObject:badge atIndex:toIndexPath.item];
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    return  YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)fromIndexPath canMoveToIndexPath:(NSIndexPath *)toIndexPath {
    return  YES;
}

#pragma mark - LXReorderableCollectionViewDelegateFlowLayout methods

- (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout willBeginDraggingItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"will begin drag");
}

- (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout didBeginDraggingItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"did begin drag");
}

- (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout willEndDraggingItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"will end drag");
}

- (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout didEndDraggingItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"did end drag");
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
