//
//  LYFKeyboardNotificationViewController.m
//  fdsafsaffasdfsa
//
//  Created by yongfaliu on 2018/11/21.
//  Copyright © 2018 yongfaliu. All rights reserved.
//

#import "LYFKeyboardNotificationViewController.h"

static CGFloat VerticalOffset = 8.0;

@interface LYFKeyboardNotificationViewController ()

@end

@implementation LYFKeyboardNotificationViewController

//storyboard
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self addKeyboardNotification];
    }
    return self;
}
//非storyboard
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self  = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self addKeyboardNotification];
    }
    return  self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createGestureRecognizer];
}

- (UIView *)bottomViewVisible {
    return nil;
}

#pragma mark - KeyboardNotification
- (void)addKeyboardNotification {
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(keyboardWillShowNotification:) name:UIKeyboardWillShowNotification object:nil];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(keyboardWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillShowAnimated:(CGRect)keyboardFrame {
    UIView *v = [self bottomViewVisible];
    if (!v) {
        return;
    }
    CGRect buttonRect = [v.superview convertRect:v.frame toView:self.view];
    CGFloat height = self.view.frame.size.height - CGRectGetMaxY(buttonRect);
    CGFloat needH = MIN(0, height - keyboardFrame.size.height - VerticalOffset);
    self.view.transform = CGAffineTransformMakeTranslation(0, needH);
}

- (void)keyboardWillHideAnimated:(CGRect)keyboardFrame {
    self.view.transform = CGAffineTransformMakeTranslation(0, 0);
}

- (void)keyboardWillShowNotification:(NSNotification*)notification {
    [self handleNotification:notification willShow:YES];
}

- (void)keyboardWillHideNotification:(NSNotification*)notification {
    [self handleNotification:notification willShow:NO];
}

- (void)handleNotification:(NSNotification *)notification willShow:(BOOL)show {
    NSDictionary *userInfo = notification.userInfo;
    CGRect frame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    int curve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] intValue];
    __weak LYFKeyboardNotificationViewController *weakSelf = self;
    [UIView animateWithDuration:duration delay:0 options:curve animations:^{
        show ? [weakSelf keyboardWillShowAnimated:frame] : [weakSelf keyboardWillHideAnimated:frame];
    } completion:^(BOOL finished) {
    }];
}

#pragma mark - TapGesture
-(void)createGestureRecognizer {
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnView)];
    [self.view addGestureRecognizer:tapGR];
}

-(void)tapOnView {
    [self.view endEditing:YES];
}

- (void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
