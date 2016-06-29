//
//  Content.m
//  常用知识点汇总


#import "Content.h"

@implementation Content

#pragma 1.NSString过滤特殊字符
// 定义一个特殊字符的集合
 NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:
                       @"@／：；（）¥「」＂、[]{}#%-*+=_\\|~＜＞$€^•'@#$%^&*()_+'\""];
// 过滤字符串的特殊字符
NSString *newString = [NSString stringByTrimmingCharactersInSet:set];


#pragma 2.TransForm属性
//平移按钮
CGAffineTransform transForm = self.buttonView.transform;
self.buttonView.transform = CGAffineTransformTranslate(transForm, 10, 0);

//旋转按钮
CGAffineTransform transForm = self.buttonView.transform;
self.buttonView.transform = CGAffineTransformRotate(transForm, M_PI_4);

//缩放按钮
self.buttonView.transform = CGAffineTransformScale(transForm, 1.2, 1.2);

//初始化复位
self.buttonView.transform = CGAffineTransformIdentity;

#pragma 3.计算方法耗时时间间隔
// 获取时间间隔
#define TICK   CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
#define TOCK   NSLog(@"Time: %f", CFAbsoluteTimeGetCurrent() - start)


#pragma 4.Alert提示宏定义
//Alert提示宏定义
#define Alert(_S_, …) [[[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:(_S_), ##__VA_ARGS__] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show]

#pragma 5.让iOS应用直接退出
- (void)exitApplication {
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    UIWindow *window = app.window;
    
    [UIView animateWithDuration:1.0f animations:^{
        window.alpha = 0;
    } completion:^(BOOL finished) {
        exit(0);
    }];
}

#pragma 6.快速求总和 最大值 最小值 和 平均值
NSArray 快速求总和 最大值 最小值 和 平均值
NSArray *array = [NSArray arrayWithObjects:@"2.0", @"2.3", @"3.0", @"4.0", @"10", nil];
CGFloat sum = [[array valueForKeyPath:@"@sum.floatValue"] floatValue];
CGFloat avg = [[array valueForKeyPath:@"@avg.floatValue"] floatValue];
CGFloat max =[[array valueForKeyPath:@"@max.floatValue"] floatValue];
CGFloat min =[[array valueForKeyPath:@"@min.floatValue"] floatValue];
NSLog(@"%f\n%f\n%f\n%f",sum,avg,max,min);

#pragma 7.修改Label中不同文字颜色
- (void)touchesEnded:(NSSet<UITouch> *)touches withEvent:(UIEvent *)event
{
    [self editStringColor:self.label.text editStr:@"好" color:[UIColor blueColor]];
}

- (void)editStringColor:(NSString *)string editStr:(NSString *)editStr color:(UIColor *)color {
    // string为整体字符串, editStr为需要修改的字符串
    NSRange range = [string rangeOfString:editStr];
    
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:string];
    
    // 设置属性修改字体颜色UIColor与大小UIFont
    [attribute addAttributes:@{NSForegroundColorAttributeName:color} range:range];
    
    self.label.attributedText = attribute;
}
#pragma 8.Label行间距

-（void）test{
    NSMutableAttributedString *attributedString =
    [[NSMutableAttributedString alloc] initWithString:self.contentLabel.text];
    NSMutableParagraphStyle *paragraphStyle =  [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:3];
    
    //调整行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName
                             value:paragraphStyle
                             range:NSMakeRange(0, [self.contentLabel.text length])];
    self.contentLabel.attributedText = attributedString;
}

#pragma 9.UIImageView填充模式
@"UIViewContentModeScaleToFill",      // 拉伸自适应填满整个视图
@"UIViewContentModeScaleAspectFit",   // 自适应比例大小显示
@"UIViewContentModeScaleAspectFill",  // 原始大小显示
@"UIViewContentModeRedraw",           // 尺寸改变时重绘
@"UIViewContentModeCenter",           // 中间
@"UIViewContentModeTop",              // 顶部
@"UIViewContentModeBottom",           // 底部
@"UIViewContentModeLeft",             // 中间贴左
@"UIViewContentModeRight",            // 中间贴右
@"UIViewContentModeTopLeft",          // 贴左上
@"UIViewContentModeTopRight",         // 贴右上
@"UIViewContentModeBottomLeft",       // 贴左下
@"UIViewContentModeBottomRight",      // 贴右下

#pragma 10.iOS 开发中一些相关的路径
模拟器的位置:
/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs

