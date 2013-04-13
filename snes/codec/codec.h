#ifndef CODEC_H
#define CODEC_H
//============================================================// +-------+
// codec.h                                                    // | | | * |
//                                                            // | |/    |
// SNES S-DSP BRR Audio Codec                                 // | |_| * |
//============================================================// +-------+
//============================================================//
// Struct                                                     //
//============================================================//
// BRR
typedef struct{ // BRR data
    int      shift;      // Decode shift
    int      filter;     // Decode filter
    int      loop;       // Loop block flag
    int      end;        // End block flag
    int      data[0x10]; // Encoded samples
}block_s;

typedef struct{ // BRR sound
    int      size;       // Block count
    block_s* blocks;     // Blocks
}brr_s;

// PCM
typedef struct{ // PCM sound
    int      size;       // Sample count
    int*     data;       // Samples
}pcm_s;

//============================================================//
// Prototype                                                  //
//============================================================//
// BRR
brr_s* brrMake   (int size);           // Make BRR
void   brrFree   (brr_s*);             // Free BRR
brr_s* brrRead   (FILE* in);           // Read  binary  BRR data
void   brrWrite  (brr_s*, FILE* out);  // Write binary  BRR date
void   brrPrint  (brr_s*, FILE* out);  // Print textual BRR data
pcm_s* brrDecode (brr_s*);             // BRR to PCM
// PCM
pcm_s* pcmMake   (int size);           // Make PCM
void   pcmFree   (pcm_s*);             // Free PCM
pcm_s* pcmRead   (FILE* in);           // Read  binary  PCM data
void   pcmWrite  (pcm_s*, FILE* out);  // Write binary  PCM data
void   pcmPrint  (pcm_s*, FILE* out);  // Print textual PCM data
brr_s* pcmEncode (pcm_s*, int delta, int filter, int loop); // PCM to BRR

//============================================================//
//                                                            //
//                                                            //
//                                                            //
//============================================================//
#endif
