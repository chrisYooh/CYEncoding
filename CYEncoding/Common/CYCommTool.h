//
//  CYCommTool.h
//  CYEncoding
//
//  Created by Chris Yang on 2020/9/23.
//

#import <Foundation/Foundation.h>

// 打印 NSData 的 16进制数据
void cytLogData_2s(NSData *data);
void cytLogData_16s(NSData *data);

// 打印字符串的不同编码的16进制数据
void cytLogStringData(NSString *inputStr, NSStringEncoding encoding);





