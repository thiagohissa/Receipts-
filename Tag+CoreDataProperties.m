//
//  Tag+CoreDataProperties.m
//  Receipts++
//
//  Created by Thiago Hissa on 2017-07-20.
//  Copyright © 2017 Thiago Hissa. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Tag+CoreDataProperties.h"

@implementation Tag (CoreDataProperties)

+ (NSFetchRequest<Tag *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Tag"];
}

@dynamic tag;
@dynamic receipts;

@end
