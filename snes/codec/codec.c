#ifndef CODEC_C
#define CODEC_C
//============================================================// +-------+
// codec.c                                                    // | | | * |
//                                                            // | |/    |
// SNES S-DSP BRR Audio Codec                                 // | |_| * |
//============================================================// +-------+
#include <stdio.h>
#include <stdlib.h>
#include "codec.h"
#include "error.h"

//============================================================//
// brrMake()                                                  //
//============================================================//
brr_s* brrMake(int s){
    brr_s *b;
    // Allocate
    if(!(b=(brr_s*)malloc(sizeof(brr_s))))
        error(CODE_brrMake,FATAL_memory,(void*)"brr_s");
    // Initialize
    b->size=s;
    if(s){
        if(!(b->blocks=(block_s*)malloc(b->size*sizeof(block_s))))
            error(CODE_brrMake,FATAL_memory,(void*)"block_s[]");
    }else{
        b->blocks=0;
    }
    return b;
}

//============================================================//
// brrFree()                                                  //
//============================================================//
void brrFree(brr_s *b){
    if(b){
        // Free members
        if(b->blocks) free(b->blocks);
        // Free
        free(b);
    }
    return;
}

//============================================================//
// brrRead()                                                  //
//============================================================//
brr_s* brrRead(FILE* in){
    brr_s* b=0;
    if(in){
        // Allocate brr_s
        b=brrMake(0);
        // Read blocks loop
        int  r,d;
        char c[9];
        for(b->size=0; r=fread(&c,1,9,in); b->size++){
            if(r==9){
                // Allocate block_s
                if(!(b->blocks=(block_s*)realloc((void*)b->blocks,(b->size+1)*sizeof(block_s))))
                    error(CODE_brrRead,FATAL_memory,(void*)"block_s[]");
                block_s *block=&b->blocks[b->size];
                // Header
                block->shift =(int)((c[0]&0xF0)>>4);
                block->filter=(int)((c[0]&0x0C)>>2);
                block->loop  =(int)((c[0]&0x02)>>1);
                block->end   =(int)((c[0]&0x01)>>0);
                // Data
                int i;
                for(i=0; i<0x10; i++){
                    d=(int)((i%2?c[1+i/2]:c[1+i/2]>>4)&0xF);
                    block->data[i]=d&0x8?d|~0xF:d&0xF;
                }
            }else{
                 // Ignore block
                 error(CODE_brrRead,WARNS_data,(void*)"incomplete block");
                 break;
            }
        }
    }
    return b;
}

//============================================================//
// brrWrite()                                                 //
//============================================================//
void brrWrite(brr_s* b, FILE* out){
    if(b&&out){
        // Write blocks loop
        int i;
        for(i=0; i<b->size; i++){
            block_s *block=&b->blocks[i];
            // Header
            fputc
            ((block->shift <<4)&0xF0
            |(block->filter<<2)&0x0C
            |(block->loop  <<1)&0x02
            |(block->end   <<0)&0x01
            ,out
            );
            // Data
            int j;
            for(j=0; j<0x08; j++)
                fputc((block->data[j*2]<<4)&0xF0|(block->data[1+j*2])&0x0F,out);
        }
    }
    return;
}

//============================================================//
// brrPrint()                                                 //
//============================================================//
void brrPrint(brr_s* b, FILE* out){
    if(!out) out=stderr;
    // Table header
    fprintf(out,"+-----------+\n"
                "| BRR Sound |\n"
                "+-----------+\n"
                "+------+---------+---------------------------------+\n"
                "| Unit | S F L E | Data                            |\n"
                "+------+---------+---------------------------------+\n");
    // Table data
    if(b&&b->size){
        // Print blocks
        int i,j;
        for(i=0; i<b->size; i++){
            block_s *block=&b->blocks[i];
            fprintf(out,"| %0.4X | %X %X %X %X | ",i&0xFFFF
            ,block->shift&0xF,block->filter&0x3
            ,block->loop &0x1,block->end   &0x1
            );
            for(j=0; j<0x10; j++) fprintf(out,"%X ",0xF&block->data[j]);
            fprintf(out,"|\n");
        }
    }else{
        // Null brr
        fprintf(out,"| xxxx | x x x x | x x x x x x x x x x x x x x x x |\n");
    }
    // Table footer
    fprintf(out,"+------+---------+---------------------------------+\n\n");
    return;
}

