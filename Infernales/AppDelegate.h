//
//  AppDelegate.h
//  Infernales
//
//  Created by Guido Wehner on 11.06.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChoiceViewController.h"
#import "Three20/Three20.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    UINavigationController *navigationController;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
