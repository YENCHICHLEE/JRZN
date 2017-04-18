//
//  TextWebViewController.m
//  JRZN
//
//  Created by 曾国锐 on 16/6/15.
//  Copyright © 2016年 曾国锐. All rights reserved.
//

#import "TextWebViewController.h"
#import "WebViewJavascriptBridge.h"

@interface TextWebViewController ()<UIWebViewDelegate>

@property (nonatomic, strong)WebViewJavascriptBridge *bridge;

@end

@implementation TextWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self makeWebView];
    // Do any additional setup after loading the view.
}

- (void)makeWebView{
    
    UIWebView*webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-64)];
    webView.delegate = self;
    //以上加载我们会看到一个变形的网页，使用下面属性自动适配
    webView.scalesPageToFit=YES;
    
    
    //监测所有数据类型：设定电话号码、网址、电子邮件和日期等文字变为链接文字
    [webView setDataDetectorTypes:UIDataDetectorTypeAll];
    
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"ExampleApp" ofType:@"html"];
    NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    [webView loadHTMLString:htmlString baseURL:[NSURL URLWithString:filePath]];
    
    webView.backgroundColor = kViewBackgroundColor;
    
    [self.view addSubview:webView];
    
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:webView];
    
    @weakify(self)
    [self.bridge registerHandler:@"testObjcCallback" handler:^(id data, WVJBResponseCallback responseCallback) {
        @strongify(self)
        DDLog(@"----%@----%@",data,responseCallback);
        [self text];
    }];
    
    [self.bridge registerHandler:@"functionInJs" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        DDLog(@"----%@----%@",data,responseCallback);
        
    }];
    
}

- (void)text{
    DDLog(@"text");
    UIViewController *vc = [NSClassFromString(@"OpinionColumnsViewController") new];
    [self.navigationController pushViewController:vc animated:YES];
    
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
