//
//  ViewController.m
//  FaceForward
//
//  Created by Tim Crowley on 4/17/15.
//  Copyright (c) 2015 Tim Crowley. All rights reserved.
//

#import "ViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface ViewController ()

@end

@implementation ViewController

-(IBAction)loadData:(id)sender {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
//    loginButton.readPermissions = @[@"email", ];
    CGPoint p = CGPointMake(self.view.center.x, 100);
    loginButton.center = p;
    [self.view addSubview:loginButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
