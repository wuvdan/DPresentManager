//
//  TwoViewController.m
//  DPresentManager_Example
//
//  Created by wudan on 2020/11/16.
//  Copyright © 2020 wuvdan. All rights reserved.
//

#import "TwoViewController.h"

@interface TwoViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.tableView registerClass:NSClassFromString(@"UITableViewCell") forCellReuseIdentifier:@"UITableViewCell"];
    self.tableView.rowHeight = 80;
    self.tableView.tableFooterView = [[UIView alloc] init];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = @[@"支付宝", @"微信"][indexPath.row];
    if (@available(iOS 13.0, *)) {
        cell.imageView.image = [UIImage systemImageNamed:@"book.fill"];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
