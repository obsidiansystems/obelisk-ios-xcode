#import "ViewController.h"

extern void callWithWebView(WKWebView *, HsStablePtr);

@interface ViewController ()

@end

@implementation ViewController

-(id)initWithHandler:(HsStablePtr)handler {
    self = [super init];
    if (self) {
        _handler = handler;
    }
    return self;
}

- (void)loadView {
    [super loadView];
    _webView = [[WKWebView alloc] init];
    _webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    if (@available(iOS 16.4, *)) {
      _webView.inspectable = NO;
    }else {
    }
    self.view = _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    callWithWebView(_webView, _handler);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

