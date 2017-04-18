//
//  BaseWebViewController.m
//  JRZN
//
//  Created by 曾国锐 on 16/5/11.
//  Copyright © 2016年 曾国锐. All rights reserved.
//

#import "BaseWebViewController.h"

@interface BaseWebViewController ()<UIWebViewDelegate>

@end

@implementation BaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = NO;
    
    if (_webViewStaticApi.length > 0) {
        _webViewDynamicApi = _webViewStaticApi;
        [self makeWebView];
    }else{
        [self loadData];
    }
    
    
    // Do any additional setup after loading the view.
}

- (void)loadData{

}

- (void)makeWebView{
    
    UIWebView*webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT-64)];
    webView.delegate = self;
    //以上加载我们会看到一个变形的网页，使用下面属性自动适配
    webView.scalesPageToFit=YES;
    
    
    //监测所有数据类型：设定电话号码、网址、电子邮件和日期等文字变为链接文字
    [webView setDataDetectorTypes:UIDataDetectorTypeAll];
    
    NSURL * url=[NSURL URLWithString:_webViewDynamicApi];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    webView.backgroundColor = kViewBackgroundColor;
    
    [self.view addSubview:webView];
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    

}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
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
