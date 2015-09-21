//
//  BurgerMenuViewController.m
//  Week7-StackOverflow
//
//  Created by Joey Nessif on 9/15/15.
//  Copyright (c) 2015 Joey Nessif. All rights reserved.
//

#import "BurgerMenuViewController.h"
#import "MainMenuTableViewController.h"
#import "QuestionSearchViewController.h"
#import "MyQuestionsViewController.h"
#import "MyProfileViewController.h"
#import "WebOAuthViewController.h"
#import "AppDelegate.h"


CGFloat const kburgerOpenScreenDivider = 3.0;
CGFloat const kburgerOpenScreenMultiplier = 2.0;
NSTimeInterval const ktimeToSlideMenu = 0.3;
CGFloat const kburgerButtonWidth = 50.0;
CGFloat const kburgerButtonHeight = 50.0;

@interface BurgerMenuViewController () <UITableViewDelegate>

@property (strong,nonatomic) UIViewController *topViewController;
@property (strong,nonatomic) UIButton *burgerButton;
@property (strong,nonatomic) UIPanGestureRecognizer *pan;
@property (strong,nonatomic) NSArray *viewControllers;

@property (nonatomic) CGFloat parentCenterX;
@property (nonatomic) CGFloat topVCCenterX;
@property (nonatomic) CGFloat topVCCenterY;
@property (nonatomic) CGFloat topVCOriginX;
@property (nonatomic) CGFloat topVCWidth;




@end

@implementation BurgerMenuViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  //create and add instance of MainMenuTableVC
  UITableViewController *mainMenuVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MainMenu"];
  mainMenuVC.tableView.delegate = self;
  [self addChildViewController:mainMenuVC];
  mainMenuVC.view.frame = self.view.frame;
  [self.view addSubview:mainMenuVC.view];
  [mainMenuVC didMoveToParentViewController:self];
  
  //create and add instance of QuestionSearchVC
  QuestionSearchViewController *questionSearchVC = [self.storyboard instantiateViewControllerWithIdentifier:@"QuestionSearch"];
  [self addChildViewController:questionSearchVC];
  questionSearchVC.view.frame = self.view.frame;
  [self.view addSubview:questionSearchVC.view];
  [questionSearchVC didMoveToParentViewController:self];
 
  //create and add instance of MyQuestionsVC
  MyQuestionsViewController *myQuestionsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MyQuestions"];
  [self addChildViewController:myQuestionsVC];

  //create and add instance of MyProfileVC
  MyProfileViewController *myProfileVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MyProfile"];
  [self addChildViewController:myProfileVC];

  self.viewControllers = @[questionSearchVC,myQuestionsVC, myProfileVC];
  self.topViewController = questionSearchVC;
  
  //UILayout top = self.topViewController.topLayoutGuide;
  UIButton *burgerButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 5, kburgerButtonWidth, kburgerButtonHeight)];
  [burgerButton setImage:[UIImage imageNamed:@"BurgerBtn.jpg"] forState:UIControlStateNormal];
  self.burgerButton = burgerButton;
  [self.topViewController.view addSubview:self.burgerButton];
  [self.burgerButton addTarget:self action:@selector(burgerButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
  
  
  UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(topViewControllerPanned:)];
  [self.topViewController.view addGestureRecognizer:pan];
  self.pan = pan;
  
  
}

-(void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  //check if you already have the token
  
  AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
  appDelegate.userDefaults = [NSUserDefaults standardUserDefaults];
  NSString *token = [appDelegate.userDefaults stringForKey:@"tokenString"];
  
  if (!token) {
    WebOAuthViewController *webVC = [[WebOAuthViewController alloc] init];
    [self presentViewController:webVC animated:true completion:nil];
  }
}

-(void)burgerButtonPressed:(UIButton *)sender {
  [UIView animateWithDuration:ktimeToSlideMenu animations:^{
    self.topViewController.view.center = CGPointMake(self.view.center.x * kburgerOpenScreenMultiplier, self.topViewController.view.center.y);
  } completion:^(BOOL finished) {
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToCloseMenu:)];
    [self.topViewController.view addGestureRecognizer:tap];
    sender.userInteractionEnabled = false;
    
  }];
}

