//
//  DMSerialSaving.m
//  it baker
//
//  Created by Dmitry Avvakumov on 20.06.17.
//  Copyright © 2017 Dmitry Avvakumov. All rights reserved.
//

#import "DMSerialSaving.h"

#define DMSerialSaving_SaveBlockKey @"saveBlock"
#define DMSerialSaving_CompletitionBlockKey @"completitionBlock"

@interface DMSerialSaving()

@property (strong, nonatomic) NSMutableDictionary *saveBlocksWithCompletitions;

@property (weak, nonatomic) NSDictionary *currentProcess;

@end

@implementation DMSerialSaving

+ (DMSerialSaving *)sharedInstance {
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.saveBlocksWithCompletitions = [NSMutableDictionary dictionaryWithCapacity:10];
    }
    return self;
}

#pragma mark - Public

- (void)serialSaveWithBlock:(void (^)(NSManagedObjectContext *localContext))block completion:(MRSaveCompletionHandler)completion {
    
    NSString *key = [NSProcessInfo processInfo].globallyUniqueString;
    
    NSMutableDictionary *info = [NSMutableDictionary dictionaryWithCapacity:2];
    if (block) {
        [info setObject:block forKey:DMSerialSaving_SaveBlockKey];
    }
    if (completion) {
        [info setObject:completion forKey:DMSerialSaving_CompletitionBlockKey];
    }

    [self.saveBlocksWithCompletitions setObject:info forKey:key];
    
    [self tryToSave];
}

#pragma mark - Private

- (void)tryToSave {
    
    @synchronized (self) {
        NSDictionary *info = self.currentProcess;
        if (info) return;
        
        /* info */
        NSArray *allKeys = [self.saveBlocksWithCompletitions allKeys];
        if ([allKeys count] == 0) return;
        
        NSString *key = [allKeys firstObject];
        info = [self.saveBlocksWithCompletitions objectForKey:key];
        
        /* data */
        void(^saveBlock)(NSManagedObjectContext *localContext) = [info objectForKey:DMSerialSaving_SaveBlockKey];
        MRSaveCompletionHandler completitionBlock = [info objectForKey:DMSerialSaving_CompletitionBlockKey];
        
        self.currentProcess = info;
        
        [MagicalRecord saveWithBlock:saveBlock completion:^(BOOL contextDidSave, NSError * _Nullable error) {
            if (completitionBlock) {
                completitionBlock(contextDidSave, error);
            }
            
            [self.saveBlocksWithCompletitions removeObjectForKey:key];
            self.currentProcess = nil;
            
            [self tryToSave];
        }];
    }
}

@end