文档安装位置:
/Applications/Xcode.app/Contents/Developer/Documentation/DocSets

插件保存路径:
~/Library/ApplicationSupport/Developer/Shared/Xcode/Plug-ins

自定义代码段的保存路径:
~/Library/Developer/Xcode/UserData/CodeSnippets/
如果找不到CodeSnippets文件夹，可以自己新建一个CodeSnippets文件夹。

证书路径
~/Library/MobileDevice/Provisioning Profiles
获取 iOS 路径的方法
获取家目录路径的函数
NSString *homeDir = NSHomeDirectory();

获取Documents目录路径的方法
NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
NSString *docDir = [paths objectAtIndex:0];

获取Documents目录路径的方法
NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
NSString *cachesDir = [paths objectAtIndex:0];

获取tmp目录路径的方法：
NSString *tmpDir = NSTemporaryDirectory();

#pragma 11.关于隐藏navigationbar
设置滑动的时候隐藏navigationbar
navigationController.hidesBarsOnSwipe = Yes
动态隐藏NavigationBar
//1.当我们的手离开屏幕时候隐藏
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    if(velocity.y > 0)
    {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    } else {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
}
velocity.y这个量，在上滑和下滑时，变化极小（小数），但是因为方向不同，有正负之分，这就很好处理了。
//2.在滑动过程中隐藏
//像safari
(1)
self.navigationController.hidesBarsOnSwipe = YES;
(2)
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y + __tableView.contentInset.top;
    CGFloat panTranslationY = [scrollView.panGestureRecognizer translationInView:self.tableView].y;
    if (offsetY > 64) {
        if (panTranslationY > 0)
        {
            //下滑趋势，显示
            [self.navigationController setNavigationBarHidden:NO animated:YES];
        } else {
            //上滑趋势，隐藏
            [self.navigationController setNavigationBarHidden:YES animated:YES];
        }
    } else {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
}
这里的offsetY > 64只是为了在视图滑过navigationBar的高度之后才开始处理，防止影响展示效果。panTranslationY是scrollView的pan手势的手指位置的y值，可能不是太好，因为panTranslationY这个值在较小幅度上下滑动时，可能都为正或都为负，这就使得这一方式不太灵敏.

#pragma 12.自动处理键盘事件，实现输入框防遮挡的插件
IQKeyboardManager
https://github.com/hackiftekhar/IQKeyboardManager


#pragma 13.设置字体和行间距
//设置字体和行间距
UILabel * lable = [[UILabel alloc]initWithFrame:CGRectMake(50, 100, 300, 200)];
lable.text = @"大家好,我是xiao公子,在这里我们一起学习新的知识,总结我们遇到的那些坑,共同的学习,共同的进步,共同的努力,只为美好的明天!!!有问题一起相互的探讨—123456!!!";
lable.numberOfLines = 0;
lable.font = [UIFont systemFontOfSize:12];
lable.backgroundColor = [UIColor grayColor];
[self.view addSubview:lable];
//设置每个字体之间的间距
//NSKernAttributeName 这个对象所对应的值是一个NSNumber对象(包含小数),作用是修改默认字体之间的距离调整,值为0的话表示字距调整是禁用的; NSMutableAttributedString * str = [[NSMutableAttributedString alloc]initWithString:lable.text attributes:@{NSKernAttributeName:@(5.0)}];
//设置某写字体的颜色
//NSForegroundColorAttributeName 设置字体颜色
NSRange blueRange = NSMakeRange([[str string] rangeOfString:@"xiao公子"].location, [[str string] rangeOfString:@"Frank_chun"].length);
[str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:blueRange];
NSRange blueRange1 = NSMakeRange([[str string] rangeOfString:@"123456"].location, [[str string] rangeOfString:@"438637472"].length);
[str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:blueRange1];
//设置每行之间的间距
//NSParagraphStyleAttributeName 设置段落的样式
NSMutableParagraphStyle * par = [[NSMutableParagraphStyle alloc]init];
[par setLineSpacing:20];
//为某一范围内文字添加某个属性
//NSMakeRange表示所要的范围,从0到整个文本的长度
[str addAttribute:NSParagraphStyleAttributeName value:par range:NSMakeRange(0, lable.text.length)]; [lable setAttributedText:str];


