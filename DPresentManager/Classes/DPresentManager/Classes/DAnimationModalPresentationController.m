//
//  DAnimationModalPresentationController.m
//  DPresentManager
//
//  Created by wudan on 2020/11/16.
//

#import "DAnimationModalPresentationController.h"
#import "DAnimationModalConfiguration.h"

@interface DAnimationModalPresentationController ()
/// 背景图片视图
@property (nonatomic, strong) UIImageView *backgroundView;
/// 背景半透明效果视图
@property (nonatomic, strong) UIView *dimmingView;
/// 执行背景动画的动画视图
@property (nonatomic, strong) UIView *animatingView;
/// 是否正在交互
@property (nonatomic, assign, getter=isInteractiving) BOOL interactiving;
@end

@implementation DAnimationModalPresentationController
- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController {
    self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController];
    if (self) {
        _backgroundView = [[UIImageView alloc] init];
        _dimmingView = [[UIView alloc] init];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognizerAction:)];
        [_dimmingView addGestureRecognizer:tapGesture];
    }
    return self;
}

/// 弹窗视图的最终frame
- (CGRect)frameOfPresentedViewInContainerView {
    CGRect presentedViewFrame = CGRectZero;
    CGFloat const containerWidth = self.containerView.bounds.size.width;
    CGFloat const containerHeight = self.containerView.bounds.size.height;
    CGFloat width = MIN(containerWidth, self.presentedViewController.preferredContentSize.width);
    CGFloat height = MIN(containerHeight, self.presentedViewController.preferredContentSize.height);
    presentedViewFrame.size = CGSizeMake(width, height);
    
    CGFloat x = 0.0, y = 0.0;
    switch (_configuration.direction) {
        case DAnimationModalConfigurationCenter:
            x = (containerWidth - width) / 2;
            y = (containerHeight - height) / 2;
            break;
        case DAnimationModalConfigurationTop:
            x = (containerWidth - width) / 2;
            break;
        case DAnimationModalConfigurationRight:
            x = containerWidth - width;
            y = (containerHeight - height) / 2;
            break;
        case DAnimationModalConfigurationBottom:
            x = (containerWidth - width) / 2;
            y = containerHeight - height;
            break;
        case DAnimationModalConfigurationLeft:
            y = (containerHeight - height) / 2;
            break;
    }
    presentedViewFrame.origin = CGPointMake(x, y);
    
    return presentedViewFrame;
}

- (void)containerViewWillLayoutSubviews {
    [super containerViewWillLayoutSubviews];
    _backgroundView.frame = self.containerView.bounds;
    _dimmingView.frame = self.containerView.bounds;
    self.presentedView.frame = [self frameOfPresentedViewInContainerView];
}

