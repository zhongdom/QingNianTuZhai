#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "SQLite-Bridging.h"
#import "WCDB-Bridging.h"
#import "SQLiteRepairKit.h"
#import "sqliterk.h"
#import "sqliterk_btree.h"
#import "sqliterk_column.h"
#import "sqliterk_crypto.h"
#import "sqliterk_os.h"
#import "sqliterk_pager.h"
#import "sqliterk_util.h"
#import "sqliterk_values.h"
#import "sqlite3.h"
#import "fts3_tokenizer.h"

FOUNDATION_EXPORT double WCDBSwiftVersionNumber;
FOUNDATION_EXPORT const unsigned char WCDBSwiftVersionString[];

