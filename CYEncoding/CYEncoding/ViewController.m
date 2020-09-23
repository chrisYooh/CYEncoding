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
    
    cytLogStringData(@"今儿个真开心！", NSUTF8StringEncoding);
}


@end
