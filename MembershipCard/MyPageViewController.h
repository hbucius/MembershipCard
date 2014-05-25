//
//  MyPageViewController.h
//  MembershipCard
//
//  Created by mstr on 5/1/14.
//  Copyright (c) 2014 com.hbu.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MyPageViewController : UIPageViewController <UIPageViewControllerDataSource>
 @property (nonatomic) NSInteger maxIndex;
@property (nonatomic) NSInteger indexOnScreen;


@end
