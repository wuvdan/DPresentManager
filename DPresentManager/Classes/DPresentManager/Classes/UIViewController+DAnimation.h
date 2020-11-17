//
//  UIViewController+DAnimation.h
//  DPresentManager
//
//  Created by wudan on 2020/11/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class DAnimationModalConfiguration;

/** 配置的Block */
typedef void (^DAnimationModalConfigBlock)(DAnimationModalConfiguration * _Nonnull configuration);

typedef void(^DAnimationModalCompletionHandler)(void);

@interface UIViewController (DAnimation)
/**
 显示一个模态视图控制器
 
 @param controller      模态视图控制器
 @param configBlock     模态窗口的配置信息
 @param completion      模态窗口显示完毕时的回调
 */
- (void)presentModalWithViewController:(UIViewController *_Nonnull)controller configBlock:(DAnimationModalConfigBlock _Nullable )configBlock  completion:(DAnimationModalCompletionHandler _Nullable)completion;

/**
 显示一个模态视图
 
 @param view             内容视图
 @param configBlock      模态窗口的配置信息
 @param completion       模态窗口显示完毕时的回调
 */
- (void)presentModalWithView:(UIView *_Nonnull)view configBlock:(DAnimationModalConfigBlock _Nullable )configBlock completion:(DAnimationModalCompletionHandler _Nullable)completion;
@end

NS_ASSUME_NONNULL_END
