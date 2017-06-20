//
//  MagicalRecord+SerialSaving.m
//  it baker
//
//  Created by Avvakumov Dmitry on 25.02.16.
//  Copyright © 2016 Avvakumov Dmitry. All rights reserved.
//

#import "MagicalRecord+SerialSaving.h"

#import "DMSerialSaving.h"

@implementation MagicalRecord (SerialSaving)

+ (void)serialSaveWithBlock:(void (^)(NSManagedObjectContext *))block {
    return [self serialSaveWithBlock:block completion:nil];
}

+ (void)serialSaveWithBlock:(void (^)(NSManagedObjectContext *))block completion:(MRSaveCompletionHandler)completion {
    
    [[DMSerialSaving sharedInstance] serialSaveWithBlock:block completion:completion];
}

+ (void)serialSaveWithBlockAndWait:(void (^)(NSManagedObjectContext *localContext))block {
    [MagicalRecord saveWithBlockAndWait:block];
}

@end