#pragma 14.点击button倒计时
//第一种方法
//点击button倒计时
#import "ViewController.h"
@interface ViewController ()
@property (nonatomic, strong) UIButton * timeButton;
@property (nonatomic, strong) NSTimer * timer;
@property (nonatomic, strong)UIButton * btn;
@end@implementation ViewController
{
    NSInteger _time;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _time = 5;
    self.btn = [UIButton buttonWithType:UIButtonTypeCustom]; _btn.backgroundColor = [UIColor orangeColor];
    [_btn setTitle:@"获取验证码" forState:UIControlStateNormal]; _btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_timeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self refreshButtonWidth];
    [self.view addSubview:self.btn];
}
- (void)refreshButtonWidth{
    CGFloat width = 0;
    if (_btn.enabled){
        width = 100;
    } else {
        width = 200;
    }
    _btn.center = CGPointMake(self.view.frame.size.width/2, 200);
    _btn.bounds = CGRectMake(0, 0, width, 40);
    //每次刷新，保证区域正确
    [_btn setBackgroundImage:[self imageWithColor:[UIColor orangeColor] andSize:_btn.frame.size] forState:UIControlStateNormal];
    [_btn setBackgroundImage:[self imageWithColor:[UIColor lightGrayColor] andSize:_btn.frame.size] forState:UIControlStateDisabled];
}
- (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)aSize{
    CGRect rect = CGRectMake(0.0f, 0.0f, aSize.width, aSize.height); UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext(); CGContextSetFillColorWithColor(context, [color CGColor]); CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext(); UIGraphicsEndImageContext();
    return image;
}
- (void)btnAction:(UIButton *)sender{
    sender.enabled = NO;
    [self refreshButtonWidth];
    [sender setTitle:[NSString stringWithFormat:@"获取验证码(%zi)", _time] forState:UIControlStateNormal];
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timeDown) userInfo:nil repeats:YES];
}
- (void)timeDown{
    _time —;
    if (_time == 0) {
        [_btn setTitle:@"重新获取" forState:UIControlStateNormal]; _btn.enabled = YES;
        [self refreshButtonWidth];
        [_timer invalidate];
        _timer = nil;
        _time = 5 ;
        return;
    }
    [_btn setTitle:[NSString stringWithFormat:@"获取验证码(%zi)", _time] forState:UIControlStateNormal];
}
//第二种方法
#pragma mark -点击发送验证码
- (void)sendMessage:(UIButton *)btn{
    if (self.phoneField.text.length == 0) {
        [self remindMessage:@"请输入正确的手机号"];
    }else{
        __block int timeout=60;
        //倒计时时间
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0); dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue); dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0);
        //每秒执行
        dispatch_source_set_event_handler(_timer, ^{
            if(timeout<=0){
                //倒计时结束，关闭
                dispatch_source_cancel(_timer); dispatch_async(dispatch_get_main_queue(), ^{
                    // 设置界面的按钮显示 根据自己需求设置
                    [btn setTitle:@"发送验证码" forState:UIControlStateNormal]; btn.userInteractionEnabled = YES;
                });
            }else{
                int seconds = timeout % 60;
                NSString *strTime = [NSString stringWithFormat:@"%d", seconds];
                if ([strTime isEqualToString:@"0"]) {
                    strTime = [NSString stringWithFormat:@"%d",60];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    //设置界面的按钮显示 根据自己需求设置
                    //NSLog(@"____%@",strTime);
                    [UIView beginAnimations:nil context:nil];
                    [UIView setAnimationDuration:1];
                    [btn setTitle:[NSString stringWithFormat:@"%@秒后重新发送",strTime] forState:UIControlStateNormal];
                    [UIView commitAnimations];
                    btn.userInteractionEnabled = NO;
                });
                timeout—;
            }
        });
        dispatch_resume(_timer);
    }
