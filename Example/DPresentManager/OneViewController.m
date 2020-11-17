//
//  OneViewController.m
//  DPresentManager_Example
//
//  Created by wudan on 2020/11/16.
//  Copyright © 2020 wuvdan. All rights reserved.
//

#import "OneViewController.h"
#import "TwoViewController.h"

@interface OneViewController ()<UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *payButton;
@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.payButton.layer.cornerRadius = 15;
    self.navigationController.delegate = self;
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}

- (IBAction)closeButtonAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)selectedPayWayButtonAction:(id)sender {
    NSBundle *bundle = [NSBundle bundleForClass:[TwoViewController class]];
    TwoViewController *vc = [[TwoViewController alloc] initWithNibName:@"TwoViewController" bundle:bundle];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    NSLog(@"%@", self.payButton);
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
