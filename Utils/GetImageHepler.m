//
//  GetImageHepler.m
//  SSLiftSalesman
//
//  Created by 侯佩岑 on 2018/6/22.
//  Copyright © 2018年 XinMi. All rights reserved.
//

#import "GetImageHepler.h"

@interface GetImageHepler ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic, strong) UIImagePickerController * pickerVC;

@end

@implementation GetImageHepler

-(instancetype)initWithTargetViewVC:(UIViewController *)vc{
    if (self = [self init]) {
        self.targatViewVC = vc;
    }
    return self;
}

-(void)requireImageWithTitle:(NSString *)title withSubTitle:(NSString *)subTitle{
    [ToastTool showSheettWithTitle:(title&&title.length>0)?title:@"选择图片" message:(subTitle&&subTitle.length>0)?subTitle:@"请选择方式" subTitles:@[@"拍照",@"本地相册上传",@"取消"] selectFinish:^(NSInteger index, NSString *stbTitle) {
        if (index == 0) {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                UIImagePickerController * pickerImageVC = [[UIImagePickerController alloc] init];
                pickerImageVC.sourceType = UIImagePickerControllerSourceTypeCamera;
                pickerImageVC.delegate = self;
                [self.targatViewVC presentViewController:pickerImageVC animated:YES completion:nil];
                self.pickerVC = pickerImageVC;
            }else{
                [ToastTool showErrorWithStatus:@"no spport canmera"];
            }
        }else if (index == 1){
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                UIImagePickerController * pickerImageVC = [[UIImagePickerController alloc] init];
                pickerImageVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                pickerImageVC.delegate = self;
                [self.targatViewVC presentViewController:pickerImageVC animated:YES completion:nil];
                self.pickerVC = pickerImageVC;
            }else{
                [ToastTool showErrorWithStatus:@"no spport PhotoLibrary"];
            }
            
        }else if (index == 2) {
            
        }
    } completion:^{
        
    }];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage * image = info[UIImagePickerControllerOriginalImage]?:nil;
    [picker dismissViewControllerAnimated:YES completion:^{
        if (image && self.selectImageBlock) {
            self.selectImageBlock(image);
        }
    }];
}

@end
