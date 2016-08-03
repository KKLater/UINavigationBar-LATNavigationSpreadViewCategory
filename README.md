# UINavigationBar+LATNavigationSpreadViewCategory

对UINavigationBar做的一个下拉视图的扩展。

#### 1、演示：

![](UINavigationBar+LATNavigationSpreadViewCategory.gif)

#### 2、使用：

```objective-c
//直接设置navigationBar的spreadView属性，来设置展开视图
self.navigationController.navigationBar.spreadView = self.navigationSpreadView;
```
```objective-c
//可以用过navigationBar的isSpreadViewShow属性判定视图是否处于展开的状态
if (self.navigationController.navigationBar.isSpreadViewShow) {
	//隐藏视图
    [self.navigationController.navigationBar hideSpreadView];
} else {
	//展开视图
    [self.navigationController.navigationBar showSpreadView];
}
```
