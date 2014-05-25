//
//  cardContentViewControllerTableViewController.h
//  MembershipCard
//
//  Created by mstr on 5/21/14.
//  Copyright (c) 2014 com.hbu.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardContent.h"

@interface cardContentViewControllerTableViewController : UITableViewController
@property NSInteger groupNumber;

@property NSDictionary *cardContent;

-(instancetype) initWithCardContent:(CardContent* )cardContent;

@end
