//
//  AddItemViewController.h
//  Receipts++
//
//  Created by Thiago Hissa on 2017-07-20.
//  Copyright © 2017 Thiago Hissa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Tag+CoreDataClass.h"
#import "Receipt+CoreDataClass.h"
#import "ViewController.h"

@interface AddItemViewController : UIViewController
@property (nonatomic) Tag *thistag;
@property (nonatomic) Receipt *thisreceipt;
@property (strong, nonatomic) NSArray *arrayPersonal;
@property (strong, nonatomic) NSArray *arrayBusiness;
@property (strong, nonatomic) NSArray *arrayFamily;
@end
