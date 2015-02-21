//
//  AppDelegate.m
//  ThinkOfYou
//
//  Created by Xiangnan Xu on 2/20/15.
//  Copyright (c) 2015 Yahoo. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import <ParseFacebookUtils/PFFacebookUtils.h>
#import <Parse/Parse.h>


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [Parse enableLocalDatastore];
    
    // Initialize Parse.
    [Parse setApplicationId:@"Oo5nThgZFzWCrMifE0axyyFt3eUgbXMvo4IW4bzK"
                  clientKey:@"bllTDF7LwRlEdCYhw3l0RDmqaj39DtnCbczcn1j7"];
    
    // [Optional] Track statistics around application opens.
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
//    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
//    testObject[@"foo"] = @"bar";
//    [testObject saveInBackground];
    
    [Parse setApplicationId:@"Oo5nThgZFzWCrMifE0axyyFt3eUgbXMvo4IW4bzK" clientKey:@"bllTDF7LwRlEdCYhw3l0RDmqaj39DtnCbczcn1j7"];
    [PFFacebookUtils initializeFacebook];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    if (![PFUser currentUser] && ![PFFacebookUtils isLinkedWithUser:[PFUser currentUser]]) {
        PFLogInViewController *loginViewController = [[PFLogInViewController alloc] init];
        loginViewController.delegate = self;
        [loginViewController setFields:PFLogInFieldsFacebook];
        self.window.rootViewController = loginViewController;
        
    } else {
        self.window.rootViewController = [[MainViewController alloc] init];
    }
    [self.window makeKeyAndVisible];

    
    return YES;
}

- (void) presentLoginControllerAnimated:(BOOL) animated {
    
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


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [FBAppCall handleOpenURL:url
                  sourceApplication:sourceApplication
                        withSession:[PFFacebookUtils session]];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [FBAppCall handleDidBecomeActiveWithSession:[PFFacebookUtils session]];
    
    
}

- (void) logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user{
    [FBRequestConnection startForMeWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        if(!error) {
            [self facebookRequestDidLoad:result];
        } else {
            [self showErrorAndLogout];
        }
    }];
}
- (void)logInViewController:(PFLogInViewController *)logInController didFailToLogInWithError:(NSError *)error {
    [self showErrorAndLogout];
}

- (void) showErrorAndLogout {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Login Failed" message:@"Please try again" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
    [PFUser logOut];
}

- (void) facebookRequestDidLoad:(id) result {
    PFUser *user = [PFUser currentUser];
    if (user) {
        //update current user with facebook name, id
        NSString *fbName = result[@"name"];
        NSLog(@"NAME:%@", fbName);
        user.username = fbName;
        NSString *fbID = result[@"id"];
        user[@"fbID"] = fbID;
        
        //download profile pic
        NSURL *profilePicUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?type=square", fbID]];
        NSURLRequest *profilePicURLRequest = [NSURLRequest requestWithURL:profilePicUrl];
        [NSURLConnection connectionWithRequest:profilePicURLRequest delegate:self];
    }
}

- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [self showErrorAndLogout];
    
}
- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    _profilePicData = [[NSMutableData alloc] init];
}

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.profilePicData appendData:data];
}

- (void) connectionDidFinishLoading:(NSURLConnection *)connection {
    if (self.profilePicData.length == 0 || !self.profilePicData) {
        [self showErrorAndLogout];
    } else {
        PFFile *profilePicFile = [PFFile fileWithData:self.profilePicData];
        [profilePicFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!succeeded) {
                [self showErrorAndLogout];
            } else {
                PFUser *user = [PFUser currentUser];
                user[@"profilePicture"] = profilePicFile;
                NSLog(@"profilepic downloaded");
                [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    if (!succeeded) {
                        [self showErrorAndLogout];
                    } else {
                        [self.window.rootViewController dismissViewControllerAnimated:YES completion:nil];
                        [self.window.rootViewController presentViewController:[[MainViewController alloc] init] animated:YES completion:nil];


                    }
                }];
            }
        }];
    }
}

@end
