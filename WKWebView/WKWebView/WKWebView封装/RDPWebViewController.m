//
//  RDPWebViewController.m
//  RDPBuDeJie
//
//  Created by DongpoRen on 16/11/17.
//  Copyright © 2016年 DongpoRen. All rights reserved.
//

#import "RDPWebViewController.h"
#import <WebKit/WebKit.h>

@interface RDPWebViewController ()
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwardItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *refreshItem;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

/**  webview  */
@property (nonatomic,weak) WKWebView *webview;

@end

@implementation RDPWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    WKWebView *webview = [[WKWebView alloc] init];
    _webview = webview;
    [self.contentView addSubview:webview];
    
    // 加载webview内容
    NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
    [webview loadRequest:request];
    webview.scrollView.backgroundColor = [UIColor clearColor];

    // 使用kvo进行监听 back, forward, title, progress
    [_webview addObserver:self forKeyPath:@"canGoBack" options:NSKeyValueObservingOptionNew context:nil];
    [_webview addObserver:self forKeyPath:@"canGoForward" options:NSKeyValueObservingOptionNew context:nil];
    [_webview addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [_webview addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
}

#pragma mark - 移除监听
- (void)dealloc {
    [_webview removeObserver:self forKeyPath:@"canGoBack" context:nil];
    [_webview removeObserver:self forKeyPath:@"canGoForward" context:nil];
    [_webview removeObserver:self forKeyPath:@"title" context:nil];
    [_webview removeObserver:self forKeyPath:@"estimatedProgress" context:nil];
}

#pragma mark - 监听新值的变化
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    _backItem.enabled = _webview.canGoBack;
    _forwardItem.enabled = _webview.canGoForward;
    self.title = _webview.title;
    
    _progressView.progress = _webview.estimatedProgress;
    
    if (_progressView.progress >= 1) {
        _progressView.hidden = YES;
    }
}

#pragma mark - 按钮的点击
- (IBAction)backClick:(id)sender {
    [_webview goBack];
    
}
- (IBAction)forwardClick:(id)sender {
    [_webview goForward];
}

- (IBAction)refresh:(id)sender {
    [_webview reload];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _webview.frame = self.contentView.bounds;
}

@end
