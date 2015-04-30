//
//  AppDelegate.m
//  SecondaryMarket
//
//  Created by wuxinyi on 15/4/28.
//  Copyright (c) 2015年 wuxinyi. All rights reserved.
//

#import "AppDelegate.h"
#import "PintersetHomeViewController.h"
#import "RegViewController.h"
#import "ViewController.h"
#import "XHNavigationController.h"
#import "ICETutorialController.h"

#import "LoginViewController.h"
#import "SearchPageViewController.h"
#import "MessageViewController.h"
#import "ToMyViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.bHomePageSkipDetails = YES;
    
    
    //修改tabbar字体颜色和图标颜色
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor lightGrayColor], UITextAttributeTextColor, nil] forState:UIControlStateNormal];
    
    
    [[SUHelper sharedInstance] sysInit:^(BOOL success) {
        
        if(success) {
            
            DLog(@"success");
        }
    }];
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"everLaunched"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everLaunched"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
    }
    else{
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstLaunch"];
    }
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]) {
        // 这里判断是否第一次
        [self setupICETutorialController];
        
    }
    else
    {
        [self setupICETutorialController];
        
    }
    
    //    [self createTabbar];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
-(void)setupLeveyTabBarController
{
    
    PintersetHomeViewController* homepage = [[PintersetHomeViewController alloc] init];
    homepage.title = @"首页";
    XHNavigationController *navhomepage = [[XHNavigationController alloc] initWithRootViewController:homepage];
    //        navhomepage.navigationBarHidden = YES;
    navhomepage.navigationBarHidden = YES;
    
    
    //    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
    
    //    RegViewController* SMSRegister = [[RegViewController alloc] init];
    //    SMSRegister.title = @"注册";
    //    UINavigationController* navSMSRegister = [[UINavigationController alloc] initWithRootViewController:SMSRegister];
    SearchPageViewController* SearchPage = [[SearchPageViewController alloc] initWithNibName:@"SearchPageViewController" bundle:nil];
    SearchPage.title = @"搜索";
    UINavigationController* navSearchPage = [[UINavigationController alloc] initWithRootViewController:SearchPage];
    
    MessageViewController* MessageView = [[MessageViewController alloc] initWithNibName:@"MessageViewController" bundle:nil];
    MessageView.title = @"信息";
    UINavigationController* navMessageView = [[UINavigationController alloc] initWithRootViewController:MessageView];
    
    
    ToMyViewController* ToMyView = [[ToMyViewController alloc] initWithNibName:@"ToMyViewController" bundle:nil];
    ToMyView.title = @"个人";
    UINavigationController* navToMyView = [[UINavigationController alloc] initWithRootViewController:ToMyView];
    
    NSArray *ctrlArr = [NSArray arrayWithObjects:navhomepage,navSearchPage,navMessageView,navToMyView,nil];
    
    
    //    NSMutableDictionary *imgDic = [NSMutableDictionary dictionaryWithCapacity:2];
    //    [imgDic setObject:[UIImage imageNamed:@"menu_btn_category_normal"] forKey:@"Default"];
    //    [imgDic setObject:[UIImage imageNamed:@"menu_btn_category_click"] forKey:@"Seleted"];
    //
    //    NSMutableDictionary *imgDic1 = [NSMutableDictionary dictionaryWithCapacity:2];
    //    [imgDic1 setObject:[UIImage imageNamed:@"menu_btn_category_normal"] forKey:@"Default"];
    //    [imgDic1 setObject:[UIImage imageNamed:@"menu_btn_category_click"] forKey:@"Seleted"];
    
    //    NSArray *imgArr = [NSArray arrayWithObjects:imgDic,imgDic1,nil];
    
    
    self.tabbar = [[UITabBarController alloc] init];
    CGRect frame = CGRectMake(0, 0, 320, 49);
    UIImageView *v = [[UIImageView alloc] initWithFrame:frame];
    v.image = [UIImage imageNamed:@"tabbar_background.png"];
    //    v.backgroundColor = [UIColor whiteColor];
    //    [self.tabbar.tabBar insertSubview:v atIndex:0];
    self.tabbar.tabBar.backgroundImage = [UIImage imageNamed:@"tabbar_background.png"];
    self.tabbar.tabBar.opaque = YES;
    self.tabbar.view.frame = self.window.frame;
    [self.tabbar setViewControllers:ctrlArr];
    
    
    [(UITabBarItem *)[self.tabbar.tabBar.items objectAtIndex:0] setImage:[UIImage imageNamed:@"project_normal.png" ]];
    [(UITabBarItem *)[self.tabbar.tabBar.items objectAtIndex:0] setSelectedImage:[UIImage imageNamed:@"project_selected.png" ]];
    
    
    [(UITabBarItem *)[self.tabbar.tabBar.items objectAtIndex:1] setImage:[UIImage imageNamed:@"tweet_normal.png" ]];
    [(UITabBarItem *)[self.tabbar.tabBar.items objectAtIndex:1] setSelectedImage:[UIImage imageNamed:@"tweet_selected.png" ]];
    
    
    [(UITabBarItem *)[self.tabbar.tabBar.items objectAtIndex:2] setImage:[UIImage imageNamed:@"privatemessage_normal.png" ]];
    [(UITabBarItem *)[self.tabbar.tabBar.items objectAtIndex:2] setSelectedImage:[UIImage imageNamed:@"privatemessage_selected.png" ]];
    
    [(UITabBarItem *)[self.tabbar.tabBar.items objectAtIndex:3] setImage:[UIImage imageNamed:@"me_normal.png" ]];
    [(UITabBarItem *)[self.tabbar.tabBar.items objectAtIndex:3] setSelectedImage:[UIImage imageNamed:@"me_selected.png" ]];
    
    self.window.rootViewController = self.tabbar;
}

