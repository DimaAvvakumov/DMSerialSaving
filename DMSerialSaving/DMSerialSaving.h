//
//  DMSerialSaving.h
//  it baker
//
//  Created by Dmitry Avvakumov on 20.06.17.
//  Copyright © 2017 Dmitry Avvakumov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MagicalRecord/MagicalRecord.h>

@interface DMSerialSaving : NSObject

+ (DMSerialSaving *)sharedInstance;

- (void)serialSaveWithBlock:(void (^)(NSManagedObjectContext *localContext))block completion:(MRSaveCompletionHandler)completion;

@end