#pragma 15.修改textFieldplaceholder字体颜色和大小
    textField.placeholder = @"username is in here!"; [/p][textField setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
    [textField setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
#pragma 16.图片拉伸
    UIImage* img=[UIImage imageNamed:@"2.png"];//原图
    UIEdgeInsets edge=UIEdgeInsetsMake(0, 10, 0,10);
    //UIImageResizingModeStretch：拉伸模式，通过拉伸UIEdgeInsets指定的矩形区域来填充图片
    //UIImageResizingModeTile：平铺模式，通过重复显示UIEdgeInsets指定的矩形区域来填充图
    img= [img resizableImageWithCapInsets:edge resizingMode:UIImageResizingModeStretch];
    self.imageView.image=img;
#pragma 17.去掉导航栏下边的黑线
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
#pragma 18.修改pagecontrol颜色
    _pageControl.currentPageIndicatorTintColor=SFQRedColor;
    _pageControl.pageIndicatorTintColor=SFQGrayColor;
#pragma 19.去掉UITableView的section的粘性，使其不会悬停
    //有时候使用UITableView所实现的列表，会使用到section，但是又不希望它粘在最顶上而是跟随滚动而消失或者出现
    - (void)scrollViewDidScroll:(UIScrollView *)scrollView {
        if (scrollView == _tableView) {
            CGFloat sectionHeaderHeight = 36;
            
            if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y >= 0) {
                scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
            } else if (scrollView.contentOffset.y >= sectionHeaderHeight) {
                scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
            }
        }
    }
#pragma 20.UIImage与字符串互转
    //图片转字符串
    -(NSString *)UIImageToBase64Str:(UIImage *) image
    {
        NSData *data = UIImageJPEGRepresentation(image, 1.0f);
        NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        return encodedImageStr;
    }
    
    //字符串转图片
    -(UIImage *)Base64StrToUIImage:(NSString *)_encodedImageStr
    {
        NSData *_decodedImageData   = [[NSData alloc] initWithBase64Encoding:_encodedImageStr];
        UIImage *_decodedImage      = [UIImage imageWithData:_decodedImageData];
        return _decodedImage;
    }
#pragma 21.判断NSString中是否包含中文
    -(BOOL)isChinese:(NSString *)str{
        NSString *match=@"(^[\u4e00-\u9fa5]+$)";
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
        return [predicate evaluateWithObject:str];
    }
#pragma 22.NSDate与NSString的相互转化
    -(NSString *)dateToString:(NSDate *)date {
        // 初始化时间格式控制器
        NSDateFormatter *matter = [[NSDateFormatter alloc] init];
        // 设置设计格式
        [matter setDateFormat:@"yyyy-MM-dd hh:mm:ss zzz"];
        // 进行转换
        NSString *dateStr = [matter stringFromDate:date];
        return dateStr;
    }
    -(NSDate *)stringToDate:(NSString *)dateStr {
        
        // 初始化时间格式控制器
        NSDateFormatter *matter = [[NSDateFormatter alloc] init];
        // 设置设计格式
        [matter setDateFormat:@"yyyy-MM-dd hh:mm:ss zzz"];
        // 进行转换
        NSDate *date = [matter dateFromString:dateStr];
        return date;
    }

#pragma 23.控件的局部圆角

    CGRect rect = CGRectMake(0, 0, 100, 50);
    CGSize radio = CGSizeMake(5, 5);//圆角尺寸
    UIRectCorner corner = UIRectCornerTopLeft|UIRectCornerTopRight;//这只圆角位置
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corner cornerRadii:radio];
    CAShapeLayer *masklayer = [[CAShapeLayer alloc]init];//创建shapelayer
    masklayer.frame = button.bounds;
    masklayer.path = path.CGPath;//设置路径
    button.layer.mask = masklayer;

#pragma 24.navigationBar的透明问题
    //如果仅仅把navigationBar的alpha设为0的话，那就相当于把navigationBar给隐藏了，大家都知道，父视图的alpha设置为0的话，那么子视图全都会透明的。那么相应的navigationBar的标题和左右两个按钮都会消失。这样显然达不到我们要求的效果。
    （1）如果仅仅是想要navigationBar透明，按钮和标题都在可以使用以下方法：
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];//给navigationBar设置一个空的背景图片即可实现透明，而且标题按钮都在
//    但是有细线，这就需要我们做进一步处理，把线去掉，如下方法即可：
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    //其实这个线也是image控制的。设为空即可
    （2）如果你想在透明的基础上实现根据下拉距离，由透明变得不透明的效果，那么上面那个就显得力不从心了，这就需要我们采用另外一种方法了
    
    //navigationBar是一个复合视图，它是有许多个控件组成的，那么我们就可以从他的内部入手
    [[self.navigationController.navigationBar subviews] objectAtIndex:0].alpha = 0;//这里可以根据scrollView的偏移量来设置alpha就实现了渐变透明的效果

