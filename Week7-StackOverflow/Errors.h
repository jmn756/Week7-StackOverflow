//
//  Errors.h
//  Week7-StackOverflow
//
//  Created by Joey Nessif on 9/17/15.
//  Copyright (c) 2015 Joey Nessif. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const kStackOverFlowErrorDomain;

typedef enum : NSUInteger {
  StackOverFlowBadJSON,
  StackOverFlowConnectionDown,
  StackOverFlowTooManyAttempts,
  StackOverFlowInvalidParameter,
  StackOverFlowNeedAuthentication,
  StackOverFlowGeneralError
} StackOverFlowErrorCodes;