//============================================================//
// brrDecode()                                                //
//============================================================//
pcm_s* brrDecode(brr_s* b){
    pcm_s* p=0;
    if(b){
        // Allocate pcm_s
        p=pcmMake(0x10*b->size);
        // Decode block loop
        int i,j;  // Block index, sample index
        int s0;   // Sample[x]
        int s1=0; // Sample[x-1]
        int s2=0; // Sample[x-2]
        for(i=0; i<b->size; i++){
            block_s *block=&b->blocks[i];
            // Decode sample loop
            for(j=0; j<0x10; j++){
                // Decode sample
                s0=block->shift<=0xC?
                    block->data[j]<<block->shift>>1:
                    block->data[j]<0?~0x07FF:0x0000;
                // Filter sample
                switch(block->filter){
                case 0:                                    break; // Direct 
                case 1: s0+=  s1+(-   s1>>4)             ; break; // 15/16
                case 2: s0+=2*s1+(- 3*s1>>5)-s2+(  s2>>4); break; // 61/32-15/16
                case 3: s0+=2*s1+(-13*s1>>6)-s2+(3*s2>>4); break; //115/64-13/16
                }
                // Clamp sample
                s0=(s0<-0x8000?-0x8000:(s0>0x7FFF?0x7FFF:s0));
                // Rotate samples
                s2=s1;
                s1=s0;
                // Write sample
                p->data[0x10*i+j]=s0;
            }
        }
    }
    return p;
}

//============================================================//
// pcmMake()                                                  //
//============================================================//
pcm_s* pcmMake(int s){
    pcm_s *p;
    // Allocate
    if(!(p=(pcm_s*)malloc(sizeof(pcm_s))))
        error(CODE_pcmMake,FATAL_memory,(void*)"pcm_s");
    // Initialize
    p->size=s;
    if(s){
        if(!(p->data=(int*)malloc(s*sizeof(int))))
            error(CODE_pcmMake,FATAL_memory,(void*)"int[]");
    }else{
        p->data=0;
    }
    return p;
}

//============================================================//
// pcmFree()                                                  //
//============================================================//
void pcmFree(pcm_s *p){
    if(p){
        // Free members
        if(p->data) free(p->data);
        // Free
        free(p);
    }
    return;
}

//============================================================//
// pcmRead()                                                  //
//============================================================//
pcm_s* pcmRead(FILE* in){
    pcm_s* p=0;
    if(in){
        // Allocate pcm_s
        p=pcmMake(0);
        // Read samples loop
        int r,d;
        for(; r=fread(&d,1,2,in); p->size++){
            if(r==2){
                // Read sample
                if(!(p->data=(int*)realloc((void*)p->data,(p->size+1)*sizeof(int))))
                    error(CODE_pcmRead,FATAL_memory,(void*)"int[]");
                p->data[p->size]=d&0x8000?d|~0xFFFF:d&0xFFFF; // Sign extend
            }else{
                 // Ignore sample
                 error(CODE_pcmRead,WARNS_data,(void*)"incomplete sample");
                 break;
            }
        }
    }
    return p;
}

//============================================================//
// pcmWrite()                                                 //
//============================================================//
void pcmWrite(pcm_s* p, FILE* out){
    if(p&&out){
        // Write samples loop
        int i;
        for(i=0; i<p->size; i++) fwrite((const void*)&p->data[i],1,2,out);
    }
    return;
}

//============================================================//
// pcmPrint()                                                 //
//============================================================//
void pcmPrint(pcm_s* p, FILE* out){
    // Default stream
    if(!out) out=stderr;
    // Table header
    fprintf(out,"+-----------+\n"
                "| PCM Sound |\n"
                "+-----------+\n"
                "+------+-----------------------------------------+\n"
                "| Unit | Data                                    |\n"
                "+------+-----------------------------------------+\n");
    // Table data
    if(p&&p->size){
        // Print samples
        int i,j;
        for(i=0; i<p->size;){
            fprintf(out,"| %0.4X | ",i&0xFFFF);
            for(j=0; i<p->size&&j<8; i++,j++) fprintf(out,"%0.4hX ",p->data[i]);
            for(; j<8; j++) fprintf(out,"xxxx ");
            fprintf(out,"|\n");
        }
    }else{
        // Null pcm
        fprintf(out,"| xxxx | xxxx xxxx xxxx xxxx xxxx xxxx xxxx xxxx |\n");
    }
    // Table footer
    fprintf(out,"+------+-----------------------------------------+\n\n");
    return;
}

