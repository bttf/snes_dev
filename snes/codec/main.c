#ifndef MAIN_C
#define MAIN_C
//============================================================// +-------+
// codec.c                                                    // | | | * |
//                                                            // | |/    |
// SNES S-DSP BRR Audio Codec                                 // | |_| * |
//============================================================// +-------+
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "codec.h"
#include "error.h"

//============================================================//
// !!!DEBUG!!! Development Driver                             //
//============================================================//
int main(int argc, char *argv[]){
    // Declarations
    FILE  *in=0;
    FILE  *out=0;
    FILE  *report;
    pcm_s *p=0,*p2=0;
    brr_s *b=0,*b2=0;
    block_s *block,*block2;
    // Welcome
    fprintf(stderr,"+----------------------+\n"
                   "| SNES BRR Audio Codec |\n"
                   "| Registar        v1.0 |\n"
                   "+----------------------+\n\n");
    // Prompt
    if(argc!=3){
        fprintf(stderr,"Usage: %s [input.pcm][output.brr]\n",argv[0]);
        for(;;); // Windows
        exit(0);
    }
/*
    // Identity Stress Test
    int i,j,k;
    int loop;
    int errors=0;
    srand(time(NULL));
    for(i=0;i<1;i++) rand();
    for(i=0; i<0x100; i++){ // Test Loop
        // Build random BRR
        b=brrMake(rand()%0x1000);
        loop=rand()%(b->size*0x10);
        fprintf(stderr,"Test: %0.4X brr[%0.4X]\n",i,b->size);
        for(j=0; j<b->size; j++){ // Build block
            block=&b->blocks[j];
            block->shift =rand()%0xD;
            block->filter=rand()%4;
            block->loop=(0<=loop&&loop<=(j+1)*0x10?1:0);
            block->end=(j+1==b->size)?1:0;
            for(k=0; k<0x10; k++){
                int r=rand();
                block->data[k]=r&0x8?r|~0xF:r&0xF;
            }
        }
        // Decode, encode random BRR
        p =brrDecode(b);
        b2=pcmEncode(p,1,-1,loop);
        p2=brrDecode(b2);
        //brrPrint(b ,0);
        //brrPrint(b2,0);
        //pcmPrint(p ,0);
        //pcmPrint(p2,0);
        // Compare
        if(b->size==b2->size){
            for(j=0; j<b->size; j++){
                block =&b ->blocks[j];    
                block2=&b2->blocks[j];
                int e=0;
                for(k=0; k<0x10; k++)
                    if(p->data[j*0x10+k]!=p2->data[j*0x10+k]||block->loop!=block2->loop) e=1;
                if(e){
                    errors++;
                    fprintf(stderr,"[%X][%X%X%X%X][",j,block->shift,block->filter,block->loop,block->end);
                    for(k=0;k<0x10;k++) fprintf(stderr,"%X",block->data[k]&0xF);
                    fprintf(stderr,"] => [%X%X%X%X][",block2->shift,block2->filter,block2->loop,block2->end);
                    for(k=0;k<0x10;k++) fprintf(stderr,"%X",block2->data[k]&0xF);
                    fprintf(stderr,"]\n");
                }
            }
        }else{
            fprintf(stderr,"Unequal sizes\n");
        }
        brrFree(b);
        brrFree(b2);
        pcmFree(p);
        pcmFree(p2);
    }
    fprintf(stderr,"\nErrors: %i\n\n",errors);
*/
/*
    // BRR->PCM->BRR Test
    if(!(in=fopen(argv[1],"rb"))) error(CODE_main,FATAL_path,(char*)argv[1]);
    b=brrRead(in);
    fclose(in);
    //out=fopen("out.txt","w");
    brrPrint(b,0);
    p=brrDecode(b);
    brrFree(b);
    pcmPrint(p,0);
    b=pcmEncode(p,1,-1,-1);
    pcmFree(p);
    brrPrint(b,0);
    //if(!(out=fopen(argv[2],"wb"))) error(CODE_main,FATAL_path,(char*)argv[2]);
    //brrWrite(b,out);
    //fclose(out);
    p=brrDecode(b);
    brrFree(b);
    pcmPrint(p,0);
    pcmFree(p);  
/*
    // PCM->BRR->PCM Test
    // Read PCM
    if(!(in=fopen(argv[1],"rb"))) error(CODE_main,FATAL_path,(char*)argv[1]);
    p=pcmRead(in);
    fclose(in);
    //pcmPrint(p,0);
    // Encode->Decode Test
    b=pcmEncode(p,1,-1,-1);
    pcmFree(p);
    brrPrint(b,0);
    p=brrDecode(b);
    //pcmPrint(p,0);
    pcmFree(p);
    // Write BRR
    if(!(out=fopen(argv[2],"wb"))) error(CODE_main,FATAL_path,(char*)argv[2]);
    brrWrite(b,out);
    fclose(out);
    brrFree(b);
*/
/* Decode Equations
    d0=(c<<s)>>1;
    p1=d0+  s1+(-   s1>>4);
    p2=d0+2*s1+(- 3*s1>>5)-s2+(  s2>>4);
    p3=d0+2*s1+(-13*s1>>6)-s2+(3*s2>>4);
*/
    // Done
    fprintf(stderr,"-Done-\n\n");
    for(;;); // Windows
    return 0;
}

//============================================================//
//                                                            //
//                                                            //
//                                                            //
//============================================================//
#endif
