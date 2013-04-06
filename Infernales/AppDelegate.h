//
//  AppDelegate.h
//  Infernales
//
//  Created by Guido Wehner on 11.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChoiceViewController.h"
#import "ASIFormDataRequest.h"
#import "MBProgressHUD.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    UINavigationController *navigationController;
    bool needsUpdatePost;
    bool unregistered;
    NSData *pushDeviceToken;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) NSData *pushDeviceToken;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property bool needsUpdatePost;
@property bool unregistered;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
