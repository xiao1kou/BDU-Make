

#---------------------------------------------------------------------------------------------
#
#   PST : Specification of path and file lists of PST
#
#---------------------------------------------------------------------------------------------
# PST pathes
PST_DIR                    := $(CUR_DIR)
PST_REL_DIR                := .
PST_PATH                   := .

DELIVERY_DIR               := $(PST_DIR)\_bin
DELIVERY_REL_DIR           := $(subst $(PST_DIR)\,.\,$(DELIVERY_DIR))

MAKEOUT_DIR                := $(PST_DIR)\_gen
MAKEOUT_REL_DIR            := $(subst $(PST_DIR)\,.\,$(MAKEOUT_DIR))
MAKEOUT_REL_PATH           := $(subst \,/,$(subst $(PST_DIR)\,,$(MAKEOUT_DIR)))

CORE_OUTPUT_DIR            := $(MAKEOUT_DIR)\core
CORE_OUTPUT_REL_DIR        := $(subst $(PST_DIR)\,.\,$(CORE_OUTPUT_DIR))
CORE_OUTPUT_REL_PATH       := $(subst \,/,$(subst $(PST_DIR)\,,$(CORE_OUTPUT_DIR)))

OBJ_DIR                    := $(MAKEOUT_DIR)\objs
OBJ_REL_DIR                := $(subst $(PST_DIR)\,.\,$(OBJ_DIR))
OBJ_REL_PATH               := $(subst \,/,$(subst $(PST_DIR)\,,$(OBJ_DIR)))

LOG_DIR                    := $(MAKEOUT_DIR)\logs
LOG_REL_DIR                := $(subst $(PST_DIR)\,.\,$(LOG_DIR))
LOG_REL_PATH               := $(subst \,/,$(subst $(PST_DIR)\,,$(LOG_DIR)))

GEN_FILES_DIR              := $(MAKEOUT_DIR)\gen_files
GEN_FILES_REL_DIR          := $(subst $(PST_DIR)\,.\,$(GEN_FILES_DIR))
GEN_FILES_REL_PATH         := $(subst \,/,$(subst $(PST_DIR)\,,$(GEN_FILES_DIR)))

TEMP_DIR                   := $(MAKEOUT_DIR)\temp
TEMP_REL_DIR               := $(subst $(PST_DIR)\,.\,$(TEMP_DIR))
TEMP_REL_PATH              := $(subst \,/,$(subst $(PST_DIR)\,,$(TEMP_DIR)))

MAKEOUT_QAC_DIR            := $(MAKEOUT_DIR)\qac
MAKEOUT_QAC_REL_DIR        := $(subst $(PST_DIR)\,.\,$(MAKEOUT_QAC_DIR))
MAKEOUT_QAC_REL_PATH       := $(subst \,/,$(subst $(PST_DIR)\,,$(MAKEOUT_QAC_DIR)))

MAKEOUT_INCLUDE_DIR        := $(MAKEOUT_DIR)\include
MAKEOUT_INCLUDE_REL_DIR    := $(subst $(PST_DIR)\,.\,$(MAKEOUT_INCLUDE_DIR))
MAKEOUT_INCLUDE_REL_PATH   := $(subst \,/,$(subst $(PST_DIR)\,,$(MAKEOUT_INCLUDE_DIR)))

CREATE_DIRS                := $(MAKEOUT_REL_DIR)    \
                              $(OBJ_REL_DIR)        \
                              $(LOG_REL_DIR)        \
                              $(GEN_FILES_REL_DIR)  \
                              $(CORE_OUTPUT_REL_DIR) \
                              $(MAKEOUT_QAC_REL_DIR)\
                              $(MAKEOUT_INCLUDE_REL_DIR)\
                              $(DELIVERY_REL_DIR)

DELETE_DIRS                := $(MAKEOUT_REL_DIR)    \
                              $(OBJ_REL_DIR)        \
                              $(LOG_REL_DIR)        \
                              $(GEN_FILES_REL_DIR)  \
                              $(CORE_OUTPUT_REL_DIR) \
                              $(MAKEOUT_INCLUDE_REL_DIR)\
                              $(DELIVERY_REL_DIR)

#Macos will be used by target-specific target makefile
CC_DEFINES                  = $(TARGET_SPEC_CC_DEFINES)

