//
//  QuestionJSONParser.h
//  Week7-StackOverflow
//
//  Created by Joey Nessif on 9/17/15.
//  Copyright © 2015 Joey Nessif. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuestionJSONParser : NSObject

+(NSArray *)questionsResultsFromJSON:(NSDictionary *)jsonInfo;

@end
