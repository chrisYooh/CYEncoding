//
//  CYCommTool.h
//  CYEncoding
//
//  Created by Chris Yang on 2020/9/23.
//

#import <Foundation/Foundation.h>

// 打印 NSData 的 2进制数据
void cytLogData_2s(NSData *data);

// 打印 NSData 的 16进制数据
void cytLogData_16s(NSData *data);

// 打印字符串的不同编码的16进制数据
void cytLogStringData(NSString *inputStr, NSStringEncoding encoding);

// 打印将base64编码转为为约定目标字符的数据
void vytLogStringData_base64_utf8(NSString *inputStr);

// 打印将base64编码的原始数据
void vytLogStringData_base64_orig(NSString *inputStr);

// 将映射 UTF-8 的base64数据恢复成原始的base64数据
NSData * cytBase64OrigData(NSData *base64Utf8Data);

// 将 ASCII 字符转化为 base64 索引
unsigned char cytBase64OrigValue(unsigned char asciiVal);





