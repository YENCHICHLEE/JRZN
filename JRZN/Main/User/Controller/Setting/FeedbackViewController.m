//
//  FeedbackViewController.m
//  JRZN
//
//  Created by 曾国锐 on 16/6/23.
//  Copyright © 2016年 曾国锐. All rights reserved.
//

#import "FeedbackViewController.h"
#import "TZImagePickerController.h"
#import "IQTextView.h"

@interface FeedbackViewController ()<ZGRActionSheetDelegate, TZImagePickerControllerDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIView *bgView;
}
/**
 *  输入框
 */
@property (nonatomic, strong) IQTextView *textView;
/**
 *  临时图片
 */
@property (nonatomic, strong) NSMutableArray *tempImageArray;
/**
 *  图片
 */
@property (nonatomic, strong) NSMutableArray *imageArray;

@end

@implementation FeedbackViewController

- (NSMutableArray *)imageArray
{
    if (_imageArray == nil) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}

- (NSMutableArray *)tempImageArray
{
    if (_tempImageArray == nil) {
        _tempImageArray = [NSMutableArray array];
    }
    return _tempImageArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self makeUI];
    
    [self makeImageView];
    
    // Do any additional setup after loading the view.
}

- (void)makeUI{

    bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    
    bgView.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .topSpaceToView(self.view, 0)
    .heightIs(200);
    
    
    _textView = [[IQTextView alloc] init];
    [bgView addSubview:_textView];
    
    _textView.placeholder = @"请输入意见及反馈";
    _textView.font = kMainFont;
    
    _textView.sd_layout
    .leftSpaceToView(bgView, 10)
    .rightSpaceToView(bgView, 10)
    .topSpaceToView(bgView, 10)
    .heightIs(100);
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = kLineColor;
    
    [bgView addSubview:lineView];
    
    lineView.sd_layout
    .leftSpaceToView(bgView, 15)
    .rightSpaceToView(bgView, 0)
    .topSpaceToView(_textView, 20)
    .heightIs(1);
    
    
    UILabel *numsLiabel = [[UILabel alloc] init];
    [bgView addSubview:numsLiabel];
    numsLiabel.textAlignment = NSTextAlignmentRight;
    numsLiabel.text = @"0/100";
    numsLiabel.textColor = kGrayTitleColor;
    numsLiabel.font = kGrayFont;
    
    numsLiabel.sd_layout
    .rightSpaceToView(bgView, 15)
    .topSpaceToView(_textView, 0)
    .widthIs(100)
    .heightIs(20);
    

    [_textView.rac_textSignal subscribeNext:^(id x) {
        
        if (_textView.text.length > 100) {
            _textView.text = [_textView.text substringToIndex:100];
        }
        numsLiabel.text = [NSString stringWithFormat:@"%lu/100",(unsigned long)_textView.text.length];
    }];
    
    
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    submitButton.frame = CGRectMake(20, 20, WIDTH-40, 44);
    [submitButton setTitle:@"提交" forState:UIControlStateNormal];
    
    [submitButton setTitleColor:kTabbarNormalColor forState:UIControlStateNormal];
    //        exitButton.titleLabel.font = UIFont15;
    [submitButton setBackgroundColor:kTabbarHighlightedColor];
    submitButton.layer.cornerRadius = 3;
    submitButton.layer.masksToBounds = YES;
    [submitButton addTarget:self action:@selector(submitButtonClick) forControlEvents:UIControlEventTouchUpInside];
    submitButton.cjr_acceptEventInterval = 1;
    
    [self.view addSubview:submitButton];
    
    submitButton.sd_layout.
    topSpaceToView(bgView, 50)
    .heightIs(44);

}

- (void)makeImageView{
    
    for (int i=0; i<self.imageArray.count+1; i++) {
        
        UIImageView *headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake((i)%5*WIDTH/5+10, (i)/5*(WIDTH/5)+145, WIDTH/5-20, WIDTH/5-20)];
        [bgView addSubview:headerImageView];
        headerImageView.userInteractionEnabled = YES;
        
        headerImageView.tag = 200+i;
        
        if (i == self.imageArray.count) {
            headerImageView.image = [UIImage imageNamed:@"P11-13-4-1jia"];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addHeaderImage)];
            [headerImageView addGestureRecognizer:tap];
            
            self.tempImageArray = self.imageArray;
            
            if (self.tempImageArray.count>8) {
                headerImageView.hidden = YES;
            }
            
            [bgView setupAutoHeightWithBottomView:headerImageView bottomMargin:15];
        }else{
            headerImageView.image = self.imageArray[i];
            
            UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [bgView addSubview:deleteButton];
            
            deleteButton.frame = CGRectMake((i)%5*WIDTH/5+10+(WIDTH/5-30), (i)/5*(WIDTH/5)+145-10, 20, 20);
            deleteButton.backgroundColor = [UIColor redColor];
            [deleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [deleteButton setTitle:@"×" forState:UIControlStateNormal];
            deleteButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
//            [deleteButton setBackgroundImage:[UIImage imageNamed:@"P11-13-4-1guan"] forState:UIControlStateNormal];
            
            deleteButton.tag = 150+i;
            [deleteButton addTarget:self action:@selector(deleteButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            deleteButton.hidden = YES;
            deleteButton.layer.cornerRadius = 10;
            deleteButton.layer.masksToBounds = YES;
            
            UILongPressGestureRecognizer *longPre = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPreClick)];
            
            [headerImageView addGestureRecognizer:longPre];
        }
    }
}

