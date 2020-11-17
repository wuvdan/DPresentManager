//
//  DAnimationModalPercentDrivenInteractiveTransition.h
//  DPresentManager
//
//  Created by wudan on 2020/11/16.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@class DAnimationModalConfiguration;

@interface DAnimationModalPercentDrivenInteractiveTransition : UIPercentDrivenInteractiveTransition
+ (instancetype)interactiveTransitionWithConfiguration:(DAnimationModalConfiguration * _Nonnull)configuration;
@end

NS_ASSUME_NONNULL_END
