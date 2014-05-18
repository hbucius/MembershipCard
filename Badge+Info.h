//
//  Badge+Info.h
//  MembershipCard
//
//  Created by mstr on 5/17/14.
//  Copyright (c) 2014 com.hbu.com. All rights reserved.
//

#import "Badge.h"
#import "NSLocation.h"

@interface Badge (Info)


+(instancetype) initWithName:(NSString *)badgeName WithbackgroundColor:(UIColor *) backgroundColor withContext:(NSManagedObjectContext*) context;
+(instancetype) initWithName:(NSString *)badgeName WithbackgroundColor:(UIColor *) backgroundColor withBadgeThumbImage:(NSString*)badgeImage withContext:(NSManagedObjectContext*) context;
+(instancetype) initWithName:(NSString *)badgeName WithbackgroundColor:(UIColor *)backgroundColor withBadgeThumbImage:(NSString*)badgeThumbImage withBadgeImage:(NSString*)badgeImage WithCardNumber:(NSString*) cardNumber withCardNumberLocation:(NSLocation*)cardNumberLocation withCardNmame:(NSString*) cardName WithCardNameLocation:(NSLocation*) cardNameLocation withContext:(NSManagedObjectContext*) context;

@end
