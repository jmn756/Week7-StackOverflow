//
//  Errors.h
//  Week7-StackOverflow
//
//  Created by Joey Nessif on 9/17/15.
//  Copyright (c) 2015 Joey Nessif. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const kStackOverflowErrorDomain;

typedef enum : NSUInteger {
  StackOverflowInvalidParameter,
  StackOverflowNeedProperAuthentication,
  StackOverflowAccessDenied,
  StackOverflowNoMethod,
  StackOverflowKeyRequired,
  StackOverflowAccessTokenCompromised,
  StackOverflowWriteFailed,
  StackOverflowDuplicateRequest,
  StackOverflowInternalError,
  StackOverflowThrottleViolation,
  StackOverflowTemporarilyUnavailable,
//  StackOverFlowBadJSON,
  StackOverflowConnectionDown,
  StackOverFlowGeneralError
} StackOverflowErrorCodes;



