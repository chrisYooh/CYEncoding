//
//  ViewController.m
//  CYEncoding
//
//  Created by Chris Yang on 2020/9/23.
//

#import "CYCommTool.h"

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 字符串转 utf-8 并打印二进制数据
    printf("测试1：字符串进行UTF-8编码👇\n\n");
    cytLogStringData(@"今儿个真Happy！", NSUTF8StringEncoding);
    
//    // 字符串进行 base64 编码的流程
//    printf("测试2：字符串进行base64编码的流程👇\n\n");
//    cytLogStringData_base64_flow(@"今儿个真Happy！");
}

@end
