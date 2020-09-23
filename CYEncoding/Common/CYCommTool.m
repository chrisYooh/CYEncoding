//
//  CYCommTool.m
//  CYEncoding
//
//  Created by Chris Yang on 2020/9/23.
//

#import "CYCommTool.h"

void cytLogData_2s(NSData *data) {
   
    unsigned char *pData = (unsigned char *)data.bytes;
    for (int i = 0; i < data.length; i++) {
        
        unsigned char curVal = pData[i];
        for (int j = 7; j >= 0; j--) {
            printf("%d", (curVal >> j) % 2);
        }
        printf(" ");
    }
    
    printf("\n");
}

void cytLogData_16s(NSData *data) {
    
    unsigned char *pData = (unsigned char *)data.bytes;
    for (int i = 0; i < data.length; i++) {
        printf("%02x ", pData[i]);
    }
    
    printf("\n");
}

void cytLogStringData(NSString *inputStr, NSStringEncoding encoding) {
             
    for (int i = 0; i < inputStr.length; i++) {
        NSString *tmpStr = [inputStr substringWithRange:NSMakeRange(i, 1)];
        NSData *tmpData = [tmpStr dataUsingEncoding:encoding];
        printf("%s : %d\n", tmpStr.UTF8String, (int)tmpData.length);
        cytLogData_16s(tmpData);
        cytLogData_2s(tmpData);
        printf("\n");
    }

    NSData *inputData = [inputStr dataUsingEncoding:encoding];
    cytLogData_16s(inputData);
    cytLogData_2s(inputData);
    printf("字符数：%d \n字节数：%d \n每个字符平均占用： %.2f字节\n",
          (int)inputStr.length,
          (int)inputData.length,
          (float)inputData.length / inputStr.length);
}