- (void)addHeaderImage{
    
    [self.view endEditing:YES];
    ZGRActionSheet *sheet = [[ZGRActionSheet alloc] initWithTitle:@"选择照片" buttonTitles:@[@"相机",@"相册"] redButtonIndex:-1 delegate:self];
    [sheet show];
}

#pragma mark - ZGRActionSheetDelegate
- (void)actionSheet:(ZGRActionSheet *)actionSheet didClickedButtonAtIndex:(NSInteger)buttonIndex{
    
    switch (buttonIndex) {
        case 0:
        {//相机
            BOOL isOpen = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
            if (isOpen) {
                UIImagePickerController * imagePickerController = [[UIImagePickerController alloc]init];
                imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                imagePickerController.delegate = self;
                //设置拍照后的图片可被编辑
                imagePickerController.allowsEditing = YES;
                [self presentViewController:imagePickerController animated:YES completion:nil];
            }
        }
            break;
        case 1:
        {//相册
            TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:(9-self.tempImageArray.count) delegate:self];
            
            //imagePickerVc.allowPickingOriginalPhoto = NO;
            
            [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets) {
                
            }];
            [self presentViewController:imagePickerVc animated:YES completion:nil];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark TZImagePickerControllerDelegate

/// 用户点击了取消
- (void)imagePickerControllerDidCancel:(TZImagePickerController *)picker {
    DDLog(@"cancel");
}

/// 用户选择好了图片，如果assets非空，则用户选择了原图。
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray *)photos sourceAssets:(NSArray *)assets{
    
    //    UIImage *tempImage = photos[0];
    
    for (int i=0; i<self.tempImageArray.count+1; i++) {
        UIImageView *tempImageView = (UIImageView *)[bgView viewWithTag:200+i];
        [tempImageView removeFromSuperview];
        
        UIButton *button = (UIButton *)[bgView viewWithTag:150+i];
        [button removeFromSuperview];
    }
    
    [self.imageArray addObjectsFromArray:photos];
    
    [self makeImageView];
}

/// 用户选择好了视频
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(id)asset {
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
    
    for (int i=0; i<self.tempImageArray.count; i++) {
        UIButton *button = (UIButton *)[bgView viewWithTag:150+i];
        button.hidden = YES;
    }
}

- (void)rightClick:(id)sender
{
    DDLog(@"发布");
}

#pragma mark 系统相机 delegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    if ([type isEqualToString:@"public.image"])
    {
        //先把图片转成NSData
        UIImage* image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
        
        CGFloat tempF = WIDTH/image.size.width;
        image = [self imageWithImage:image scaledToSize:CGSizeMake(WIDTH, tempF*image.size.height)];
        
        NSData *data;
        if (UIImagePNGRepresentation(image) == nil)
        {
            data = UIImageJPEGRepresentation(image, 1.0);
        }
        else
        {
            data = UIImagePNGRepresentation(image);
        }
        
        //关闭相册界面
        [picker dismissViewControllerAnimated:YES completion:nil];

        for (int i=0; i<self.tempImageArray.count+1; i++) {
            UIImageView *tempImageView = (UIImageView *)[bgView viewWithTag:200+i];
            [tempImageView removeFromSuperview];
            
            UIButton *button = (UIButton *)[bgView viewWithTag:150+i];
            [button removeFromSuperview];
        }
        
        [self.imageArray addObject:image];
        
        [self makeImageView];
    }
}


//对图片尺寸进行压缩--
-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}

#pragma mark - 删除图片
- (void)deleteButtonClick:(UIButton *)button{
    
    for (int i=0; i<self.tempImageArray.count+1; i++) {
        
        UIImageView *tempImageView = (UIImageView *)[bgView viewWithTag:200+i];
        [tempImageView removeFromSuperview];
        
        UIButton *button = (UIButton *)[bgView viewWithTag:150+i];
        [button removeFromSuperview];
    }
    
    [self.tempImageArray removeObjectAtIndex:button.tag-150];
    
    [self makeImageView];
}

#pragma mark - 长按显示删除
- (void)longPreClick{
    
    
    for (int i=0; i<self.tempImageArray.count; i++) {
        UIButton *button = (UIButton *)[bgView viewWithTag:150+i];
        button.hidden = NO;
    }
}

#pragma mark - 提交按钮
- (void)submitButtonClick{

    
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
