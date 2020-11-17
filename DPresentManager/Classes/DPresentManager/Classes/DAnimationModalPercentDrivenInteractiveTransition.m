//
//  DAnimationModalPercentDrivenInteractiveTransition.m
//  DPresentManager
//
//  Created by wudan on 2020/11/16.
//

#import "DAnimationModalPercentDrivenInteractiveTransition.h"
#import "DAnimationModalConfiguration.h"

@interface DAnimationModalPercentDrivenInteractiveTransition ()
@property (nonatomic, strong) DAnimationModalConfiguration *configuration;
@property (nonatomic, strong) id<UIViewControllerContextTransitioning> transitionContext;
@property (nonatomic, assign) CGPoint beganTouchPoint;
@end

@implementation DAnimationModalPercentDrivenInteractiveTransition
+ (instancetype)interactiveTransitionWithConfiguration:(DAnimationModalConfiguration *)configuration {
    DAnimationModalPercentDrivenInteractiveTransition *interactiveTransition = [[DAnimationModalPercentDrivenInteractiveTransition alloc] init];
    interactiveTransition.configuration = configuration;
    [configuration.panGestureRecognizer addTarget:interactiveTransition action:@selector(gestureRecognizeDidUpdate:)];
    return interactiveTransition;
}

/// 重写以便获取到上下文参数
- (void)startInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    _transitionContext = transitionContext;
    [super startInteractiveTransition:transitionContext];
}

/// 手势事件
- (void)gestureRecognizeDidUpdate:(UIPanGestureRecognizer *)sender {
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
            // 开始状态由`XPModalPresentationController`进行处理,不会走到这里
            break;
        case UIGestureRecognizerStateChanged: {
            if (CGPointEqualToPoint(_beganTouchPoint, CGPointZero)) {
                _beganTouchPoint = [sender locationInView:_transitionContext.containerView];
            }
            CGFloat percent = [self percentForGesture:sender];
            [self updateInteractiveTransition:percent];
            break;
        }
        case UIGestureRecognizerStateEnded: {
            CGFloat percent = [self percentForGesture:sender];
            _beganTouchPoint = CGPointZero;
            if (percent >= 0.3) {
                [self finishInteractiveTransition];
            } else {
                [self cancelInteractiveTransition];
            }
            break;
        }
        default:
            _beganTouchPoint = CGPointZero;
            [self cancelInteractiveTransition];
            break;
    }
}

/// 计算手势滑动百分比
- (CGFloat)percentForGesture:(UIPanGestureRecognizer *)sender {
    UIView *modalView = [_transitionContext viewForKey:UITransitionContextFromViewKey];
    CGPoint currentPoint = [sender locationInView:_transitionContext.containerView];
    CGFloat width = modalView.bounds.size.width;
    CGFloat height = modalView.bounds.size.height;
    
    switch (_configuration.direction) {
        case DAnimationModalConfigurationTop:
            if (currentPoint.y < _beganTouchPoint.y) {
                return (_beganTouchPoint.y - currentPoint.y) / height;
            }
            break;
        case DAnimationModalConfigurationRight:
            if (currentPoint.x > _beganTouchPoint.x) {
                return (currentPoint.x - _beganTouchPoint.x) / width;
            }
            break;
        case DAnimationModalConfigurationBottom:
            if (currentPoint.y > _beganTouchPoint.y) {
                return (currentPoint.y - _beganTouchPoint.y) / height;
            }
            break;
        case DAnimationModalConfigurationLeft:
            if (currentPoint.x < _beganTouchPoint.x) {
                return (_beganTouchPoint.x - currentPoint.x) / width;
            }
            break;
        case DAnimationModalConfigurationCenter:
            // Not support.
            break;
    }
    return 0.0;
}
@end
