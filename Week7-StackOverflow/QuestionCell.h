//
//  QuestionCell.h
//  Week7-StackOverflow
//
//  Created by Joey Nessif on 9/15/15.
//  Copyright (c) 2015 Joey Nessif. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (nonatomic) IBOutlet UIImageView *imageView;


@end
