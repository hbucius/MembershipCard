//
//  Badge+Info.m
//  MembershipCard
//
//  Created by mstr on 5/17/14.
//  Copyright (c) 2014 com.hbu.com. All rights reserved.
//

#import "Badge+Info.h"
#import "Badge.h"
#import "DataController.h"


@implementation Badge (Info)



+(instancetype) initWithName:(NSString *)badgeName WithbackgroundColor:(UIColor *) backgroundColor withContext:(NSManagedObjectContext*) context;
{
    Badge *managedBadge=[NSEntityDescription insertNewObjectForEntityForName:@"Badge" inManagedObjectContext:context];
    if(managedBadge!=nil){
        managedBadge.badgeBackgroundColor=backgroundColor;
        managedBadge.badgeName=badgeName;
        
    }
    return managedBadge;
}

+(instancetype) initWithName:(NSString *)badgeName WithbackgroundColor:(UIColor *) backgroundColor withBadgeThumbImage:(NSString*)badgeThumbImage withContext:(NSManagedObjectContext*) context
{
    Badge *managedBadge=[NSEntityDescription insertNewObjectForEntityForName:@"Badge" inManagedObjectContext:context];
    if(managedBadge!=nil){
        managedBadge.badgeBackgroundColor=backgroundColor;
        managedBadge.badgeName=badgeName;
        managedBadge.badgeThumbImage=badgeThumbImage;
        
    }
    return managedBadge;
}
+(instancetype) initWithName:(NSString *)badgeName WithbackgroundColor:(UIColor *)backgroundColor withBadgeThumbImage:(NSString*)badgeThumbImage withBadgeImage:(NSString*)badgeImage WithCardNumber:(NSString*) cardNumber withCardNumberLocation:(NSLocation*)cardNumberLocation withCardNmame:(NSString*) cardName WithCardNameLocation:(NSLocation*) cardNameLocation withContext:(NSManagedObjectContext*) context{
    Badge *managedBadge=[NSEntityDescription insertNewObjectForEntityForName:@"Badge" inManagedObjectContext:context];
    if(managedBadge!=nil){
        managedBadge.badgeName=badgeName;
        managedBadge.badgeBackgroundColor=backgroundColor;
        managedBadge.badgeThumbImage=badgeThumbImage;
        managedBadge.badgeImage=badgeImage;
        managedBadge.cardNumber=cardNumber;
        managedBadge.cardNumberlocation=cardNumberLocation;
        managedBadge.cardName=cardName;
        managedBadge.cardNameLocation=cardNameLocation;
    }
    return managedBadge;
}


+(NSString *) defaultBadgeThumbImage{
    NSLog(@"get into defaultBadgeThumbImageURL");
    
    return  @"2.JPG" ;
    
}


@end
