//
//  Badge.h
//  MembershipCard
//
//  Created by mstr on 5/15/14.
//  Copyright (c) 2014 com.hbu.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Badge : NSManagedObject

@property (nonatomic, retain) NSString * badgeName;
@property (nonatomic, retain) NSString * badgeThumbImage;
@property (nonatomic, retain) id badgeBackgroundColor;
@property (nonatomic, retain) NSString * badgeImage;
@property (nonatomic, retain) NSString * cardNumber;
@property (nonatomic, retain) id cardNumberlocation;
@property (nonatomic, retain) NSString * cardName;
@property (nonatomic, retain) id cardNameLocation;
@property (nonatomic, retain) id cardNumberColor;
@property (nonatomic, retain) id cardNameColor;

@end