/// 即将显示弹窗(显示的动画)
- (void)presentationTransitionWillBegin {
    [super presentationTransitionWillBegin];
    
    // 启用背景动画
    if (_configuration.isEnableBackgroundAnimation) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        NSAssert(window != nil, @"UIApplication keyWindow is nil.");
        UIView *snapshotView = [window snapshotViewAfterScreenUpdates:YES];
        _animatingView = snapshotView;
        [_backgroundView addSubview:snapshotView];
        snapshotView.translatesAutoresizingMaskIntoConstraints = NO;
        NSDictionary *views = @{@"snapshotView": snapshotView};
        [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[snapshotView]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:views]];
        [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[snapshotView]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:views]];
        
        _backgroundView.backgroundColor = _configuration.backgroundColor;
        _backgroundView.image = _configuration.backgroundImage;
        [self.containerView addSubview:_backgroundView];
    }
    
    // 添加阴影效果
    if (_configuration.isEnableShadow) {
        CGFloat shadowWidth = ABS(_configuration.shadowWidth);
        switch (_configuration.direction) {
            case DAnimationModalConfigurationTop:
                self.presentedView.layer.shadowOffset = CGSizeMake(shadowWidth, shadowWidth);
                break;
            case DAnimationModalConfigurationRight:
                self.presentedView.layer.shadowOffset = CGSizeMake(-shadowWidth, shadowWidth);
                break;
            default:
                self.presentedView.layer.shadowOffset = CGSizeMake(shadowWidth, -shadowWidth);
                break;
        }
        self.presentedView.layer.shadowColor = _configuration.shadowColor.CGColor;
        self.presentedView.layer.shadowRadius = _configuration.shadowRadius;
        self.presentedView.layer.shadowOpacity = _configuration.shadowOpacity;
        self.presentedView.layer.shouldRasterize = true;
        self.presentedView.layer.rasterizationScale = [UIScreen mainScreen].scale;
    }
    
    // 启用手势交互功能
    if (_configuration.isEnableInteractiveTransitioning && _configuration.direction != DAnimationModalConfigurationCenter) {
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognizerAction:)];
        [self.containerView addGestureRecognizer:panGesture];
        _configuration.panGestureRecognizer = panGesture;
    }
    
    _dimmingView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:_configuration.backgroundOpacity];
    _dimmingView.alpha = 0.0;
    [self.containerView addSubview:_dimmingView];
    
    [self.presentedViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        self.dimmingView.alpha = 1.0;
        if (self.configuration.isEnableBackgroundAnimation) {
            CAAnimationGroup *group = [self backgroundTranslateAnimationWithForward:YES];
            [self.animatingView.layer addAnimation:group forKey:nil];
        }
    } completion:nil];
}

/// 即将关闭弹窗(消失动画)
- (void)dismissalTransitionWillBegin {
    [super dismissalTransitionWillBegin];
    if (_configuration.isEnableInteractiveTransitioning && _interactiving) {
        return;
    }
    [self.presentedViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        self.dimmingView.alpha = 0.0;
        if (self.configuration.isEnableBackgroundAnimation) {
            CAAnimationGroup *group = [self backgroundTranslateAnimationWithForward:NO];
            [self.animatingView.layer addAnimation:group forKey:nil];
        }
    } completion:nil];
}

#pragma mark - Actions

/// 背景点击关闭弹窗
- (void)tapGestureRecognizerAction:(UITapGestureRecognizer *)sender {
    if (_configuration.autoDismissModal) {
        [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
    }
}

/// 滑动关闭弹窗
- (void)panGestureRecognizerAction:(UIPanGestureRecognizer *)sender {
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
            _interactiving = YES;
            _configuration.startedInteractiveTransitioning = YES;
            [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
            break;
        case UIGestureRecognizerStateChanged:
            // nothing to do.
            break;
        default:
            _interactiving = NO;
            _configuration.startedInteractiveTransitioning = NO;
            break;
    }
}

#pragma mark - Private

/// 背景动画
- (CAAnimationGroup *)backgroundTranslateAnimationWithForward:(BOOL)isForward {
    CATransform3D t1 = CATransform3DIdentity;
    CATransform3D t2 = CATransform3DIdentity;
    CABasicAnimation *a1 = [CABasicAnimation animationWithKeyPath:@"transform"];
    a1.toValue = [NSValue valueWithCATransform3D:t1];
    a1.duration = _configuration.animationDuration / 2;
    a1.fillMode = kCAFillModeForwards;
    a1.removedOnCompletion = NO;
    a1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CABasicAnimation *a2 = [CABasicAnimation animationWithKeyPath:@"transform"];
    a2.toValue = [NSValue valueWithCATransform3D:(isForward ? t2 : CATransform3DIdentity)];
    a2.beginTime = a1.duration;
    a2.duration = a1.duration;
    a2.fillMode = kCAFillModeForwards;
    a2.removedOnCompletion = NO;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    group.duration = _configuration.animationDuration;
    group.animations = @[a1, a2];
    return group;
}
@end