#SOURCE_FILELIST            := $(PST_DIR)\FILELIST.MAK

ifndef EXECUTABLE_SUFFIX
EXECUTABLE_SUFFIX          := elf
endif

ifndef MAP_SUFFIX
MAP_SUFFIX                 := map
endif

ifndef LINKER_OUTPUT_SUFFIX
LINKER_OUTPUT_SUFFIX       := elf
endif

ifndef HEX_SUFFIX
HEX_SUFFIX                 := hex
endif

ifndef CORE_LIB_SUFFIX
CORE_LIB_SUFFIX            := a
endif

ifndef NO_LIB_GEN
NO_LIB_GEN                 :=
endif

#---------------------------------------------------------------------------------------------
#
#   Definitions of Sources
#
#---------------------------------------------------------------------------------------------
ifneq ($(NO_LIB_GEN), yes)
CORE_LIB_GEN               := $(MAKEOUT_REL_DIR)\core\libcore.$(strip $(CORE_LIB_SUFFIX))
else
CORE_LIB_GEN               :=
endif

LIB_LIBS                    = $(strip $(LIB_FG))
LINKLIBS                    = $(LIB_LIBS) $(CORE_LIB_GEN) $(TARGET_SPEC_FIXED_LIBS)

STRONG_LINK_C_SRCS          = $(strip $(STRONG_LINK_C_SRC_FG))
STRONG_LINK_ASM_SRCS        = $(strip $(STRONG_LINK_ASM_SRC_FG)) 

C_SRCS                      = $(filter-out $(STRONG_LINK_C_SRCS),$(strip $(C_SRC_FG)))
CORE_C_SRCS                 = $(filter-out $(STRONG_LINK_C_SRCS),$(strip $(CORE_C_SRC_FG)))
CORE_ASM_SRCS               = $(filter-out $(STRONG_LINK_ASM_SRCS), $(strip $(CORE_ASM_SRC_FG)))

## QAC dirs
QAC_C_SRCS                  = $(C_SRCS)                   \
                              $(CORE_C_SRCS)              \
                              $(STRONG_LINK_C_SRCS)

QAC_SRCS                    = $(sort $(QAC_C_SRCS))

QAC_OUTPUT_DIRS             = $(sort $(subst .\,$(MAKEOUT_QAC_REL_DIR)\,$(dir $(QAC_C_SRCS))))

# PED++ files
PED_CHKSUM_SCRIPT          := $(PST_REL_DIR)\BswLib\Make\ped_chksum.dcm
PED_CHKSUM_LOG             := $(LOG_REL_DIR)\ped_chksum.log

# LD file
LINKER_INV_ABS_FILE        := $(PST_REL_DIR)\BswLib\MemLay\MemLay_Linker.ld


## include dirs
## Macos will be used by target-specific target makefile
INC_DIRS                    = $(MAKEOUT_INCLUDE_REL_DIR) \
                              $(addprefix $(strip $(PST_REL_DIR))\,$(strip $(COMMON_INC_DIRS))) \
                              $(addprefix $(strip $(PST_REL_DIR))\,$(strip $(CUSTOMER_INCLUDES))) \
                              $(GEN_FILES_REL_DIR) $(TARGET_SPEC_INC_DIRS)

#---------------------------------------------------------------------------------------------
#
#   Definitions of Targets
#
#---------------------------------------------------------------------------------------------
CORE_LIB_SCRIPT_FILE       := $(CORE_OUTPUT_REL_DIR)\gen_lib_cmd.txt

EXECUTABLE                  = $(DELIVERY_REL_DIR)\$(PROGRAMNAME).$(strip $(EXECUTABLE_SUFFIX))
LINKER_OUTPUT               = $(MAKEOUT_REL_DIR)\$(PROGRAMNAME).$(strip $(LINKER_OUTPUT_SUFFIX))
LINKER_HEXFILE             := $(MAKEOUT_REL_DIR)\$(PROGRAMNAME)_linker.$(strip $(HEX_SUFFIX))
PROGRAM_HEXFILE            := $(DELIVERY_REL_DIR)\$(PROGRAMNAME).$(strip $(HEX_SUFFIX))
LINKER_DEBUGFILE            = $(MAKEOUT_REL_DIR)\$(PLATFORM).$(strip $(LINKER_OUTPUT_SUFFIX))

