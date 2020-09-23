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

void vytLogStringData_base64_utf8(NSString *inputStr) {
    
    for (int i = 0; i < inputStr.length; i++) {
        NSString *tmpStr = [inputStr substringWithRange:NSMakeRange(i, 1)];
        NSData *tmpData = [tmpStr dataUsingEncoding:NSUTF8StringEncoding];
        NSData *base64Data = [tmpData base64EncodedDataWithOptions:0];
        
        printf("%s : %d\n", tmpStr.UTF8String, (int)base64Data.length);
        printf("utf8: ");cytLogData_16s(tmpData);
        printf("utf8: ");cytLogData_2s(tmpData);
        printf("base64: ");cytLogData_16s(base64Data);
        printf("base64: ");cytLogData_2s(base64Data);
        printf("\n");
    }

    NSData *inputData = [inputStr dataUsingEncoding:NSUTF8StringEncoding];
    NSData *base64InputData = [inputData base64EncodedDataWithOptions:0];
    printf("utf8: ");cytLogData_16s(inputData);
    printf("utf8: ");cytLogData_2s(inputData);
    printf("base64: ");cytLogData_16s(base64InputData);
    printf("base64: ");cytLogData_2s(base64InputData);

    printf("字符数：%d \n字节数：%d \n每个字符平均占用： %.2f字节\n",
          (int)inputStr.length,
          (int)base64InputData.length,
          (float)base64InputData.length / inputStr.length);
}

void vytLogStringData_base64_orig(NSString *inputStr) {
    
    for (int i = 0; i < inputStr.length; i++) {
        NSString *tmpStr = [inputStr substringWithRange:NSMakeRange(i, 1)];
        NSData *tmpData = [tmpStr dataUsingEncoding:NSUTF8StringEncoding];
        NSData *base64Data = [tmpData base64EncodedDataWithOptions:0];
        NSData *base64OrigData = cytBase64OrigData(base64Data);
        
        printf("%s : %d\n", tmpStr.UTF8String, (int)base64Data.length);
        printf("utf8: ");cytLogData_16s(tmpData);
        printf("utf8: ");cytLogData_2s(tmpData);
        printf("base64: ");cytLogData_16s(base64OrigData);
        printf("base64: ");cytLogData_2s(base64OrigData);
        printf("\n");
    }

    NSData *inputData = [inputStr dataUsingEncoding:NSUTF8StringEncoding];
    NSData *base64InputData = [inputData base64EncodedDataWithOptions:0];
    NSData *base64OrigInputData = cytBase64OrigData(base64InputData);
    printf("utf8: ");cytLogData_16s(inputData);
    printf("utf8: ");cytLogData_2s(inputData);
    printf("base64: ");cytLogData_16s(base64OrigInputData);
    printf("base64: ");cytLogData_2s(base64OrigInputData);
    printf("字符数：%d \n字节数：%d \n每个字符平均占用： %.2f字节\n",
          (int)inputStr.length,
          (int)base64OrigInputData.length,
          (float)base64OrigInputData.length / inputStr.length);
}

NSData * cytBase64OrigData(NSData *base64Utf8Data) {
    
    NSMutableData *tmpMulData = [[NSMutableData alloc] init];
    
    unsigned char *pData = (unsigned char *)base64Utf8Data.bytes;
    for (int i = 0; i < base64Utf8Data.length; i++) {
        unsigned char origVal = cytBase64OrigValue(pData[i]);
        [tmpMulData appendBytes:&origVal length:1];
    }
    
    return tmpMulData.copy;
}

unsigned char cytBase64OrigValue(unsigned char asciiVal) {
    
    if (asciiVal >= 'A' && asciiVal <= 'Z') {
        return asciiVal - 'A';
    }
    
    else if (asciiVal >= 'a' && asciiVal <= 'z') {
        return asciiVal - 'a';
    }

    else if (asciiVal >= '0' && asciiVal <= '9') {
        return asciiVal - '0';
    }
    
    else if (asciiVal == '+') {
        return 62;
    }
    
    else if (asciiVal == '/') {
        return 63;
    }

    return 0;
}
