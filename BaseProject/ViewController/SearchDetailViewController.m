//
//  SearchDetailViewController.m
//  BaseProject
//
//  Created by apple-jd26 on 15/11/11.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "SearchDetailViewController.h"
#import "Factory.h"

@interface SearchDetailViewController ()<UIWebViewDelegate>

@property (nonatomic, strong)UIWebView *webView;

@end

@implementation SearchDetailViewController

- (UIWebView *)webView{
    if (!_webView) {
        _webView = [UIWebView new];
        _webView.delegate = self;
        [self.view addSubview:_webView];
        [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    return _webView;
}
- (id)initWithRequest:(NSURLRequest *)request{
    if (self = [super init]) {
        self.request = request;
        /** 推出不显示下边栏 */
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    /** 返回按钮 */
    [Factory addBackItemToVC:self];
    self.title = @"召唤师详情";
    [self.navigationController.navigationBar setBackgroundColor:[UIColor blackColor]];
    
    [self.webView loadRequest:_request];
}

#pragma mark - webView
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    if (navigationType != 5) {
        SearchDetailViewController *detailVC = [[SearchDetailViewController alloc]initWithRequest:request];
        [self.navigationController pushViewController:detailVC animated:YES];
        return NO;
    }
    
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    [self showProgress];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self hideProgress];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error{
    [self hideProgress];
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
