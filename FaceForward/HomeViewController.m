//
//  HomeViewController.m
//  FaceForward
//
//  Created by Tim Crowley on 4/17/15.
//  Copyright (c) 2015 Tim Crowley. All rights reserved.
//

#import "HomeViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface HomeViewController ()

@end

@implementation HomeViewController {
    NSString *fbUserName;
}


-(IBAction)loadData:(id)sender {
    if ([FBSDKAccessToken currentAccessToken]) {
        NSMutableDictionary *d = [[NSMutableDictionary alloc] init];
        [d setObject:@"id,name" forKey:@"fields"];
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me"
                                           parameters:d]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error) {
                 NSDictionary *stuff = (NSDictionary *)result;
                 NSString *curUserId = [stuff objectForKey:@"id"];
                 fbUserName = [stuff objectForKey:@"name"];
                 userName.text = fbUserName;
                 //NSLog(@"fetched user:%@", result);
                 [self loadStream: curUserId];
             }
         }];
    }
    
}

-(void) loadStream: (NSString *)fbUserId {
    NSString *fullPath = [NSString stringWithFormat:@"%@/home", fbUserId];
    if ([FBSDKAccessToken currentAccessToken]) {
        [[[FBSDKGraphRequest alloc] initWithGraphPath:fullPath
                                           parameters:nil]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error) {
                 //NSLog(@"fetched crap:%@", result);
                 NSDictionary *top = (NSDictionary *)result;
                 NSArray *data = [top objectForKey:@"data"];
                 NSLog(@"Total items in feed: %lu", (unsigned long)data.count);
                 NSMutableString *everything = [NSMutableString stringWithFormat:@"<html><body>"];
                 for(int i = data.count-1; i >=0; i--) {
                     NSDictionary *curItem = [data objectAtIndex:i];
                     // Frank: Fix this next line of code!
                     //NSString *curId = [curItem objectForKey:@"id"];
                     NSString *curStory = [curItem objectForKey:@"story"];
                     NSString *picURL = [curItem objectForKey:@"picture"];
                     NSString *descr = [curItem objectForKey:@"description"];
                     NSDictionary *from = [curItem objectForKey:@"from"];
                     NSString *fromName = [from objectForKey:@"name"];
                     NSLog(@"From: %@ \r\nDescr:%@", fromName, descr);
                     [everything appendFormat:@"<p>Name:<br/>%@<br/>Story:<br/>%@<br/>", fromName,curStory];
                     if (picURL != nil) {
                         [everything appendFormat:@"Picture:<br/><img src=\"%@\"/><br/>", picURL];
                     }
                     [everything appendFormat:@"Description:<br/>%@<br/>", descr];
                     [everything appendString:@""];
                 }
                 [webView loadHTMLString:everything baseURL:nil];
             } else {
                 NSLog(@"you suck");
             }
         }];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    loginButton.readPermissions = @[@"read_stream"];
    CGPoint p = CGPointMake(self.view.center.x, 100);
    loginButton.center = p;
    [self.view addSubview:loginButton];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
