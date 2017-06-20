//
//  MagicalRecord+SerialSaving.h
//  it baker
//
//  Created by Avvakumov Dmitry on 25.02.16.
//  Copyright © 2016 Avvakumov Dmitry. All rights reserved.
//

#import <MagicalRecord/MagicalRecord.h>

@class NSManagedObjectContext;

@interface MagicalRecord (SerialSaving)

+ (void)serialSaveWithBlock:(void (^)(NSManagedObjectContext *localContext))block;
+ (void)serialSaveWithBlock:(void (^)(NSManagedObjectContext *localContext))block completion:(MRSaveCompletionHandler)completion;

+ (void)serialSaveWithBlockAndWait:(void (^)(NSManagedObjectContext *localContext))block;

@end
