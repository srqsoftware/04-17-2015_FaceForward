//
//  HomeViewController.h
//  FaceForward
//
//  Created by Tim Crowley on 4/17/15.
//  Copyright (c) 2015 Tim Crowley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController {
    
    __weak IBOutlet UILabel *userName;
    __weak IBOutlet UIWebView *webView;
}

-(IBAction)loadData:(id)sender;

@end
