//
//  DAnimationModalAnimatedTransitioning.m
//  DPresentManager
//
//  Created by wudan on 2020/11/16.
//

#import "DAnimationModalAnimatedTransitioning.h"
#import "DAnimationModalConfiguration.h"

@implementation DAnimationModalAnimatedTransitioning
+ (instancetype)transitioningWithConfiguration:(DAnimationModalConfiguration *)configuration isPresentation:(BOOL)presentation {
    DAnimationModalAnimatedTransitioning *transitioning = [[DAnimationModalAnimatedTransitioning alloc] init];
    transitioning.configuration = configuration;
    transitioning.presentation = presentation;
    return transitioning;
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return self.configuration.animationDuration;
}

- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    BOOL isPresentation = self.isPresentation;
    if (isPresentation && toView) {
        [transitionContext.containerView addSubview:toView];
    }
    
    UIViewController *animatingVC = isPresentation ? toVC : fromVC;
    CGRect finalFrame = [transitionContext finalFrameForViewController:animatingVC];
    UIView *animatingView = isPresentation ? toView : fromView;
    
    switch (_configuration.direction) {
        case DAnimationModalConfigurationTop:
            animatingView.frame = isPresentation ? CGRectOffset(finalFrame, 0.0, -finalFrame.size.height) : finalFrame;
            break;
        case DAnimationModalConfigurationRight:
            animatingView.frame = isPresentation ? CGRectOffset(finalFrame, finalFrame.size.width, 0.0) : finalFrame;
            break;
        case DAnimationModalConfigurationBottom:
            animatingView.frame = isPresentation ? CGRectOffset(finalFrame, 0.0, finalFrame.size.height) : finalFrame;
            break;
        case DAnimationModalConfigurationLeft:
            animatingView.frame = isPresentation ? CGRectOffset(finalFrame, -finalFrame.size.width, 0.0) : finalFrame;
            break;
        case DAnimationModalConfigurationCenter:
            animatingView.frame = finalFrame;
            animatingView.alpha = isPresentation ? 0.0 : 1.0;
            break;
    }
    
    [UIView animateWithDuration:self.configuration.animationDuration delay:0.0 options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState animations:^{
        switch (self.configuration.direction) {
            case DAnimationModalConfigurationTop:
                animatingView.frame = isPresentation ? finalFrame : CGRectOffset(finalFrame, 0.0, -finalFrame.size.height);
                break;
            case DAnimationModalConfigurationRight:
                animatingView.frame = isPresentation ? finalFrame : CGRectOffset(finalFrame, finalFrame.size.width, 0.0);
                break;
            case DAnimationModalConfigurationBottom:
                animatingView.frame = isPresentation ? finalFrame : CGRectOffset(finalFrame, 0.0, finalFrame.size.height);
                break;
            case DAnimationModalConfigurationLeft:
                animatingView.frame = isPresentation ? finalFrame : CGRectOffset(finalFrame, -finalFrame.size.width, 0.0);
                break;
            case DAnimationModalConfigurationCenter:
                animatingView.alpha = isPresentation ? 1.0 : 0.0;
                break;
        }
    } completion:^(BOOL finished) {
        BOOL wasCancelled = [transitionContext transitionWasCancelled];
        if (!self.isPresentation && !wasCancelled) {
            [fromView removeFromSuperview];
        }
        [transitionContext completeTransition:!wasCancelled];
    }];
}
@end
