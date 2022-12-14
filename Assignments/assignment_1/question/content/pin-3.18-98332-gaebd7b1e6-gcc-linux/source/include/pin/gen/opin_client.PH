//Groups: @ingroup\s+(API_REF|KNOBS|IMG_BASIC_API|INS_BASIC_API|INS_INST_API|INS_BASIC_API_GEN_IA32|INS_BASIC_API_IA32|INS_MOD_API_GEN_IA32|SEC_BASIC_API|RTN_BASIC_API|REG_BASIC_API|REG_CPU_GENERIC|REG_CPU_IA32|TRACE_BASIC_API|BBL_BASIC_API|SYM_BASIC_API|MISC_PRINT|MISC_PARSE|KNOB_API|KNOB_BASIC|KNOB_PRINT|LOCK|PIN_CONTROL|TRACE_VERSION_API|BUFFER_API|PROTO_API|PIN_PROCESS_API|PIN_THREAD_API|PIN_SYSCALL_API|WINDOWS_SYSCALL_API_UNDOC|DEBUG_API|ERROR_FILE_BASIC|TYPE_BASE|INSTLIB|ALARM|CHILD_PROCESS_API|UTILS|MISC|CONTEXT_API|PHYSICAL_CONTEXT_API|PIN_CALLBACKS|EXCEPTION_API|APPDEBUG_API|STOPPED_THREAD_API|BUFFER_API|PROTO|INST_ARGS|DEPRECATED_PIN_API|INTERNAL_EXCEPTION_PRIVATE_UNDOCUMENTED|PIN_THREAD_PRIVATE|CHILD_PROCESS_INTERNAL|BBL_BASIC|ROGUE_BASIC_API|MESSAGE_TYPE|MESSAGE_BASIC|ERRFILE|MISC_BASIC|ITC_INST_API|CONTEXT_API_UNDOC|EXCEPTION_API_UNDOC|UNDOCUMENTED_PIN_API|OPIN|TRACE_VERSIONS

#ifdef PIN_G_OPIN_CLIENT_PH
#error duplicate inclusion of opin_client
#else
#define PIN_G_OPIN_CLIENT_PH
/// @cond INTERNAL_DOXYGEN
typedef VOID (*TRACEGENCODE_CALLBACK)(TRACE trace, VOID *v);

/// @endcond
extern BOOL PIN_IsProbeMode();

extern BOOL PIN_IsAttaching();

extern BOOL RTN_IsSafeForProbedInsertion(RTN rtn);

extern BOOL RTN_IsSafeForProbedInsertionEx(RTN rtn, PROBE_MODE mode);

extern BOOL RTN_IsSafeForProbedReplacement(RTN rtn);

extern BOOL RTN_IsSafeForProbedReplacementEx(RTN rtn, PROBE_MODE mode);

extern AFUNPTR RTN_ReplaceSignatureProbed(RTN replacedRtn, AFUNPTR replacementFun, ...);

extern AFUNPTR RTN_ReplaceSignatureProbedEx(RTN replacedRtn, PROBE_MODE mode,
                                               AFUNPTR replacementFun, ...);

extern VOID RTN_InsertCallProbed( RTN orgRtn, IPOINT action, AFUNPTR funptr, ... );

extern VOID RTN_InsertCallProbedEx( RTN orgRtn, IPOINT action,
                                      PROBE_MODE mode,
                                      AFUNPTR funptr, ... );

extern BOOL PIN_IsSafeForProbedInsertion(ADDRINT addr);

extern VOID PIN_InsertCallProbed(ADDRINT addr, AFUNPTR funptr, ...);

extern PROTO PROTO_Allocate( PARG_T returnArg,
                                CALLINGSTD_TYPE cstype, const char * name, ... );

extern VOID PROTO_Free( PROTO proto );

#endif // PIN_G_OPIN_CLIENT_PH


