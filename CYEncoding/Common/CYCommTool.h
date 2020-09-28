//
//  CYCommTool.h
//  CYEncoding
//
//  Created by Chris Yang on 2020/9/23.
//

#import <Foundation/Foundation.h>

#pragma Mark - 打印

// 打印 NSData 的 2进制数据
// groupNum : 几位一组
// sectionNum : 几组换行
void cytLogData_2s_format(NSData *data, int groupNum, int sectionNum);

void cytLogData_2s(NSData *data);           // 打印 NSData 的 2进制数据
void cytLogData_10s(NSData *data);          // 打印 NSData 的 10进制数据
void cytLogData_16s(NSData *data);          // 打印 NSData 的 16进制数据

#pragma mark - StringCoding（UTF-8）

// 打印字符串的不同编码的16进制数据（比如UTF-8）
void cytLogStringData(NSString *inputStr, NSStringEncoding encoding);

#pragma mark - Base64

// 打印base64的编码流程
void cytLogStringData_base64_flow(NSString *inputStr);




