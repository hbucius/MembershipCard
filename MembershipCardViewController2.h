//
//  MembershipCardViewController2.h
//  MembershipCard
//
//  Created by mstr on 5/6/14.
//  Copyright (c) 2014 com.hbu.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MembershipCardViewController2 : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic) NSInteger index;
- (MembershipCardViewController2 *)memberCardViewCotrollerAtIndex: (NSInteger) index;

@end
