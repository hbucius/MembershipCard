//
//  OneCardViewController.h
//  MembershipCard
//
//  Created by mstr on 4/29/14.
//  Copyright (c) 2014 com.hbu.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OneCardViewController : UIViewController
@property(strong,nonatomic) UIImage *image;
@property(nonatomic) NSInteger index; // the index in badgeInfos ,start from 0
@property (weak, nonatomic) IBOutlet UILabel *cardName;
@property (weak, nonatomic) IBOutlet UILabel *cardNumber;
@property (weak, nonatomic) IBOutlet UIImageView *cardBackgroundImage;

@end
