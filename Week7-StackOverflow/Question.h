//
//  Question.h
//  Week7-StackOverflow
//
//  Created by Joey Nessif on 9/15/15.
//  Copyright (c) 2015 Joey Nessif. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Question : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *avatarURL;
@property (strong, nonatomic) UIImage *avatarPic;
@property (strong, nonatomic) NSString *ownerName;


@end
