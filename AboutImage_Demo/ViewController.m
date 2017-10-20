//
//  ViewController.m
//  AboutImage_Demo
//
//  Created by 马金丽 on 17/10/19.
//  Copyright © 2017年 majinli. All rights reserved.
//

#import "ViewController.h"
#import "ImageInfoViewController.h"
#import "ImageActionViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

   self.navigationItem.title = @"图片处理";
}

- (IBAction)imageInfo:(id)sender {
    
    ImageInfoViewController *infoVC = [[ImageInfoViewController alloc]init];
    [self.navigationController pushViewController:infoVC animated:YES];
    
}
- (IBAction)imageAction:(id)sender {
    ImageActionViewController *actionVC = [[ImageActionViewController alloc]init];
    [self.navigationController pushViewController:actionVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