#pragma 25.全局设置navigationBar标题的样式和barItem的标题样式
    //UIColorWithHexRGB( )这个方法是自己定义的，这里只需要给个颜色就好了
    [[UINavigationBar appearance] setBarTintColor:UIColorWithHexRGB(0xfefefe)];
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18],NSForegroundColorAttributeName:UIColorWithHexRGB(0xfe6d27)}];
    
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:10],NSForegroundColorAttributeName : UIColorWithHexRGB(0x666666)} forState:UIControlStateNormal];
    
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize]

#pragma 26.侧滑手势返回

    iOS的侧滑返回手势有着很好的操作体验，不支持侧滑返回的应用绝对不是好应用。但是在开发过程中在自定义了返回按钮，或者某些webView,tableView等页面，侧滑返回手势失效，这时候就需要我们来进行设置一下了,可以在基类里面协商如下代码：

    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
    //需要遵循一下手势的代理        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }

    问题：当返回navigationController的最顶层的Controller的时候。再次侧滑，这个时候你在点击一个push页面的操作，你会发现卡那了，半天才会有反应。
    这是由于，在最顶层Controller手势依然有效，但是滑动后，并找不到返回的页面。造成软件卡顿，假死所以就要在rootViewController中让此手势失效。把下面的设为NO

    self.navigationController.interactivePopGestureRecognizer.enabled = YES;

    当然你也可以使用一个第三方库，写的相当棒。他对系统的侧滑返回手势进行拓展，不用从边缘滑动，只要右滑即可返回。最重要的是，他只需要加入项目中即可，不需要一行代码即可实现。附上github 网址
    https://github.com/forkingdog/FDFullscreenPopGesture

#pragma 27.给webView添加头视图

//webView是一个复合视图，里面包含有一个scrollView，scrollView里面是一个UIWebBrowserView（负责显示WebView的内容）

    UIView *webBrowserView = self.webView.scrollView.subviews[0];//拿到webView的webBrowserView
    self.backHeadImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth*2/3.0)];
    [_backHeadImageView sd_setImageWithURL:[NSURL URLWithString:self.imageUrl] placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
    [self.webView insertSubview:_backHeadImageView belowSubview:self.webView.scrollView];
    //把backHeadImageView插入到webView的scrollView下面
    CGRect frame = self.webBrowserView.frame;
    frame.origin.y = CGRectGetMaxY(_backHeadImageView.frame);
    self.webBrowserView.frame = frame;
    //更改webBrowserView的frame向下移backHeadImageView的高度，使其可见
                                                        
#pragma 28.模态跳转的动画设置  model
     
    DetailViewController *detailVC = [[DetailViewController alloc]init];
    //UIModalTransitionStyleFlipHorizontal 翻转
    //UIModalTransitionStyleCoverVertical 底部滑出
    //UIModalTransitionStyleCrossDissolve 渐显
    //UIModalTransitionStylePartialCurl 翻页
    detailVC.modalTransitionStyle = UIModalTransitionStylePartialCurl;
    [self presentViewController:detailVC animated:YES completion:nil];
                                                        
#pragma 29.图片处理只拿到图片的一部分
                                                        
    UIImage *image = [UIImage imageNamed:filename];
    CGImageRef imageRef = image.CGImage;
    CGRect rect = CGRectMake(origin.x, origin.y ,size.width, size.height);
    //这里的宽高是相对于图片的真实大小
    //比如你的图片是400x400的那么（0，0，400，400）就是图片的全尺寸，想取哪一部分就设置相应坐标即可
    CGImageRef imageRefRect = CGImageCreateWithImageInRect(imageRef, rect);
    UIImage *imageRect = [[UIImage alloc] initWithCGImage:imageRefRect];
                                                        
#pragma 30.给UIView设置图片
    UIImage *image = [UIImage imageNamed:@"playing"];
    _layerView.layer.contents = (__bridge id)image.CGImage;
    _layerView.layer.contentsCenter = CGRectMake(0.25, 0.25, 0.5, 0.5);
    //同样可以设置显示的图片范围
    //不过此处略有不同，这里的四个值均为0-1之间；对应的依然是写x,y,widt,height
                                                        
#pragma 31.给TableView或者CollectionView的cell添加简单动画
只要在willDisplayCell方法中对将要显示的cell做动画即可：

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
        NSArray *array =  tableView.indexPathsForVisibleRows;
        NSIndexPath *firstIndexPath = array[0];
        
        
        //设置anchorPoint
        cell.layer.anchorPoint = CGPointMake(0, 0.5);
        //为了防止cell视图移动，重新把cell放回原来的位置
        cell.layer.position = CGPointMake(0, cell.layer.position.y);
        
        
        //设置cell 按照z轴旋转90度，注意是弧度
        if (firstIndexPath.row < indexPath.row) {
            cell.layer.transform = CATransform3DMakeRotation(M_PI_2, 0, 0, 1.0);
        }else{
            cell.layer.transform = CATransform3DMakeRotation(- M_PI_2, 0, 0, 1.0);
        }
        
        
        cell.alpha = 0.0;
        
        
        [UIView animateWithDuration:1 animations:^{
            cell.layer.transform = CATransform3DIdentity;
            cell.alpha = 1.0;
        }];
    }
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
        
        
        if (indexPath.row % 2 != 0) {
            cell.transform = CGAffineTransformTranslate(cell.transform, kScreenWidth/2, 0);
        }else{
            cell.transform = CGAffineTransformTranslate(cell.transform, -kScreenWidth/2, 0);
        }
        cell.alpha = 0.0;
        [UIView animateWithDuration:0.7 animations:^{
            cell.transform = CGAffineTransformIdentity;
            cell.alpha = 1.0;
        } completion:^(BOOL finished) {
            
            
        }];
    }
   
                                                        
