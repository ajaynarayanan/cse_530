//Groups: @ingroup\s+(API_REF|KNOBS|IMG_BASIC_API|INS_BASIC_API|INS_INST_API|INS_BASIC_API_GEN_IA32|INS_BASIC_API_IA32|INS_MOD_API_GEN_IA32|SEC_BASIC_API|RTN_BASIC_API|REG_BASIC_API|REG_CPU_GENERIC|REG_CPU_IA32|TRACE_BASIC_API|BBL_BASIC_API|SYM_BASIC_API|MISC_PRINT|MISC_PARSE|KNOB_API|KNOB_BASIC|KNOB_PRINT|LOCK|PIN_CONTROL|TRACE_VERSION_API|BUFFER_API|PROTO_API|PIN_PROCESS_API|PIN_THREAD_API|PIN_SYSCALL_API|WINDOWS_SYSCALL_API_UNDOC|DEBUG_API|ERROR_FILE_BASIC|TYPE_BASE|INSTLIB|ALARM|CHILD_PROCESS_API|UTILS|MISC|CONTEXT_API|PHYSICAL_CONTEXT_API|PIN_CALLBACKS|EXCEPTION_API|APPDEBUG_API|STOPPED_THREAD_API|BUFFER_API|PROTO|INST_ARGS|DEPRECATED_PIN_API|INTERNAL_EXCEPTION_PRIVATE_UNDOCUMENTED|PIN_THREAD_PRIVATE|CHILD_PROCESS_INTERNAL|BBL_BASIC|ROGUE_BASIC_API|MESSAGE_TYPE|MESSAGE_BASIC|ERRFILE|MISC_BASIC|ITC_INST_API|CONTEXT_API_UNDOC|EXCEPTION_API_UNDOC|UNDOCUMENTED_PIN_API|OPIN|TRACE_VERSIONS

#ifdef PIN_G_DEBUGGER_CLIENT_PH
#error duplicate inclusion of debugger_client
#else
#define PIN_G_DEBUGGER_CLIENT_PH
typedef BOOL (*DEBUG_INTERPRETER_CALLBACK)(THREADID threadIndex, CONTEXT *ctxt, const std::string &cmd,
    std::string *reply, VOID *v);

typedef BOOL (*DEBUG_BREAKPOINT_CALLBACK)(ADDRINT addr, UINT size, BOOL insert, VOID *v);

/// @cond INTERNAL_DOXYGEN
typedef BOOL (*INTERCEPT_DEBUGGING_EVENT_CALLBACK)(THREADID tid, DEBUGGING_EVENT eventType,
    CONTEXT *ctxt, VOID *arg);

typedef VOID (*GET_EMULATED_REGISTER_CALLBACK)(unsigned toolRegId, THREADID tid, CONTEXT *ctxt,
    VOID *data, VOID *v);

typedef VOID (*SET_EMULATED_REGISTER_CALLBACK)(unsigned toolRegId, THREADID tid, CONTEXT *ctxt,
    const VOID *data, VOID *v);

typedef USIZE (*GET_TARGET_DESCRIPTION_CALLBACK)(const std::string &name, USIZE size, VOID *buf,
    VOID *v);

extern VOID PIN_InterceptDebuggingEvent(DEBUGGING_EVENT eventType,
    INTERCEPT_DEBUGGING_EVENT_CALLBACK fun, VOID *arg);

extern VOID PIN_AddDebuggerRegisterEmulator(unsigned numRegisters,
    const DEBUGGER_REG_DESCRIPTION *registerDescriptions,
    GET_EMULATED_REGISTER_CALLBACK getFun,
    SET_EMULATED_REGISTER_CALLBACK setFun,
    GET_TARGET_DESCRIPTION_CALLBACK getDescriptionFun,
    VOID *val);

/// @endcond
extern PIN_CALLBACK PIN_AddDebugInterpreter(DEBUG_INTERPRETER_CALLBACK fun, VOID *val);

extern VOID PIN_RemoveDebugInterpreter(DEBUG_INTERPRETER_CALLBACK fun);

extern PIN_CALLBACK PIN_AddBreakpointHandler(DEBUG_BREAKPOINT_CALLBACK fun, VOID *val);

extern VOID PIN_RemoveBreakpointHandler(DEBUG_BREAKPOINT_CALLBACK fun);

extern VOID PIN_ResetBreakpointAt(ADDRINT addr);

extern VOID PIN_ApplicationBreakpoint(const CONTEXT *ctxt, THREADID tid, BOOL waitIfNoDebugger,
    const std::string &msg);

extern BOOL PIN_SetDebugMode(const DEBUG_MODE *mode);

extern DEBUG_STATUS PIN_GetDebugStatus();

extern BOOL PIN_GetDebugConnectionInfo(DEBUG_CONNECTION_INFO *info);

extern DEBUGGER_TYPE PIN_GetDebuggerType();

extern BOOL PIN_WaitForDebuggerToConnect(unsigned timeout);

extern BOOL PIN_GetStoppedThreadPendingToolBreakpoint(THREADID tid, std::string *msg);

extern BOOL PIN_ChangePendingToolBreakpointOnStoppedThread(THREADID tid, BOOL squash,
    const std::string &msg);

#endif // PIN_G_DEBUGGER_CLIENT_PH


