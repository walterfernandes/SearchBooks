//
//  BookParser.m
//  SearchBooks
//
//  Created by Walter Fernandes de Carvalho on 02/05/16.
//  Copyright © 2016 Walter Fernandes de Carvalho. All rights reserved.
//

#import "BookParser.h"
#import "Book.h"

@interface BookParser () {

    NSMutableArray *items;
    Book *currentItem;
    NSMutableString *tmpString;
    NSDictionary *tmpAttrDict;

    void (^successBlock)(NSArray *feedItems);
    void (^failureBlock)(NSError *error);

}

@end

@implementation BookParser


-(void)parseBooksWithSucces:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure {
    successBlock = [success copy];
    failureBlock = [failure copy];
    [self.parser parse];
}

-(instancetype)initWithXMLParser:(NSXMLParser *)parser {
    if (self = [super init]){
        items = [NSMutableArray array];
        parser.delegate = self;
        self.parser = parser;
    }
    return self;
}

#pragma mark - NSXMLParser

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
    
    if ([elementName isEqualToString:@"best_book"]) {
        currentItem = [Book new];
    }
    
    tmpString = [[NSMutableString alloc] init];
    tmpAttrDict = attributeDict;
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if ([elementName isEqualToString:@"best_book"]) {
        [items addObject:currentItem];
    }
    
    if (currentItem != nil && tmpString != nil) {
        
        if ([elementName isEqualToString:@"id"]) {
            [currentItem setId:[tmpString integerValue]];
        }
        else if ([elementName isEqualToString:@"title"]) {
            [currentItem setTitle:[tmpString stringByReplacingOccurrencesOfString:@"\n" withString:@""]];
        }
        else if ([elementName isEqualToString:@"author"]) {
            [currentItem setAuthor:[tmpString stringByReplacingOccurrencesOfString:@"\n" withString:@""]];
        }
        else if ([elementName isEqualToString:@"average_rating"]) {
            [currentItem setRating:[tmpString floatValue]];
        }
        else if ([elementName isEqualToString:@"image_url"]) {
            [currentItem setImageURL:[NSURL URLWithString:tmpString]];
        }
        else if ([elementName isEqualToString:@"small_image_url"]) {
            [currentItem setSmalImageURL:[NSURL URLWithString:tmpString]];
        }
        
    }
    
    if ([elementName isEqualToString:@"results"]) {
        successBlock(items);
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    [tmpString appendString:string];
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    failureBlock(parseError);
    [parser abortParsing];
}

@end
