#if !defined(INCLUDE_ASSEMBLER_OBJECT_H)
#define INCLUDE_ASSEMBLER_OBJECT_H

#include <stdio.h>

#define OBJ_BUFFER_SIZE 0x1000 // maximum size of the object buffer
#define OBJ_BUFFER_LINE 0xC00	 // how much must be filled before line flush happens
#define OBJ_BUFFER_SAFE 0xF00	 // how much safe space to leave before object buffer is written

extern FILE* objectFile;
extern char* objectPath;
extern volatile char* objectBufferPtr;
extern volatile char* objectListBufferPtr;
extern volatile uint64_t objectAddress;
extern volatile uint64_t objectAddrLine; // object address at the start of line
extern volatile char objectBuffer[OBJ_BUFFER_SIZE];

void initializeObjectFile();

void flushObjectBuffer();

void closeObjectFile();

uint64_t getObjectFilePos();

// helper object functions
#define objSetAddress()                  \
	objectListBufferPtr = objectBufferPtr; \
	writeListingsAddress(objectAddress);

// write various value sizes to object file
#define objWriteByte(d)              \
	*objectBufferPtr++ = (uint8_t)(d); \
	objectAddress++;

#define wordChangeEndian(d) ((((d)&0xFF) << 8) | (((d)&0xFF00) >> 8))
#define objWriteWordAll(d)                       \
	*((uint16_t*)objectBufferPtr) = (uint16_t)(d); \
	objectBufferPtr += 2;                          \
	objectAddress += 2;

#define longChangeEndian(d) ((((d)&0xFF) << 24) | (((d)&0xFF00) << 8) | (((d)&0xFF0000) >> 8) | (((d)&0xFF000000) >> 24))
#define objWriteLongAll(d)                       \
	*((uint32_t*)objectBufferPtr) = (uint32_t)(d); \
	objectBufferPtr += 4;                          \
	objectAddress += 4;

#define quadChangeEndian(d) ((((d)&0xFF) << 56) | (((d)&0xFF00) << 40) | (((d)&0xFF0000) << 24) | (((d)&0xFF000000) << 8) | (((d)&0xFF00000000) >> 8) | (((d)&0xFF0000000000) >> 24) | (((d)&0xFF000000000000) >> 40) | (((d)&0xFF00000000000000) >> 56))

#define objWriteQuadAll(d)                       \
	*((uint64_t*)objectBufferPtr) = (uint64_t)(d); \
	objectBufferPtr += 8;                          \
	objectAddress += 8;

#if ENDIANNESS == 0
#define objWriteWordLE(d) objWriteWordAll(wordChangeEndian(d));
#define objWriteWordBE(d) objWriteWordAll(d);
#define objWriteLongLE(d) objWriteLongAll(longChangeEndian(d));
#define objWriteLongBE(d) objWriteLongAll(d);
#else
#define objWriteWordBE(d) objWriteWordAll(wordChangeEndian(d));
#define objWriteWordLE(d) objWriteWordAll(d);
#define objWriteLongBE(d) objWriteLongAll(longChangeEndian(d));
#define objWriteLongLE(d) objWriteLongAll(d);
#endif

// write buffers to object file
#define objWriteArray(len, array)                                \
	if (objectBufferPtr + (len) >= objectBuffer + OBJ_BUFFER_SAFE) \
		flushObjectBuffer();                                         \
	memcpy((char*)objectBufferPtr, array, len);                    \
	objectBufferPtr += (len);                                      \
	objectAddress += (len);

// word-align file
#define objWordAlign()                                 \
	if ((objectAddress & 1) && options.automaticEvens) { \
		objWriteByte(options.fillChar);                    \
	}

#endif // INCLUDE_ASSEMBLER_OBJECT_H