//注册页
- (void)setupRegisteredController
{
    RegViewController* SMSRegister = [[RegViewController alloc] init];
    
    //    self.window.rootViewController =SMSRegister;
    
}
//登陆
-(void)setupLoginViewController
{
    LoginViewController* LoginView = [[LoginViewController alloc] init];
    self.window.rootViewController = LoginView;
}
//欢迎页
-(void)setupICETutorialController
{
    // Init the pages texts, and pictures.
    ICETutorialPage *layer1 = [[ICETutorialPage alloc] initWithSubTitle:@""
                                                            description:@""
                                                            pictureName:@"tutorial_background_00@2x.jpg"];
    ICETutorialPage *layer2 = [[ICETutorialPage alloc] initWithSubTitle:@""
                                                            description:@""
                                                            pictureName:@"tutorial_background_01@2x.jpg"];
    ICETutorialPage *layer3 = [[ICETutorialPage alloc] initWithSubTitle:@""
                                                            description:@""
                                                            pictureName:@"tutorial_background_02@2x.jpg"];
    ICETutorialPage *layer4 = [[ICETutorialPage alloc] initWithSubTitle:@""
                                                            description:@""
                                                            pictureName:@"tutorial_background_03@2x.jpg"];
    ICETutorialPage *layer5 = [[ICETutorialPage alloc] initWithSubTitle:@""
                                                            description:@""
                                                            pictureName:@"tutorial_background_04@2x.jpg"];
    
    // Set the common style for SubTitles and Description (can be overrided on each page).
    ICETutorialLabelStyle *subStyle = [[ICETutorialLabelStyle alloc] init];
    [subStyle setFont:TUTORIAL_SUB_TITLE_FONT];
    [subStyle setTextColor:TUTORIAL_LABEL_TEXT_COLOR];
    [subStyle setLinesNumber:TUTORIAL_SUB_TITLE_LINES_NUMBER];
    [subStyle setOffset:TUTORIAL_SUB_TITLE_OFFSET];
    
    ICETutorialLabelStyle *descStyle = [[ICETutorialLabelStyle alloc] init];
    [descStyle setFont:TUTORIAL_DESC_FONT];
    [descStyle setTextColor:TUTORIAL_LABEL_TEXT_COLOR];
    [descStyle setLinesNumber:TUTORIAL_DESC_LINES_NUMBER];
    [descStyle setOffset:TUTORIAL_DESC_OFFSET];
    
    // Load into an array.
    NSArray *tutorialLayers = @[layer1,layer2,layer3,layer4,layer5];
    self.ICETviewController = [[ICETutorialController alloc] initWithNibName:@"ICETutorialController_iPhone"
                                                                      bundle:nil
                                                                    andPages:tutorialLayers];
    
    [self.ICETviewController setCommonPageSubTitleStyle:subStyle];
    [self.ICETviewController setCommonPageDescriptionStyle:descStyle];
    
    //    // Set button 1 action.
    //    [self.ICETviewController setButton1Block:^(UIButton *button){
    //        NSLog(@"Button 1 pressed.");
    //
    //
    //    }];
    
    // Set button 2 action, stop the scrolling.
    __unsafe_unretained typeof(self) weakSelf = self;
    
    [self.ICETviewController setButton1Block:^(UIButton *button){
        NSLog(@"Button 1 pressed.");
        [weakSelf.ICETviewController stopScrolling];
        
        //        [weakSelf setupLoginViewController];
        [weakSelf setupLeveyTabBarController];
        //        LoginViewController* LoginView = [[LoginViewController alloc] init];
        //        [weakSelf.ICETviewController presentViewController:LoginView animated:YES completion:^{
        ////
        //        }];
        
    }];
    [self.ICETviewController setButton2Block:^(UIButton *button){
        
        NSLog(@"Button 2 pressed.");
        NSLog(@"Auto-scrolling stopped.");
        //        [weakSelf setupRegisteredController];
        [weakSelf.ICETviewController stopScrolling];
        
        RegViewController* SMSRegister = [[RegViewController alloc] init];
        [weakSelf.ICETviewController presentViewController:SMSRegister animated:YES completion:^{
            
        }];
    }];
    
    // Run it.
    [self.ICETviewController startScrolling];
    
    self.window.rootViewController = self.ICETviewController;
}

@end
