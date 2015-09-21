//
//  StackOverflowService.h
//  Week7-StackOverflow
//
//  Created by Joey Nessif on 9/17/15.
//  Copyright © 2015 Joey Nessif. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StackOverflowService : NSObject

+ (void)questionsForSearchTerm:(NSString *)searchTerm completionHandler:(void(^)(NSArray *, NSError*))completionHandler;

@end
