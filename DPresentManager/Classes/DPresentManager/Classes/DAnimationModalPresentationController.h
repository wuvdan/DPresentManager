//
//  DAnimationModalPresentationController.h
//  DPresentManager
//
//  Created by wudan on 2020/11/16.
//


#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN
@class DAnimationModalConfiguration;

@interface DAnimationModalPresentationController : UIPresentationController
@property (nonatomic, strong) DAnimationModalConfiguration *configuration;

@end

NS_ASSUME_NONNULL_END
