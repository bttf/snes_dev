#ifndef ERROR_C
#define ERROR_C
//============================================================// +-------+
// error.c                                                    // | | | * |
//                                                            // | |/    |
//                                                            // | |_| * |
//============================================================// +-------+
#include <stdio.h>
#include <stdlib.h>
#include "error.h"

//============================================================//
// Globals                                                    //
//============================================================//
static int talk=1; // Print warnings flag

//============================================================//
// error()                                                    //
//============================================================//
void error(code_e c, error_e e, void* p){
    if(e<WARNS_0||WARNS_custom>e||talk){
        // Print error type
        ;;;; if(ERROR_0<=e&&e<=ERROR_custom) fprintf(stderr,"ERROR: "  );
        else if(WARNS_0<=e&&e<=WARNS_custom) fprintf(stderr,"WARNING: ");
        else if(FATAL_0<=e&&e<=FATAL_custom) fprintf(stderr,"FATAL: "  );
        // Print program name
        switch(c){
            // Null
            case CODE_0         : break;
            // Main
            case CODE_main      : fprintf(stderr,"main(): "     ); break;
            // Audio codec
            case CODE_brrMake   : fprintf(stderr,"brrMake(): "  ); break;
            case CODE_brrFree   : fprintf(stderr,"brrFree(): "  ); break;
            case CODE_brrRead   : fprintf(stderr,"brrRead(): "  ); break;
            case CODE_brrWrite  : fprintf(stderr,"brrWrite(): " ); break;
            case CODE_brrPrint  : fprintf(stderr,"brrPrint(): " ); break;
            case CODE_brrDecode : fprintf(stderr,"brrDecode(): "); break;
            case CODE_pcmMake   : fprintf(stderr,"pcmMake(): "  ); break;
            case CODE_pcmFree   : fprintf(stderr,"pcmFree(): "  ); break;
            case CODE_pcmRead   : fprintf(stderr,"pcmRead(): "  ); break;
            case CODE_pcmWrite  : fprintf(stderr,"pcmWrite(): " ); break;
            case CODE_pcmPrint  : fprintf(stderr,"pcmPrint(): " ); break;
            case CODE_pcmEncode : fprintf(stderr,"pcmEncode(): "); break;
            // Default
            default             : fprintf(stderr,"Unknown(): "  ); break;
        }
        // Print error
        switch(e){
            case ERROR_0        : break;
            case WARNS_data     : fprintf(stderr,"Ignored %s"      ,(char*)p); break;
            case FATAL_memory   : fprintf(stderr,"Failed alloc(%s)",(char*)p); break;
            case FATAL_path     : fprintf(stderr,"\"%s\" not found",(char*)p); break;
            default             : fprintf(stderr,"Unknown"                  ); break;
        }
        fprintf(stderr,"\n\n");
        // Exit if fatal
        if(FATAL_0<=e&&e<=FATAL_custom) for(;;); // exit(1); for for WINDOWS!
    }
    return;
}

//============================================================//
// mute()                                                     //
//============================================================//
void mute(void){
    talk=0;
    return;
}

//============================================================//
//                                                            //
//                                                            //
//                                                            //
//============================================================//
#endif