-(void)topViewControllerPanned:(UIPanGestureRecognizer *)sender {
  
  CGPoint velocity = [sender velocityInView:self.topViewController.view];
  CGPoint translation = [sender translationInView:self.topViewController.view];
 
  CGFloat parentCenterX = self.view.center.x;
  [self setTopVCProperties:self.topViewController];
  
  if (sender.state == UIGestureRecognizerStateChanged) {
    if (velocity.x > 0) {
      self.topViewController.view.center = CGPointMake(self.topVCCenterX + translation.x, self.topVCCenterY);
      [sender setTranslation:CGPointZero inView:self.topViewController.view];
    }
  }
  
  if (sender.state == UIGestureRecognizerStateEnded) {
    if (self.topVCOriginX > self.topVCWidth / kburgerOpenScreenDivider) {
      NSLog(@"user is opening menu");
      
      [UIView animateWithDuration:ktimeToSlideMenu animations:^{
        self.topViewController.view.center = CGPointMake(parentCenterX * kburgerOpenScreenMultiplier, self.topVCCenterY);
      } completion:^(BOOL finished) {
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToCloseMenu:)];
        [self.topViewController.view addGestureRecognizer:tap];
        self.burgerButton.userInteractionEnabled = false;
        
      }];
    } else {
      [UIView animateWithDuration:ktimeToSlideMenu animations:^{
        self.topViewController.view.center = CGPointMake(parentCenterX, self.topVCCenterY);
      } completion:^(BOOL finished) {
        
      }];
    }
  }
}

-(void)tapToCloseMenu:(UITapGestureRecognizer *)tap {
  [self.topViewController.view removeGestureRecognizer:tap];
  [UIView animateWithDuration:0.3 animations:^{
    self.topViewController.view.center = self.view.center;
  } completion:^(BOOL finished) {
    self.burgerButton.userInteractionEnabled = true;
    
  }];
}

-(void)switchToViewController:(UIViewController *)newVC{
  [UIView animateWithDuration:0.3 animations:^{
    
    self.topViewController.view.frame = CGRectMake(self.view.frame.size.width,self.topViewController.view.frame.origin.y,self.topViewController.view.frame.size.width, self.topViewController.view.frame.size.height);
    
  } completion:^(BOOL finished) {
    CGRect oldFrame = self.topViewController.view.frame;
    [self.topViewController willMoveToParentViewController:nil];
    [self.topViewController.view removeFromSuperview];
    [self.topViewController removeFromParentViewController];
    
    [self addChildViewController:newVC];
    newVC.view.frame = oldFrame;
    [self.view addSubview:newVC.view];
    [newVC didMoveToParentViewController:self];
    self.topViewController = newVC;
    
    [self.burgerButton removeFromSuperview];
    [self.topViewController.view addSubview:self.burgerButton];
    
    [self animateMenuClosure];
    
  }];
}

-(void)setTopVCProperties:(UIViewController *)topVC {
  
  self.topVCCenterX = topVC.view.center.x;
  self.topVCCenterY = topVC.view.center.y;
  self.topVCOriginX = topVC.view.frame.origin.x;
  self.topVCWidth = topVC.view.frame.size.width;
  
}

-(void)animateMenuClosure{
  [UIView animateWithDuration:ktimeToSlideMenu animations:^{
    self.topViewController.view.center = self.view.center;
  } completion:^(BOOL finished) {
    [self.topViewController.view addGestureRecognizer:self.pan];
    self.burgerButton.userInteractionEnabled = true;
  }];
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  NSLog(@"%ld",(long)indexPath.row);
  
  UIViewController *newVC = self.viewControllers[indexPath.row];
  if (![newVC isEqual:self.topViewController]) {
    [self switchToViewController:newVC];
  } else {
    [self animateMenuClosure];
  }
  
}

@end