C_OBJS                      = $(addprefix $(OBJ_REL_DIR)\,$(addsuffix .o,$(basename $(notdir $(C_SRCS)))))
CORE_C_OBJS                 = $(addprefix $(CORE_OUTPUT_REL_DIR)\,$(addsuffix .o,$(basename $(notdir $(CORE_C_SRCS)))))
CORE_ASM_OBJS               = $(addprefix $(CORE_OUTPUT_REL_DIR)\,$(addsuffix .o,$(basename $(notdir $(CORE_ASM_SRCS)))))
STRONG_LINK_C_OBJS          = $(addprefix $(OBJ_REL_DIR)\,$(addsuffix .o,$(basename $(notdir $(STRONG_LINK_C_SRCS)))))
STRONG_LINK_ASM_OBJS        = $(addprefix $(OBJ_REL_DIR)\,$(addsuffix .o,$(basename $(notdir $(STRONG_LINK_ASM_SRCS)))))
OBJ_OBJS                    = $(strip $(OBJ_SRC_FG))

C_DEPS                      = $(addprefix $(OBJ_REL_DIR)\,$(addsuffix .d,$(basename $(notdir $(C_SRCS)))))
CORE_C_DEPS                 = $(addprefix $(CORE_OUTPUT_REL_DIR)\,$(addsuffix .d,$(basename $(notdir $(CORE_C_SRCS)))))
CORE_ASM_DEPS               = $(addprefix $(CORE_OUTPUT_REL_DIR)\,$(addsuffix .d,$(basename $(notdir $(CORE_ASM_SRCS)))))
STRONG_LINK_C_DEPS          = $(addprefix $(OBJ_REL_DIR)\,$(addsuffix .d,$(basename $(notdir $(STRONG_LINK_C_SRCS)))))
STRONG_LINK_ASM_DEPS        = $(addprefix $(OBJ_REL_DIR)\,$(addsuffix .d,$(basename $(notdir $(STRONG_LINK_ASM_SRCS)))))

DEP_FILES                   = $(C_DEPS) $(CORE_C_DEPS) $(CORE_ASM_DEPS) $(STRONG_LINK_C_DEPS) $(STRONG_LINK_ASM_DEPS)

ELF_TAG                    := $(LOG_REL_DIR)\link_elf.log

# Resource analysis
ifdef PERFORM_RESOURCE_ANALYSIS
  RESOURCE_ANALYSIS        := PerformResourceAnalysis
else
  RESOURCE_ANALYSIS        :=
endif

#
# Temp files and scripts
#
DEB_SCRIPT                 := $(strip $(MAKEOUT_REL_DIR))\startscript.dsm
DEB_BATCH                  := $(MAKEOUT_REL_DIR)\debugger.bat
DEB_START                  := $(MAKEOUT_REL_DIR)\deb.bat



# Temporary files
TEMPEXEC                   := mak_temp.bat
TEMPFILE                   := mak_temp.tmp
TEMPSED                    := mak_temp.sed
TEMPGEN                    := mak_gen.bat
TEMPLIBEXEC                := libcheck.bat


#---------------------------------------------------------------------------------------------
#
#   Set make specific macros
#
#---------------------------------------------------------------------------------------------
ifeq ($(VERBOSE),$(empty))
    SHOW                   := @
    DEBUG                  := @
    SHOW_BATCH             := rem
    SHOW_DUMP              := $(DUMP_STDOUT)
else
    SHOW_BATCH             := echo
    SHOW                   :=
    DEBUG                  :=
endif
ifneq ($(VERBOSE),debug)
    DEBUG                  := @
endif

# Macro definitions required for substition of ' ' to ','
empty                      :=
SPACE                      := $(empty) $(empty)
COMMA                      := ,
# Macro definition for usage of tab(s) inside sed
TAB                        := $(empty)	$(empty)

# Redirection of output to 'nul' device
DUMP_STDOUT                := >nul
DUMP_ERROR                 := 2>nul
DUMP_ALL                   := >nul 2>nul

ifeq ($(PARALLEL_EXECUTION),$(empty))
JOBS_OPT                   :=
else
JOBS_OPT                   := $(strip -j$(PARALLEL_EXECUTION))
endif
