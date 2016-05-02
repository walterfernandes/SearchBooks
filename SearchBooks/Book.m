//
//  Book.m
//  SearchBooks
//
//  Created by Walter Fernandes de Carvalho on 01/05/16.
//  Copyright © 2016 Walter Fernandes de Carvalho. All rights reserved.
//

#import "Book.h"

@implementation Book

-(NSString *)description {
    return [NSString stringWithFormat:@"%@ (%@)", self.title, self.author];
}

@end
