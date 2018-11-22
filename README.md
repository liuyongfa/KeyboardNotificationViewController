# KeyboardNotificationViewController
继承KeyboardNotificationViewController，并且重写函数

- (UIView *)bottomViewVisible {
    return self.loginButton;
}

返回最底部不想被键盘覆盖的控件。就可以实现view跟随键盘移动。同时支持点击空白处收起键盘。
