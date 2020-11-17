//
//  UIViewController+DAnimation.m
//  DPresentManager
//
//  Created by wudan on 2020/11/16.
//

#import "UIViewController+DAnimation.h"
#import "DAnimationModalTransitioningDelegate.h"
#import <objc/message.h>
#import "DAnimationModalConfiguration.h"

@implementation UIViewController (DAnimation)
/**
 显示一个模态视图控制器

 @param controller      模态视图控制器
 @param configBlock     模态窗口的配置信息
 @param completion      模态窗口显示完毕时的回调
*/
- (void)presentModalWithViewController:(UIViewController *_Nonnull)controller
configBlock:(DAnimationModalConfigBlock _Nullable )configBlock  completion:(DAnimationModalCompletionHandler _Nullable)completion{
    if (self.presentedViewController) { return; }
    DAnimationModalConfiguration *config = [DAnimationModalConfiguration defaultConfiguration];
    configBlock ? configBlock(config) : nil;
    
    controller.modalPresentationStyle = UIModalPresentationCustom;
    controller.preferredContentSize = config.contentSize;
    
    DAnimationModalTransitioningDelegate *transitioningDelegate = [DAnimationModalTransitioningDelegate transitioningDelegateWithConfiguration:config];
    controller.transitioningDelegate = transitioningDelegate;
    objc_setAssociatedObject(controller, _cmd, transitioningDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self presentViewController:controller animated:true completion:completion];
}

/**
 显示一个模态视图

 @param view             内容视图
 @param configBlock      模态窗口的配置信息
 @param completion       模态窗口显示完毕时的回调
*/
- (void)presentModalWithView:(UIView *_Nonnull)view configBlock:(DAnimationModalConfigBlock _Nullable )configBlock completion:(DAnimationModalCompletionHandler _Nullable)completion NS_AVAILABLE_IOS(8_0) {
    UIViewController *modalVC = [[UIViewController alloc] init];
    modalVC.view.backgroundColor = [UIColor clearColor];
    [modalVC.view addSubview:view];
    
    view.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *views = @{@"view": view};
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:views]];
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:views]];
    
      [self presentModalWithViewController:modalVC configBlock:configBlock completion:completion];
}
@end
