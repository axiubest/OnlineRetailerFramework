
#import "XIU_WebViewController.h"
#import <WebKit/WebKit.h>


#import <CommonCrypto/CommonDigest.h>



#define XIUProgressH 1
#define XIUProgressW [UIScreen mainScreen].bounds.size.width
#define XIUProgressX 0
#define XIUProgressY 64

#define XIUProgressColor [UIColor redColor]


@interface XIU_WebViewController ()<WKNavigationDelegate>
{
    NSDate *_startReadTime;
    NSDate *_endReadTime;
    NSString *_readTime;
}
@property (nonatomic,weak) WKWebView *webView;
@property (nonatomic,weak) UIProgressView *progressView;

@end

@implementation XIU_WebViewController

//进度条
-(UIProgressView *)progressView{
    if (!_progressView) {
        UIProgressView *proView = [[UIProgressView alloc] initWithFrame:CGRectMake(XIUProgressX, XIUProgressY, XIUProgressW, XIUProgressH)];
        [self.view addSubview:proView];
        [proView setTrackTintColor:[UIColor clearColor]];
        proView.progressTintColor = XIUProgressColor;
        _progressView = proView;
    }
    return _progressView;
}

-(WKWebView *)webView{
    if(!_webView){
        
        WKWebViewConfiguration * Configuration = [[WKWebViewConfiguration alloc]init];
        
        Configuration.allowsAirPlayForMediaPlayback = YES;
        
        Configuration.allowsInlineMediaPlayback = YES;
        
        Configuration.selectionGranularity = YES;
        
        Configuration.suppressesIncrementalRendering = YES;
        
        WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, XIUProgressY, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-100-XIUProgressY) configuration:Configuration];
        
        [self.view addSubview:webView];
//        webView.UIDelegate = self;
        
        webView.navigationDelegate = self;
        _webView = webView;
    }
    return _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

}
-(void)setUrlStr:(NSString *)urlStr{
    _urlStr = urlStr;
    if ([urlStr isEqualToString:@""]||urlStr==nil) return;
    
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:10.0];
        
        [self.webView loadRequest:request];

        [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
}


#pragma mark ---WKUIDelegate----
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"begin");
    
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{

    self.title = webView.title;
    
    [self createWebReadStartTime];
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"加载失败");
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [self createWebReadStopTime];
}

#pragma mark ---监听进度条progresss----

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary*)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"loading"]) {
        
    } else if ([keyPath isEqualToString:@"title"]) {
        self.title = self.webView.title;
    } else if ([keyPath isEqualToString:@"URL"]) {
        
    } else if ([keyPath isEqualToString:@"estimatedProgress"]) {
        
        self.progressView.progress = self.webView.estimatedProgress;
    }
    
    if (object == self.webView && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        if (newprogress == 1) {
            self.progressView.progress = 1.0;
            [self.progressView removeFromSuperview];
        }
    }
}


#pragma mark ---前进----
-(void)goForward{
    
    if (self.webView.goForward) {
        [self.webView goForward];
    }
    
}
#pragma mark ---后退----
-(void)goBack{
    if (self.webView.goBack) {
        [self.webView goBack];
    }
}

#pragma mark ---刷新----
-(void)reload{
    [self.webView reload];
}

-(void)dealloc{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissViewControllerAnimated:YES completion:nil];
}




#pragma mark --文章阅读质量统计
- (void)createWebReadStartTime {
    

    _startReadTime = [NSDate date];
    
}

- (void)createWebReadStopTime {

    _endReadTime = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];

    unsigned int unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    NSDateComponents *day = [calendar components:unitFlags fromDate:_startReadTime toDate:_endReadTime options:0];
    
    NSInteger sec = [day hour]*3600+[day minute]*60+[day second];

    NSLog(@"当前阅读时间:%ld", sec);
    //request
}


@end
