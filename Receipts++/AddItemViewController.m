//
//  AddItemViewController.m
//  Receipts++
//
//  Created by Thiago Hissa on 2017-07-20.
//  Copyright © 2017 Thiago Hissa. All rights reserved.
//

#import "AddItemViewController.h"


@interface AddItemViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textfieldTotal;
@property (weak, nonatomic) IBOutlet UITextField *textfieldName;
@property (weak, nonatomic) IBOutlet UISwitch *switchPersonal;
@property (weak, nonatomic) IBOutlet UISwitch *switchFamily;
@property (weak, nonatomic) IBOutlet UISwitch *switchBusiness;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@end

@implementation AddItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}




#pragma DataCore

- (AppDelegate *)appDelegate {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (NSPersistentContainer *)getContainer{
    return [self appDelegate].persistentContainer;
}

- (NSManagedObjectContext *)getContext {
    return [self getContainer].viewContext;
}






- (IBAction)addReceipt:(id)sender {
    NSManagedObjectContext *context = [self getContext];
    Receipt *newreceipt = [NSEntityDescription insertNewObjectForEntityForName:@"Receipt" inManagedObjectContext:context];
    
    newreceipt.name = self.textfieldName.text;
    newreceipt.total = [self.textfieldTotal.text integerValue];
    

    if(self.switchPersonal.on)
    {
        newreceipt.hacktag = [NSString stringWithFormat:@"p"];
    }
    if(self.switchFamily.on)
    {
        newreceipt.hacktag = [NSString stringWithFormat:@"%@f",newreceipt.hacktag];
    }
    if(self.switchBusiness.on)
    {
        newreceipt.hacktag = [NSString stringWithFormat:@"%@b",newreceipt.hacktag];
    }
    NSLog(@"Hack tag: %@", newreceipt.hacktag);

    [self.thistag addReceiptsObject:newreceipt];
    [[self appDelegate] saveContext];
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    Tag *mytag = sender;
    ViewController *vc = segue.destinationViewController;
    vc.mytag = mytag;
}

























@end
