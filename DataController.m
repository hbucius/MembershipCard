//
//  DataController.m
//  MembershipCard
//
//  Created by mstr on 5/17/14.
//  Copyright (c) 2014 com.hbu.com. All rights reserved.
//

#import "DataController.h"
#import "Badge+Info.h"
#import "Constants.h"
@interface DataController  ()

@property UIManagedDocument *document;

@end

 static DataController *_shareInstance=nil ;

@implementation DataController

-(NSManagedObjectContext*) context {
    
    if(_context==nil){
        
        _context=_shareInstance.document.managedObjectContext;
        
    }
    return _context;

}


+ (DataController*) shareInstance {
    if(_shareInstance==nil){
        _shareInstance=[[DataController alloc]initWithFile:@"dataModel"];
        
    } 
    return  _shareInstance;
}


-(instancetype) initWithFile:(NSString *) name {
    
    self=[super init];
    if(self) {
        //set up files
        NSFileManager *fileManager=[NSFileManager defaultManager];
        NSURL *documentDirectory=[[fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
        NSURL *url=[documentDirectory URLByAppendingPathComponent:name];
        self.document=[[UIManagedDocument alloc]initWithFileURL:url];
        if ([[NSFileManager defaultManager] fileExistsAtPath:[url path]]) {
            if (DebugIng) {
                [[NSFileManager defaultManager] removeItemAtURL:url error:nil];
                [self.document saveToURL:url forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
                    NSLog(@"Re-create file %@",name);
                }];
            }
           [self.document openWithCompletionHandler:^(BOOL success) {
                 NSLog(@"open the file %@ ",name);
             }];
        }
        else {
            [self.document saveToURL:url forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
                NSLog(@"create file %@",name);
            }];
        }
        
    }
    
    return self;
}

@end
