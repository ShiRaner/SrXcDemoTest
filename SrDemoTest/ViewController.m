//
//  ViewController.m
//  SrDemoTest
//
//  Created by shiran on 2020/9/14.
//

#import "ViewController.h"
#import <XcSDKTest/XcLog.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    NSString * str = [[[XcLog alloc]init] xcLog];
       NSLog( @"\n ====== %@",str);
    
    
}

 
@end
