//
//  ViewController.m
//  WKWebView
//
//  Created by DongpoRen on 16/11/18.
//  Copyright © 2016年 DongpoRen. All rights reserved.
//

#import "ViewController.h"
#import "RDPWebViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor blueColor];
}

/* 加载网页:
 0. 使用safari.但是需要跳转到另一个程序;
 1. 使用UIWebView,但是功能很少;
 2. 使用 SafariServices/SafariServices.h, SFSafariViewController.功能很完善,但是只能够ios9 才能使用.
 
 if (![urlStr containsString:@"http"]) return;
 
 SFSafariViewController *VC = [[SFSafariViewController alloc] initWithURL:url];
 [self.navigationController pushViewController:VC animated:YES];
 
 
 
 3. 使用WKWebView:8.0
 导入WebKit/WebKit.h,
 
 
 */


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSString *urlStr = @"http://www.baidu.com/";
    NSURL *url = [NSURL URLWithString:urlStr];
    RDPWebViewController *webVC = [[RDPWebViewController alloc] init];
    webVC.url = url;
    [self.navigationController pushViewController:webVC animated:YES];
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

@end
