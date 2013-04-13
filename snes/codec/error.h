#ifndef ERROR_H
#define ERROR_H
//============================================================// +-------+
// error.h                                                    // | | | * |
//                                                            // | |/    |
//                                                            // | |_| * |
//============================================================// +-------+

//============================================================//
// Enum                                                       //
//============================================================//
// Programs
typedef enum{
    // Null
    CODE_0=0       ,
    // Main
    CODE_main      ,
    // Audio codec
    CODE_brrMake   ,
    CODE_brrFree   ,
    CODE_brrRead   ,
    CODE_brrWrite  ,
    CODE_brrPrint  ,
    CODE_brrDecode ,
    CODE_pcmMake   ,
    CODE_pcmFree   ,
    CODE_pcmRead   ,
    CODE_pcmWrite  ,
    CODE_pcmPrint  ,
    CODE_pcmEncode ,
}code_e;

// Errors
typedef enum{
    // Error (Recovers)
    ERROR_0=0      , // Null error
    ERROR_custom   , // Custom message
    // Warns (Recovers, mutable)
    WARNS_0        , // Null warns
    WARNS_data     , // Bad data
    WARNS_custom   , // Custom message
    // Fatal (Terminates)
    FATAL_0        , // Null fatal
    FATAL_memory   , // Out of memory
    FATAL_path     , // Bad pathname
    FATAL_custom   , // Custom message
}error_e;

//============================================================//
// Prototype                                                  //
//============================================================//
void error(code_e, error_e, void*);
void mute (void);

//============================================================//
//                                                            //
//                                                            //
//                                                            //
//============================================================//
#endif
