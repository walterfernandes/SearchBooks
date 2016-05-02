//
//  GoodReads.h
//  SearchBooks
//
//  Created by Walter Fernandes de Carvalho on 01/05/16.
//  Copyright © 2016 Walter Fernandes de Carvalho. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^GoodReadsServicesSuccessBlock)(NSArray * _Nullable response);
typedef void (^GoodReadsServicesFailureBlock)(NSError  * _Nonnull error);

@interface GoodReads : NSObject

+(instancetype _Nonnull)sharedInstance;


/** Search Books on GoodReads API
 *
 * @param query The query text to match against book title, author, and ISBN fields. 
 * Supports boolean operators and phrase searching.
 *
 * @param success The callback block to handle success returns. Can be nil.
 *
 * @param failure The callback blcok to handle failere returns. Can be nil.
 */
-(void)searchBooksWithQuery:(NSString* _Nonnull)query soccess:(GoodReadsServicesSuccessBlock _Nullable)success failure:(GoodReadsServicesFailureBlock _Nullable)failure;

@end
