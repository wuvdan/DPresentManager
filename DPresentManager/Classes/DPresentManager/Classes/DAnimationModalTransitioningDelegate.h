//
//  DAnimationModalTransitioningDelegate.h
//  DPresentManager
//
//  Created by wudan on 2020/11/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class DAnimationModalConfiguration;

@interface DAnimationModalTransitioningDelegate : NSObject<UIViewControllerTransitioningDelegate>

+ (instancetype)transitioningDelegateWithConfiguration:(DAnimationModalConfiguration * _Nonnull)configuration;

@end

NS_ASSUME_NONNULL_END
