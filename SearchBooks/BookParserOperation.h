//
//  BookParser.h
//  SearchBooks
//
//  Created by Walter Fernandes de Carvalho on 02/05/16.
//  Copyright © 2016 Walter Fernandes de Carvalho. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookParserOperation : NSOperation <NSXMLParserDelegate>

@property (nonatomic, strong) NSXMLParser *parser;

/** Search Books on GoodReads API
 *
 * @return BookParseOperation
 *
 * @param parser The XML parser.
 *
 */

-(instancetype)initWithXMLParser:(NSXMLParser*)parser;

/** Parse XML to get Books list
 *
 * @param success The callback block to handle success returns. Can be nil.
 *
 * @param failure The callback blcok to handle failere returns. Can be nil.
 */

-(void)parseBooksWithSucces:(void (^)(NSArray *items))success
                     failure:(void (^)(NSError *error))failure;

@end