//============================================================//
// pcmEncode()                                                //
//============================================================//
brr_s* pcmEncode(pcm_s* pcm, int delta, int filter, int loop){
    brr_s* brr=0;
    if(pcm){
        int i,j;        // Block index, sample index
        int d0;         // Sample
        int d1,d2;      // Decode[x-1], decode[x-2]
        int da=0,db=0;  // Decode[x-1], decode[x-2] initial
        int dat,dbt;    // Decode initial buffer
        int d[0x10];    // Decode buffer
        int e[0x10];    // Encode buffer
        int f;          // Filter
        int s;          // Shift
        int epsilon;    // Error
        int epsilonMin; // Error minimum
        block_s *b;     // Block pointer
        // Error check delta
        if(delta<=0) delta=1;
        // Allocate brr_s
        brr=brrMake(pcm->size/(0x10*delta)+(pcm->size%(0x10*delta)?1:0));
        // Encode BRR block loop
        for(i=0; i<pcm->size; i+=0x10*delta){
            b=&brr->blocks[i/(0x10*delta)];
            // Loop
            b->loop=(0<=loop&&loop<=i+0x10*delta?1:0);
            // End
            b->end=i+0x10*delta<pcm->size?0:1;
            // Shift, filter, data
            epsilonMin=0x10000*0x10;
            for(f=filter<0||3<filter?0:filter; f<4; f++){
                s=0;
recode:         d1=da;
                d2=db;
                epsilon=0;
                // Encode samples
                for(j=0; j<0x10; j++){
                    // Sample or pad
                    d0=i+j*delta<pcm->size?pcm->data[i+j*delta]:0;
                    // Naive encode
                    switch(f){
                    case 0: // Direct 
                        e[j]=d0<<1>>s;
                        d[j]=e[j]<<s>>1;
                        break;
                    case 1: // 15/16
                        e[j]=(d0-d1-(-d1>>4))<<1>>s;
                        d[j]=(e[j]<<s>>1)+d1+(-d1>>4);
                        break;
                    case 2: // 61/32  - 15/16
                        e[j]=(d0-2*d1-(-3*d1>>5)+d2-(d2>>4))<<1>>s;
                        d[j]=(e[j]<<s>>1)+2*d1+(-3*d1>>5)-d2+(d2>>4);
                        break;
                    case 3: // 115/64 - 13/16
                        e[j]=(d0-2*d1-(-13*d1>>6)+d2-(3*d2>>4))<<1>>s;
                        d[j]=(e[j]<<s>>1)+2*d1+(-13*d1>>6)-d2+(3*d2>>4);
                        break;
                    }
                    // Greedy encode
                    ;;;;; if(d0==0x7FFF){  // Positive overflow
                        if(e[j]!=0x7||d[j]!=0x7FFF){
                            do e[j]++; while(e[j]<-0x8);
                        }
                        d[j]=0x7FFF;
                    }else if(d0==-0x8000){ // Negative overflow
                        if(e[j]!=-0x8||d[j]!=-0x8000){
                            while(e[j]>0x7) e[j]--;
                        }
                        d[j]=-0x8000;
                    }else if((e[j]==-0x9)  // Fix truncation error
                          ||((d[j]-(e[j]<<s>>1)+(e[j]+1<<s>>1)-d0)<(d0-d[j]))
                          ){
                        d[j]-=e[j]<<s>>1;
                        d[j]+=++e[j]<<s>>1;
                    }
                    // Clamp decode
                    d[j]=(d[j]<-0x8000?-0x8000:(d[j]>0x7FFF?0x7FFF:d[j]));
                    // Out of range
                    if(e[j]<-0x8||0x7<e[j]){
                        if(s<0xC){
                            // Shift
                            s++;
                            goto recode;
                        }else{
                            // Clamp
                            e[j]=e[j]<0?-0x8:0x7;
                            switch(f){
                            case 0: d[j]=(e[j]<<s>>1)                              ; break;
                            case 1: d[j]=(e[j]<<s>>1)+  d1+(-   d1>>4)             ; break;
                            case 2: d[j]=(e[j]<<s>>1)+2*d1+(- 3*d1>>5)-d2+(  d2>>4); break;
                            case 3: d[j]=(e[j]<<s>>1)+2*d1+(-13*d1>>6)-d2+(3*d2>>4); break;
                            }
                            d[j]=(d[j]<-0x8000?-0x8000:(d[j]>0x7FFF?0x7FFF:d[j]));
                        }
                    }
                    // Rotate samples
                    d2=d1;
                    d1=d[j];
                    // Error
                    if(filter<0||3<filter) epsilon+=abs(d0-d[j]);
                }
                // Pick encoding
                if(epsilonMin>epsilon){
                    epsilonMin=epsilon;
                    // Buffer block
                    b->shift=s;
                    b->filter=f;
                    for(j=0; j<0x10; j++) b->data[j]=e[j];
                    // Buffer initial decodes
                    dat=d[0xF];
                    dbt=d[0xE];
                    // Perfect or perfered
                    if(epsilon<=0||0<=filter&&filter<=3) break;
                }
            }
            // Update initial decodes
            da=dat;
            db=dbt;
        }
    }
    return brr;
}

//============================================================//
//                                                            //
//                                                            //
//                                                            //
//============================================================//
#endif
