//
//  ImageInfoViewController.m
//  AboutImage_Demo
//
//  Created by 马金丽 on 17/10/19.
//  Copyright © 2017年 majinli. All rights reserved.
//

#import "ImageInfoViewController.h"
#import "UIImage+ImageAction.h"
@interface ImageInfoViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property(nonatomic,strong)NSMutableArray *titleArray;

//https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1508405750863&di=4475c3f6fd52a5d047d51419fd043c94&imgtype=0&src=http%3A%2F%2Ft1.niutuku.com%2F960%2F55%2F55-85797.jpg

@end

@implementation ImageInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"图片信息";
    [self.titleArray addObject:@"获取系统相册图片及信息"];
    [self.titleArray addObject:@"获取图片尺寸大小"];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.mainImageView.clipsToBounds = YES;
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
        [self presentImagePick];
    }else if (indexPath.row == 1){
        [self getImageSize];

    }else{
        
    }
}

- (void)presentImagePick
{
    //判断系统相册是否可以打开
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        return;
    }
    //创建图片选择控制器
    UIImagePickerController *pickVC = [[UIImagePickerController alloc]init];
    //设置打开照片的相册类型
    pickVC.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    pickVC.delegate = self;
    [self presentViewController:pickVC animated:YES completion:nil];
}

#pragma mark -UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    
    NSLog(@"%@",info);
    //获取到原图
    UIImage *image = info[UIImagePickerControllerOriginalImage];
//    //质量压缩
//    NSData *data = UIImageJPEGRepresentation(image, 0.7);
//    image = [UIImage imageWithData:data];
//    //尺寸压缩
//    CGSize size = CGSizeMake(150, 150);
//    UIGraphicsBeginImageContext(size);
//    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
//    image = UIGraphicsGetImageFromCurrentImageContext();
    //将图片压缩到指定大小
    image = [UIImage compressImageSize:image toTargetWidth:300];

    self.mainImageView.image = image;
    self.contentText.text = [NSString stringWithFormat:@"%@",info];
}

#pragma mark -获取本图片尺寸
- (void)getImageSize
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"IMG_3490" ofType:@"JPG"];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    
    self.mainImageView.image = image;
    CGSize imageSize = image.size;
    
    NSLog(@"width%f----height%f",imageSize.width,imageSize.height);
    
    
}

#pragma mark -懒加载
- (NSMutableArray *)titleArray
{
    if (!_titleArray) {
        _titleArray = [[NSMutableArray alloc]init];
    }
    return _titleArray;
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
