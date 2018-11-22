//
//  LYFKeyboardNotificationViewController.h
//  fdsafsaffasdfsa
//
//  Created by yongfaliu on 2018/11/21.
//  Copyright © 2018 yongfaliu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYFKeyboardNotificationViewController : UIViewController
/**
 继承GMCKeyboardNotificationViewController的子类提供给父类
 
 @return  最底部希望不被键盘覆盖的控件
 */
- (nullable UIView *)bottomViewVisible;
@end
NS_ASSUME_NONNULL_END
