
//
//  PersonalViewController.m
//  JRZN
//
//  Created by 曾国锐 on 16/6/3.
//  Copyright © 2016年 曾国锐. All rights reserved.
//

#import "PersonalViewController.h"
#import "ImgZoomView.h"

@interface PersonalViewController ()<UITableViewDataSource, UITableViewDelegate, ZGRActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate, CityPickerViewDelegate>
{
    UIImageView *headerImageView;//头像
}
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation PersonalViewController

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    [_tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self makeTableView];
    // Do any additional setup after loading the view.
}

- (void)makeTableView{
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.sectionFooterHeight = 1.0;
    _tableView.backgroundColor = kViewBackgroundColor;
    [self.view addSubview:_tableView];
    
    self.tableView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
}

#pragma mark 设置自定义段头的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 7;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 60.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"CellIdentifier";
    
    UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        
        UIView *lineView = [UIView new];
        lineView.backgroundColor = kViewBackgroundColor;
        [cell.contentView addSubview:lineView];
        
        lineView.sd_layout
        .leftSpaceToView(cell.contentView, 15)
        .widthIs(WIDTH-15)
        .heightIs(1)
        .bottomSpaceToView(cell.contentView, -0.5);
        
//    }
    
    NSArray *titleArr = @[@"头像", @"昵称", @"性别", @"手机号码", @"邮箱", @"地区", @"个性签名"];
    
    cell.textLabel.text = titleArr[indexPath.row];
    cell.textLabel.textColor = kBlackTitleColor;
    cell.textLabel.font = kMainFont;
    
    switch (indexPath.row) {
        case 0:
        {//头像
            
            headerImageView = [UIImageView new];
            headerImageView.size = CGSizeMake(40, 40);
            if ([UserModel shareUserModelManager].headerImage) {
                headerImageView.image = [UserModel shareUserModelManager].headerImage;
            }else{
                headerImageView.image = HEADER_IMG;
            }
            
            headerImageView.layer.cornerRadius = 20;
            headerImageView.layer.masksToBounds = YES;
//            headerImageView.layer.borderWidth = 1.0f;
//            headerImageView.layer.borderColor = kBlackTitleColor.CGColor;
            headerImageView.userInteractionEnabled = YES;
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHeaderImageViewClick)];
            [headerImageView addGestureRecognizer:tap];
            
            cell.accessoryView = headerImageView;
        }
            break;
        case 1:
        {//昵称
            if ([UserModel shareUserModelManager].userName.length > 0) {
                cell.detailTextLabel.text = [UserModel shareUserModelManager].userName;
            }else{
                cell.detailTextLabel.text = @"默认昵称";
            }
            
        }
            break;
        case 2:
        {//性别
            if ([UserModel shareUserModelManager].userSex.length > 0) {
                cell.detailTextLabel.text = [UserModel shareUserModelManager].userSex;
            }else{
                cell.detailTextLabel.text = @"选择性别";
            }
        }
            break;
        case 3:
        {//手机号码
            
            if ([UserModel shareUserModelManager].userPhoneNumber.length > 0) {
                cell.detailTextLabel.text = [[UserModel shareUserModelManager].userPhoneNumber hiddePhoneNumber:[UserModel shareUserModelManager].userPhoneNumber];
            }else{
                cell.detailTextLabel.text = @"添加手机号码";
            }
        }
            break;
        case 4:
        {//邮箱
            if ([UserModel shareUserModelManager].userEmail.length > 0) {
                cell.detailTextLabel.text = [UserModel shareUserModelManager].userEmail;
            }else{
                cell.detailTextLabel.text = @"添加邮箱";
            }
        }
            break;
        case 5:
        {//地区
            if ([UserModel shareUserModelManager].userRegion.length > 0) {
                cell.detailTextLabel.text = [UserModel shareUserModelManager].userRegion;
            }else{
                cell.detailTextLabel.text = @"未设置";
            }
        }
            break;
        case 6:
        {//个性签名
            if ([UserModel shareUserModelManager].userSignature.length > 0) {
                cell.detailTextLabel.text = [UserModel shareUserModelManager].userSignature;
            }else{
                cell.detailTextLabel.text = @"点击添加个性签名";
            }
        }
            break;
            
        default:
            break;
    }
    
    cell.detailTextLabel.textColor = kGrayTitleColor;
    cell.detailTextLabel.font = kMainFont;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    switch (indexPath.row) {
        case 0:
        {//头像
            ZGRActionSheet *sheet = [[ZGRActionSheet alloc] initWithTitle:@"设置头像" buttonTitles:@[@"拍照", @"从手机相册中选择"] redButtonIndex:-1 delegate:self];
            sheet.tag = 300;
            [sheet show];
        }
            break;
        case 1:
        {//昵称
            UIViewController *vc = [NSClassFromString(@"NickNameViewController") new];
            vc.title = @"修改昵称";
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {//性别
            ZGRActionSheet *sheet = [[ZGRActionSheet alloc] initWithTitle:@"设置性别" buttonTitles:@[@"男", @"女"] redButtonIndex:-1 delegate:self];
            sheet.tag = 301;
            [sheet show];
        }
            break;
        case 3:
        {//手机号码
            UIViewController *vc = [NSClassFromString(@"PhoneNumberViewController") new];
            vc.title = @"修改手机号";
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 4:
        {//邮箱
            UIViewController *vc = [NSClassFromString(@"EmailViewController") new];
            vc.title = @"修改邮箱";
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 5:
        {//地区
            CityPickerView *picker = [[CityPickerView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
            picker.delegate = self;
            [self.view addSubview:picker];
        }
            break;
        case 6:
        {//个性签名
            UIViewController *vc = [NSClassFromString(@"SignatureViewController") new];
            vc.title = @"修改个性签名";
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - ZGRActionSheetDelegate
- (void)actionSheet:(ZGRActionSheet *)actionSheet didClickedButtonAtIndex:(NSInteger)buttonIndex{

    @weakify(self)
    
    if (actionSheet.tag == 300) {
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
                UIImagePickerController * picker = [[UIImagePickerController alloc] init];
                picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                picker.delegate = self;
                picker.allowsEditing = YES;
                [self presentViewController:picker animated:YES completion:nil];
            }
                break;
                
            default:
                break;
        }
    }
    
    if (actionSheet.tag == 301) {
        
//        [[UserBusinessManager shareInstance] updateGender:(buttonIndex == 0)?@"男":@"女" completion:^(BOOL result) {
//            
//            @strongify(self)
//            
//            if (result) {
//                [UserModel shareUserModelManager].userSex = (buttonIndex == 0)?@"男":@"女";
//                //一个cell刷新
//                NSIndexPath *indexPath=[NSIndexPath indexPathForRow:2 inSection:0];
//                [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
//            }
//        }];
        
    }
}

#pragma mark 系统相机 delegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    //    NSString * type = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    
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
        
//        float length = [data length]/1024;
        
        //图片保存的路径
        //这里将图片放在沙盒的documents文件夹中
        NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        
        //文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        //把刚刚图片转换的data对象拷贝至沙盒中 并保存为image.png
        [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
        [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:@"/image.png"] contents:data attributes:nil];
        
        //得到选择后沙盒中图片的完整路径
        //        NSString *filePath = [[NSString alloc]initWithFormat:@"%@%@",DocumentsPath,  @"/image.png"];
        //关闭相册界面
        [picker dismissViewControllerAnimated:YES completion:nil];
//        headerImageView.image = image;
        [UserModel shareUserModelManager].headerImage = image;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationHeaderIMGRefreash object:nil userInfo:nil];
        
        //一个cell刷新
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];

       
//        //图片转成64字符串
//        NSString* _encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
//        _headerBase64 = _encodedImageStr;
//        
//        [self updateHeaderImage:_encodedImageStr];
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

#pragma mark - 点击头像
- (void)tapHeaderImageViewClick{

    ImgZoomView* zoomV = [[ImgZoomView alloc] initWithFirstFrame:(CGRectMake(WIDTH-55, 64+10, 40, 40))];
    if ([UserModel shareUserModelManager].headerImage) {
        zoomV.currImg = [UserModel shareUserModelManager].headerImage;
    }else{
        zoomV.currImg = HEADER_IMG;
    }
    
    [zoomV show];
    zoomV.BlockClose = ^(BOOL done){
        
        headerImageView.hidden = NO;
    };
}

#pragma mark - 选择地区
- (void)PickerSelectorIndixString:(NSString *)str{

    [UserModel shareUserModelManager].userRegion = str;
    
    //一个cell刷新
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:5 inSection:0];
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NotificationHeaderIMGRefreash object:nil];
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
