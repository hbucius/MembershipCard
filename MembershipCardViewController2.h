//
//  MembershipCardViewController2.h
//  MembershipCard
//
//  Created by mstr on 5/6/14.
//  Copyright (c) 2014 com.hbu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LXReorderableCollectionViewFlowLayout.h"

@interface MembershipCardViewController2 : UIViewController<LXReorderableCollectionViewDelegateFlowLayout,LXReorderableCollectionViewDataSource>
@property(nonatomic) NSInteger index;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property(nonatomic,strong) UIView *currentView;
-(void) setLastSelectedIndexpath:(NSIndexPath*) lastIndexPath lastCurrentView:(UIView *) lastView lastCurrentViewCenter:(CGPoint) lastPoint;


@end
