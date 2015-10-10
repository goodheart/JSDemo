//
//  ViewController.m
//  JSDemo
//
//  Created by majian on 15/10/10.
//  Copyright © 2015年 majian. All rights reserved.
//

#import "ViewController.h"
#import "WebViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSURL * url = [[NSBundle mainBundle] URLForResource:@"index" withExtension:@"html"];
    WebViewController * webViewController = [WebViewController webViewControllerWithDestinationURL:url];
    [self.navigationController pushViewController:webViewController
                                         animated:YES];
    
//    [self presentViewController:webViewController animated:YES completion:nil];
    
}



@end







