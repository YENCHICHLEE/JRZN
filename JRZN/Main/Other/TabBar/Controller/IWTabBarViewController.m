//
//  IWTabBarViewController.m
//  ItcastWeibo
//
//  Created by apple on 14-5-5.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWTabBarViewController.h"
#import "IWTabBar.h"
#import "IWTabBarButton.h"
#import "HomeViewController.h"
#import "InformationViewController.h"
#import "BBSViewController.h"
#import "UserViewController.h"
#import "ZGRNavigationController.h"

@interface IWTabBarViewController () <IWTabBarDelegate>{

}

/**
 *  自定义的tabbar
 */
@property (nonatomic, weak) IWTabBar *customTabBar;
@property (nonatomic, strong) IWTabBar *zgrtabBar;
@property (nonatomic, strong) IWTabBarButton *selectedButton;
/**
*   照片
*/
@property (nonatomic, strong) NSMutableArray *photosArray;
@property (nonatomic, copy) NSString *tempUrl;
@end

@implementation IWTabBarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 初始化tabbar
    [self setupTabbar];
    
    // 初始化所有的子控制器
    [self setupAllChildViewControllers];
    
    @weakify(self)
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:NotificationRegisteredSuccessRefreash object:nil] subscribeNext:^(id x) {

        NSNotification *notification = x;
        
        @strongify(self)
        self.selectedIndex = [notification.object integerValue];
        self.selectedButton.selected = NO;
        
        for (int i= 0; i<self.zgrtabBar.tabBarButtons.count; i++) {
            if (i == [notification.object integerValue]) {
                
                IWTabBarButton *button =  self.zgrtabBar.tabBarButtons[i];
                button.selected = YES;
                self.selectedButton = button;
                
            }else{
                IWTabBarButton *buttonOther =  self.zgrtabBar.tabBarButtons[i];
                buttonOther.selected = NO;
                
            }
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 删除系统自动生成的UITabBarButton
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}

/**
 *  初始化tabbar
 */
- (void)setupTabbar
{
    IWTabBar *customTabBar = [[IWTabBar alloc] init];
    customTabBar.frame = self.tabBar.bounds;
    customTabBar.delegate = self;
    [self.tabBar addSubview:customTabBar];
    self.customTabBar = customTabBar;
}

/**
 *  监听tabbar按钮的改变
 *  @param from   原来选中的位置
 *  @param to     最新选中的位置
 */
- (void)tabBar:(IWTabBar *)tabBar didSelectedButtonFrom:(int)from to:(int)to
{
//    self.selectedIndex = to;
}

- (void)tabBar:(IWTabBar *)tabBar didSelectedButtonFrom:(int)from to:(int)to withButton:(IWTabBarButton *)button withSelectedButton:(IWTabBarButton *)selectedButton{

    self.zgrtabBar = tabBar;

    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
    
    self.selectedIndex = to;
//    if (to == 2 || to == 1 || to == 3) {
////        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
////        
////        if (![user objectForKey:@"isLogin"]) {
////            
////            NewLoginViewViewController *vc = [[NewLoginViewViewController alloc] init];
////            vc.isTarBarLogin = @"Yes";
////            vc.title = @"登录";
////            
////            JSHNavigationController *nav = [[JSHNavigationController alloc] initWithRootViewController:vc];
////            [self presentViewController:nav animated:YES completion:nil];
////            return;
////            
////        }else{
//    
//            self.selectedIndex = to;
//        }else{
////        //告诉我哪个位置对应的子控制器 选中对应位置的子控制器
//        self.selectedIndex = to;
//    }
}

- (void)didSelectedPopView:(UIButton *)btn{
    
//    IWTabBar *tab = [[IWTabBar alloc] init];
    
}



/**
 *  初始化所有的子控制器
 */
- (void)setupAllChildViewControllers
{
    // 首页
    HomeViewController *home = [[HomeViewController alloc] init];
//    home.tabBarItem.badgeValue = @"12";
    [self setupChildViewController:home title:@"首页" imageName:@"icon_tab_sy.png" selectedImageName:@"icon_tab_sy2.png"];
    
    // 资讯
    InformationViewController * message = [[InformationViewController alloc] init];
//    message.tabBarItem.badgeValue = @"new";
    [self setupChildViewController:message title:@"资讯" imageName:@"icon_tab_zx.png" selectedImageName:@"icon_tab_zx2.png"];
    
    
    // 论坛
    BBSViewController * discover = [[BBSViewController alloc] init];
//    discover.tabBarItem.badgeValue = @"9";
    [self setupChildViewController:discover title:@"论坛" imageName:@"icon_tab_lt.png" selectedImageName:@"icon_tab_lt2.png"];
    
    
    // 我的
    UserViewController * me = [[UserViewController alloc] init];
//    me.tabBarItem.badgeValue = @"100";
    [self setupChildViewController:me title:@"我的" imageName:@"icon_tab_wd.png" selectedImageName:@"icon_tab_wd2.png"];
    
}

/**
 *  初始化一个子控制器
 *
 *  @param childVc           需要初始化的子控制器
 *  @param title             标题
 *  @param imageName         图标
 *  @param selectedImageName 选中的图标
 */
- (void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    // 1.设置控制器的属性
   // childVc.title = title;
      childVc.tabBarItem.title = title;
    // 设置图标
    childVc.tabBarItem.image = [UIImage imageWithName:imageName];
    // 设置选中的图标
    UIImage *selectedImage = [UIImage imageWithName:selectedImageName];
    if (iOS7) {
        childVc.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    } else {
        childVc.tabBarItem.selectedImage = selectedImage;
    }
    
    self.tabBar.backgroundImage = [UIImage imageNamed:@"bg_tab.png"];
    
    // 2.包装一个导航控制器
    ZGRNavigationController *nav = [[ZGRNavigationController alloc] initWithRootViewController:childVc];
//    nav.popAnimationType = PopAnimationTypeliner;
    [self addChildViewController:nav];
    
    // 3.添加tabbar内部的按钮
    [self.customTabBar addTabBarButtonWithItem:childVc.tabBarItem];
}

@end