#pragma 32.两点之间的距离
                                                        
    static __inline__ CGFloat CGPointDistanceBetweenTwoPoints(CGPoint point1, CGPoint point2)
        {
        CGFloat dx = point2.x - point1.x; CGFloat dy = point2.y - point1.y; return sqrt(dx*dx + dy*dy);
         }
#pragma 32.线程中更新 UILabel的text
    //abel1 为UILabel，当在子线程中，需要进行text的更新的时候，可以使用这个方法来更新。
//    其他的UIView 也都是一样的。
    [self.label1 performSelectorOnMainThread:@selector(setText:)    withObject:textDisplay waitUntilDone:YES];
#pragma 33.获得当前硬盘空间
    NSFileManager *fm = [NSFileManager defaultManager];
    NSDictionary *fattributes = [fm attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    
    
    NSLog(@"容量%lldG",[[fattributes objectForKey:NSFileSystemSize] longLongValue]/1000000000);
    NSLog(@"可用%lldG",[[fattributes objectForKey:NSFileSystemFreeSize] longLongValue]/1000000000);
#pragma 34.ActivityViewController 使用AirDrop分享
    使用AirDrop 进行分享：
        NSArray *array = @[@"test1", @"test2"];

        UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:array applicationActivities:nil];
    
        [self presentViewController:activityVC animated:YES
                         completion:^{
                             NSLog(@"Air");
                         }];
#pragma 35.保存全屏为image
                                                        
    CGSize imageSize = [[UIScreen mainScreen] bounds].size;
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();


    for (UIWindow * window in [[UIApplication sharedApplication] windows]) {
    if (![window respondsToSelector:@selector(screen)] || [window screen] == [UIScreen mainScreen]) {
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, [window center].x, [window center].y);
    CGContextConcatCTM(context, [window transform]);
    CGContextTranslateCTM(context, -[window bounds].size.width*[[window layer] anchorPoint].x, -[window bounds].size.height*[[window layer] anchorPoint].y);
    [[window layer] renderInContext:context];


    CGContextRestoreGState(context);
    }
    }


    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();

#pragma 36.获取通讯录联系人的电话号码
                                                        
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
ABPeoplePickerNavigationControllerDelegate
                                                        
    - (void)addAddress
    {
    RYLog(@"选择联系人");
    ABPeoplePickerNavigationController * vc = [[ABPeoplePickerNavigationController alloc] init];
    vc.peoplePickerDelegate = self;
    [self presentViewController:vc animated:YES completion:nil];

    }

    #pragma mark -- ABPeoplePickerNavigationControllerDelegate
    - (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {

    ABMultiValueRef valuesRef = ABRecordCopyValue(person, kABPersonPhoneProperty);
    CFIndex index = ABMultiValueGetIndexForIdentifier(valuesRef,identifier);
    //电话号码
    CFStringRef telValue = ABMultiValueCopyValueAtIndex(valuesRef,index);

    [self dismissViewControllerAnimated:YES completion:^{
    self.addressV.telnum.text = (__bridge NSString *)telValue;


    }];
    }

#pragma 37.用WebView加载页面，提前获取页面的高度
    可以获得内容高度，但是网络不好时，不准确
  1.webView.scrollView.contentSize.height;
       
    获取的高度较为准确
  2.[[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight;"] intValue]

@end
