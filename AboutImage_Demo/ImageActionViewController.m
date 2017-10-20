//
//  ImageActionViewController.m
//  AboutImage_Demo
//
//  Created by 马金丽 on 17/10/19.
//  Copyright © 2017年 majinli. All rights reserved.
//

#import "ImageActionViewController.h"
#import "UIImage+ImageAction.h"
@interface ImageActionViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSMutableArray *titleArray;

@property(nonatomic,strong)UIImageView *mainImageView;

@end

@implementation ImageActionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    
    [self.titleArray addObject:@"图片拉伸"];
    [self.titleArray addObject:@"图片裁剪"];
    
    [self.titleArray addObject:@"图片自适应裁剪"];

    [self.titleArray addObject:@"根据颜色生成纯色图片"];
    [self.titleArray addObject:@"图片压缩至指定尺寸"];
    [self.titleArray addObject:@"图片压缩至指定像素"];
    [self.titleArray addObject:@"生成指定大小的平铺图片"];
    [self.titleArray addObject:@"UIView转UIImage"];
    [self.titleArray addObject:@"两张图片合成一张图片"];

    [self.titleArray addObject:@"获取图片某一像素的颜色"];
    [self.titleArray addObject:@"获取灰度图片"];

    [self.titleArray addObject:@"图片旋转"];

    self.mainImageView.frame = CGRectMake(30, 320, 150, 200);
    
    UIImage *image = [UIImage imageNamed:[[NSBundle mainBundle]pathForResource:@"IMG_3490" ofType:@"JPG"]];
    self.mainImageView.image = image;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [self.titleArray objectAtIndex:indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        [self pullImage];
    }else if (indexPath.row == 1){
        [self clipImage];
    }else if (indexPath.row == 2){
        [self adaptiveClipImage];
    }else if (indexPath.row == 3){
        self.mainImageView.image = [UIImage imageWithColor:[UIColor greenColor]];
    }else if (indexPath.row == 4){
        [self commpressImageToSize];
    }else if (indexPath.row == 5){
        [self compressImageToPx];
    }else if (indexPath.row == 6){
        [self genterImageWithSize];
    }else if (indexPath.row == 7){
        [self genraImgeWithView];
    }else if (indexPath.row == 8){
        [self mergeImage];
    }else if (indexPath.row == 9){
        [self colorWithPoint];
    }else if (indexPath.row == 10){
        [self grayColorImage];
    }
    else{
        [self roateImage];
    }
}

- (void)commpressImageToSize
{
    UIImage *image = [UIImage imageNamed:[[NSBundle mainBundle]pathForResource:@"IMG_3490" ofType:@"JPG"]];
    
    UIImage *newImage = [UIImage compressImage:image toSize:CGSizeMake(100, 100)];
    self.mainImageView.frame = CGRectMake(20, 300, newImage.size.width, newImage.size.height);
    self.mainImageView.image = newImage;
}
- (void)compressImageToPx
{
    UIImage *image = [UIImage imageNamed:[[NSBundle mainBundle]pathForResource:@"IMG_3490" ofType:@"JPG"]];
    UIImage *newImage = [UIImage compressImage:image toPx:200];
    self.mainImageView.frame = CGRectMake(20, 300, newImage.size.width, newImage.size.height);
    self.mainImageView.image = newImage;
}

- (void)genterImageWithSize
{
    UIImage *image = [UIImage imageNamed:[[NSBundle mainBundle]pathForResource:@"IMG_3490" ofType:@"JPG"]];

    
   UIImage *newImage = [image generateImageWithSize:CGSizeMake(100, 100)];
    
    self.mainImageView.frame = CGRectMake(20, 350, newImage.size.width, newImage.size.height);
    self.mainImageView.image = newImage;
}

- (void)genraImgeWithView
{
    UIView *toView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 50)];
    toView.backgroundColor = [UIColor blueColor];
    
    UIImage *newImage = [UIImage generateImageWithView:toView];
    self.mainImageView.frame = CGRectMake(20, 350, newImage.size.width, newImage.size.height);

    self.mainImageView.image = newImage;
}

- (void)mergeImage
{
    UIImage *image01 = [UIImage imageNamed:[[NSBundle mainBundle]pathForResource:@"IMG_3490" ofType:@"JPG"]];
    
    UIImage *image02 = [UIImage imageNamed:[[NSBundle mainBundle]pathForResource:@"IMG_3138" ofType:@"JPG"]];
    
    UIImage *newImage = [UIImage mergeImageWithFirstImage:image01 withSecondImage:image02];
    self.mainImageView.frame = CGRectMake(20, 320, 200, 200);
    self.mainImageView.image = newImage;

}

- (void)colorWithPoint
{
    self.mainImageView.image = nil;
    UIImage *image01 = [UIImage imageNamed:[[NSBundle mainBundle]pathForResource:@"IMG_3490" ofType:@"JPG"]];
    UIColor *color = [image01 colorWithImagePixel:CGPointMake(400, 500)];
    self.mainImageView.backgroundColor = color;
}


- (void)grayColorImage
{
     UIImage *image01 = [UIImage imageNamed:[[NSBundle mainBundle]pathForResource:@"IMG_3490" ofType:@"JPG"]];
    UIImage *newImage = [image01 convertToGrayImage];
    self.mainImageView.image = newImage;
    self.mainImageView.frame = CGRectMake(30, 320, 200, 150);
}
- (void)pullImage
{
    UIImage *image = [UIImage imageNamed:@"Bubble2"];
    UIImage *newImage = [UIImage pullImage:image];
    self.mainImageView.image = newImage;
    
}
- (void)clipImage
{
    self.mainImageView.frame = CGRectMake(10, CGRectGetMaxY(self.mainTableView.frame)+10, 150, 100);
    UIImage *image = [UIImage imageNamed:[[NSBundle mainBundle]pathForResource:@"IMG_3490" ofType:@"JPG"]];
    self.mainImageView.image = [UIImage clipSubImageFromImage:image inSubRect:CGRectMake(0, 0, 20, 20)];
}

- (void)adaptiveClipImage
{
    self.mainImageView.frame = CGRectMake(10, CGRectGetMaxY(self.mainTableView.frame)+10, 200, 150);

    UIImage *image = [UIImage imageNamed:[[NSBundle mainBundle]pathForResource:@"IMG_3490" ofType:@"JPG"]];
    self.mainImageView.image= [UIImage adaptiveClipImage:image toRect:CGSizeMake(100, 100)];
//    self.mainImageView.image = [UIImage imageCompressForWithScale:image targetWidth:200];
}


- (void)roateImage
{
    self.mainImageView.frame = CGRectMake(30, 320, 150, 200);

    UIImage *image = [UIImage imageNamed:[[NSBundle mainBundle]pathForResource:@"IMG_3490" ofType:@"JPG"]];

    self.mainImageView.image = [UIImage rotateImage:image withOrientation:UIImageOrientationLeft];
}

- (NSMutableArray *)titleArray
{
    if (!_titleArray) {
        _titleArray = [[NSMutableArray alloc]init];
    }
    return _titleArray;
}

- (UIImageView *)mainImageView
{
    if (!_mainImageView) {
        _mainImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(self.mainTableView.frame)+10, [UIScreen mainScreen].bounds.size.width-40, 48)];
        [self.view addSubview:_mainImageView];
    }
    return _mainImageView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
