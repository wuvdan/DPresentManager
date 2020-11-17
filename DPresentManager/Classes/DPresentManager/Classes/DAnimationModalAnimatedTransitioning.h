//
//  DAnimationModalAnimatedTransitioning.h
//  DPresentManager
//
//  Created by wudan on 2020/11/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class DAnimationModalConfiguration;

@interface DAnimationModalAnimatedTransitioning : NSObject<UIViewControllerAnimatedTransitioning>
@property (nonatomic, assign, getter=isPresentation) BOOL presentation;
@property (nonatomic, strong) DAnimationModalConfiguration *configuration;

+ (instancetype)transitioningWithConfiguration:(DAnimationModalConfiguration *)configuration isPresentation:(BOOL)presentation;
@end

NS_ASSUME_NONNULL_END
