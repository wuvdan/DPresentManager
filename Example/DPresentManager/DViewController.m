//
//  DViewController.m
//  DPresentManager
//
//  Created by wuvdan on 11/16/2020.
//  Copyright (c) 2020 wuvdan. All rights reserved.
//

#import "DViewController.h"
#import <DPresentManager.h>
#import "OneViewController.h"

@interface DViewController ()

@end

@implementation DViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)topButtonAction:(id)sender {
    [self showViewWithType:0];
}

- (IBAction)leftButtonAction:(id)sender {
    [self showViewWithType:3];
}

- (IBAction)rigthButtonAction:(id)sender {
    [self showViewWithType:1];
}

- (IBAction)centerButtonAction:(id)sender {
    [self showViewWithType:4];
}

- (IBAction)bottomButtonAction:(id)sender {
    [self showViewWithType:2];
}

- (void)showViewWithType:(NSInteger)type {
    NSBundle *bundle = [NSBundle bundleForClass:[OneViewController class]];
    OneViewController *vc = [[OneViewController alloc] initWithNibName:@"OneViewController" bundle:bundle];
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
    
    [self presentModalWithViewController:nvc configBlock:^(DAnimationModalConfiguration * _Nonnull configuration) {
        switch (type) {
            case 0:
                configuration.direction = DAnimationModalConfigurationTop;
                configuration.contentSize = CGSizeMake(CGFLOAT_MAX, 380);
                break;
            case 1:
                configuration.direction = DAnimationModalConfigurationRight;
                configuration.contentSize = CGSizeMake(380, CGFLOAT_MAX);
                break;
            case 2:
                configuration.direction = DAnimationModalConfigurationBottom;
                configuration.enableInteractiveTransitioning = YES;
                configuration.enableBackgroundAnimation = YES;
                configuration.backgroundColor = [UIColor purpleColor];
                configuration.contentSize = CGSizeMake(CGFLOAT_MAX, 380);
                break;
            case 3:
                configuration.direction = DAnimationModalConfigurationLeft;
                configuration.contentSize = CGSizeMake(380, [UIScreen mainScreen].bounds.size.height);
                break;
            case 4:
                configuration.direction = DAnimationModalConfigurationCenter;
                configuration.contentSize = CGSizeMake(380, 330);
                break;
            default: return;
        }
    } completion:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
