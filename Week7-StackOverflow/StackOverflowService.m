//
//  StackOverflowService.m
//  Week7-StackOverflow
//
//  Created by Joey Nessif on 9/17/15.
//  Copyright © 2015 Joey Nessif. All rights reserved.
//

#import "StackOverflowService.h"
#import <AFNetworking/AFNetworking.h>
#import "Errors.h"
#import "Question.h"
#import "QuestionJSONParser.h"

@implementation StackOverflowService

+ (void)questionsForSearchTerm:(NSString *)searchTerm completionHandler:(void(^)(NSArray *, NSError*))completionHandler {
  NSString *url = @"https://api.stackexchange.com/2.2/search?order=desc&sort=activity&intitle=";
  url = [url stringByAppendingString:searchTerm];
  url = [url stringByAppendingString:@"&site=stackoverflow"];
  
  AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
  
  [manager GET:url parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
    
    NSArray *questions = [QuestionJSONParser questionsResultsFromJSON:responseObject];
    
    completionHandler(questions,nil);
    
  } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
    if (operation.response) {
      NSError *stackOverflowError = [self errorForStatusCode:operation.response.statusCode];
      dispatch_async(dispatch_get_main_queue(), ^{
        completionHandler(nil,stackOverflowError);
      });
    } else {
      NSError *reachabilityError = [self checkReachability];
      if (reachabilityError) {
        completionHandler(nil, reachabilityError);
      }
    }
  }];
}

+(NSError *)checkReachability {
  if (![AFNetworkReachabilityManager sharedManager].reachable) {
    NSError *error = [NSError errorWithDomain:kStackOverflowErrorDomain code:StackOverflowConnectionDown userInfo:@{NSLocalizedDescriptionKey : @"Could not connect to servers, please try again when you have a connection"}];
    return error;
  }
  return nil;
}

+(NSError *)errorForStatusCode:(NSInteger)statusCode {
  
  NSInteger errorCode;
  NSString *localizedDescription;
  
  switch (statusCode) {
    case 400:
      localizedDescription = @"Invalid search parameter.";
      errorCode = StackOverflowInvalidParameter;
      break;
    case 401:
    case 402:
      localizedDescription = @"Please log in with a valid username and password to access this feature.";
      errorCode = StackOverflowNeedProperAuthentication;
      break;
    case 403:
      localizedDescription = @"You do not have permission to access this feature.";
      errorCode = StackOverflowAccessDenied;
      break;
    case 404:
      localizedDescription = @"That feature does not exist.";
      errorCode = StackOverflowNoMethod;
      break;
    case 405:
      localizedDescription = @"An application key is required for this feature.";
      errorCode = StackOverflowKeyRequired;
      break;
    case 406:
      localizedDescription = @"Your access to this feature has been compromised.";
      errorCode = StackOverflowAccessTokenCompromised;
      break;
    case 407:
      localizedDescription = @"Your data could not be saved.";
      errorCode = StackOverflowWriteFailed;
      break;
    case 409:
      localizedDescription = @"That request has already been made previously.";
      errorCode = StackOverflowDuplicateRequest;
      break;
    case 500:
      localizedDescription = @"An unexpected error has occurred. StackOverflow Developers have been notified.";
      errorCode = StackOverflowInternalError;
      break;
    case 502:
      localizedDescription = @"Too many requests have been made, please try again later.";
      errorCode = StackOverflowThrottleViolation;
      break;
    case 503:
      localizedDescription = @"That feature is unavailable at this time.";
      errorCode = StackOverflowTemporarilyUnavailable;
      break;
    default:
      localizedDescription = @"Could not complete operation, please try again later";
      errorCode = StackOverFlowGeneralError;
      break;
  }
  NSError *error = [NSError errorWithDomain:kStackOverflowErrorDomain code:errorCode userInfo:@{NSLocalizedDescriptionKey : localizedDescription}];
  return error;
}


@end
