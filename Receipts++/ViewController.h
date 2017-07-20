//
//  ViewController.h
//  Receipts++
//
//  Created by Thiago Hissa on 2017-07-20.
//  Copyright © 2017 Thiago Hissa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Receipt+CoreDataClass.h"
#import "Tag+CoreDataClass.h"
#import "AddItemViewController.h"
#import "AppDelegate.h"

@interface ViewController : UIViewController

@property (nonatomic) Tag *mytag;
@end

