//
//  ViewController.m
//  Receipts++
//
//  Created by Thiago Hissa on 2017-07-20.
//  Copyright © 2017 Thiago Hissa. All rights reserved.
//


#import "ViewController.h"


@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *mytable;
@property (strong, nonatomic) NSArray *arrayPersonal;
@property (strong, nonatomic) NSArray *arrayBusiness;
@property (strong, nonatomic) NSArray *arrayFamily;
@property (strong, nonatomic) NSMutableArray *arrayFilter1;
@property (strong, nonatomic) NSMutableArray *arrayFilter2;
@property (strong, nonatomic) NSMutableArray *arrayFilter3;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.arrayPersonal = @[];
    self.arrayBusiness = @[];
    self.arrayFamily = @[];
    self.arrayFilter1 = [[NSMutableArray alloc]init];
    self.arrayFilter2 = [[NSMutableArray alloc]init];
    self.arrayFilter3 = [[NSMutableArray alloc]init];
    [self fetchReceipts];
}

-(void)viewWillAppear:(BOOL)animated{
    [self fetchReceipts];
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







-(void)fetchReceipts {
    NSFetchRequest *request = [Receipt fetchRequest];
   
    //  NSPredicate *nameSelection = [NSPredicate predicateWithFormat:@"name like %@", @"publish"];
    //  [request setPredicate:nameSelection];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
                                        initWithKey: @"name" ascending: NO];
    [request setSortDescriptors:@[sortDescriptor]];
    
    NSManagedObjectContext *context = [self getContext];
    NSError *error;
    NSArray *result = [context executeFetchRequest:request error:&error];
    
    if (error != nil) {
        NSLog(@"%@", error.localizedDescription);
    } else {
       // self.arrayPersonal = result;
        for (Receipt *r in result) {
            if ([r.hacktag containsString:@"p"]) {
                [self.arrayFilter1 addObject:r];
            }
            if ([r.hacktag containsString:@"f"]) {
                [self.arrayFilter2 addObject:r];
            }
            if ([r.hacktag containsString:@"b"]) {
                [self.arrayFilter3 addObject:r];
            }
        }
    //    self.arrayPersonal = self.arrayFilter1;
    //    self.arrayFamily = self.arrayFilter2;
    //    self.arrayBusiness = self.arrayFilter3;
        self.arrayPersonal = [[NSSet setWithArray: self.arrayFilter1] allObjects];
        self.arrayFamily = [[NSSet setWithArray: self.arrayFilter2] allObjects];
        self.arrayBusiness = [[NSSet setWithArray: self.arrayFilter3] allObjects];
        
        [self.mytable reloadData];
    }
}



/*
 -(void)fetchReceipts {
 NSFetchRequest *request = [Receipt fetchRequest];
 
 //  NSPredicate *nameSelection = [NSPredicate predicateWithFormat:@"name like %@", @"publish"];
 //  [request setPredicate:nameSelection];
 
 NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
 initWithKey: @"name" ascending: NO];
 [request setSortDescriptors:@[sortDescriptor]];
 
 NSManagedObjectContext *context = [self getContext];
 NSError *error;
 NSArray *result = [context executeFetchRequest:request error:&error];
 
 if (error != nil) {
 NSLog(@"%@", error.localizedDescription);
 } else {
 self.arrayPersonal = result;
 [self.mytable reloadData];
 }
 }
 */









#pragma TableView Setup

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSInteger count;
    
    if(section == 0){
        count = self.arrayPersonal.count;
    }
    else if(section == 1){
        count = self.arrayFamily.count;
    }
    else{
        count = self.arrayBusiness.count;
    }
    return count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self.mytable dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if(indexPath.section ==0){
    Receipt *receipt = self.arrayPersonal[indexPath.row];
    cell.textLabel.text = receipt.name;
    return cell;
    }
    else if(indexPath.section ==1) {
        Receipt *receipt = self.arrayFamily[indexPath.row];
        cell.textLabel.text = receipt.name;
        return cell;
    }
    else {
        Receipt *receipt = self.arrayBusiness[indexPath.row];
        cell.textLabel.text = receipt.name;
        return cell;
    }
    
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *string;
    if (section == 0) {
        string = @"Personal";
    }
    else if(section == 1){
        string = @"Family";
    }
    else{
        string = @"Business";
    }
    return string;
}









// Delete stuff

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSManagedObjectContext *context = [self getContext];
    if (indexPath.section == 0) {
        [context deleteObject:self.arrayPersonal[indexPath.row]];
    }
    else if (indexPath.section == 1) {
        [context deleteObject:self.arrayFamily[indexPath.row]];
    }
    else{
        [context deleteObject:self.arrayBusiness[indexPath.row]];
    }
    
    [self.appDelegate saveContext];
    [self.mytable reloadData];
}










@end
