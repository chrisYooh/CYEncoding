//
//  ViewController.m
//  CYEncoding
//
//  Created by Chris Yang on 2020/9/23.
//

#import "GTMBase64.h"
#import "CYCommTool.h"

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    cytLogStringData(@"今儿个真开心！", NSUTF8StringEncoding);
    vytLogStringData_base64_utf8(@"今儿个真开心！");
    vytLogStringData_base64_orig(@"今儿个真开心！");
}

@end
