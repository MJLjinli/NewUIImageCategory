//
//  ImageInfoViewController.h
//  AboutImage_Demo
//
//  Created by 马金丽 on 17/10/19.
//  Copyright © 2017年 majinli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageInfoViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *mainTableView;


@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (weak, nonatomic) IBOutlet UITextView *contentText;


@end
