#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#   (C) All rights reserved by UAES, China & Robert Bosch GmbH, Germany
#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#   Filename      : tricore_ghs.MAK
#
#   Version       : 1.0.0
#
#   Company       : UAES, China & Robert Bosch GmbH, Germany
#
#   Department    : UAES/XE/ESW
#
#   Author(s)     :    Yuan Tao
#
#   Last Updated  : 04.06.2021
#
#   Functionality : configuration for TriCore ECU using GHS tool chain SW build
#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#   History:
#
#   Version   Date         Author   Description
#   ------------------------------------------------------------------------------------------
#   1.0.0   04.06.2021      Yuan Tao
#              N: New file for Tricore Build.
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#---------------------------------------------------------------------------------------------
#
#   Specific tools definitions for using ghs compiler
#
#---------------------------------------------------------------------------------------------
LINKER_OUTPUT_SUFFIX   := elf
AR                     := $(COMPSUITE_DIR)\ax.exe
CC                     := $(COMPSUITE_DIR)\cctri.exe
LD                     := $(COMPSUITE_DIR)\exlr.exe
NM                     := $(COMPSUITE_DIR)\gnm.exe
STRIP                  := $(COMPSUITE_DIR)\gstrip.exe
HEX                    := $(COMPSUITE_DIR)\gsrec.exe


LINKER_HEX_OPTS         = -L \
                          -hex386 \
                          -pad$(strip $(PAD_VALUE_SIZE)) \
                          $(strip $(HEX_FILL_STARTADDR)) \
                          $(strip $(HEX_FILL_ENDADDR)) \
                          $(strip $(PAD_VALUE))
						  
COMPSUITE_DIR                          :=$(strip $(COMPSUITE_DIR))
MACRO_LABELS                           :=$(strip $(MACRO_LABELS))
START_OBJ_FILENAME                     :=$(strip $(START_OBJ_FILENAME))
ENTRY_SYMBOL                           :=$(strip $(ENTRY_SYMBOL))


#===================== CONFIG CHECK =========================================
ifeq ($(MAKELEVEL),0)
ifeq ($(START_OBJ_FILENAME), $(empty))
  ifeq ($(ENTRY_SYMBOL), $(empty))
      $(warning MAKEFILE Warning : No Value assigned for both START_OBJ_FILENAME and ENTRY_SYMBOL)
      $(warning ===================================================)
      $(warning ***START_OBJ_FILENAME is crt0.o and ENTRY_SYMBOL is _start by default, which may cause unexpected linking result!)
  endif
endif
endif

START_OBJ_FILE            := $(addprefix $(CORE_OUTPUT_REL_DIR)\, $(START_OBJ_FILENAME))

ifneq ($(START_OBJ_FILE), $(empty))
  ifeq ($(START_OBJ_FILE), no)
    START_FILES_OPT            :=-nostartfiles
  else
    START_FILES_OPT            :=-startfiles=$(START_OBJ_FILE)
  endif
else
    START_FILES_OPT            :=
endif

ifneq ($(ENTRY_SYMBOL), $(empty))
  ifeq ($(ENTRY_SYMBOL), no)
    ENTRY_SYMBOL_OPT            :=-noentry
  else
    ENTRY_SYMBOL_OPT            :=-entry=$(ENTRY_SYMBOL)
  endif
else
    ENTRY_SYMBOL_OPT              :=
endif


TARGET_SPEC_INC_DIRS  := $(COMPSUITE_DIR)\ansi \
                         $(COMPSUITE_DIR)\src\libsys
                         
TARGET_SPEC_CC_DEFINES := $(addprefix -D,$(MACRO_LABELS))

TARGET_SPEC_FIXED_LIBS :=

INC_OPTS             = $(addprefix -I,$(INC_DIRS))
INC_DIRS_CORE        = $(INC_DIRS)
INC_OPTS_CORE        = $(addprefix -I,$(INC_DIRS_CORE))
INC_DIRS_INV         = $(INC_DIRS)
INC_OPTS_INV         = $(addprefix -I,$(INC_DIRS_INV))

CC_OPTS_ASM          := $(CC_OPTS) -preprocess_assembly_files
CC_OPTS_C            := $(CC_OPTS)

E_CC_OPTS_C          := $(strip $(INC_OPTS) $(CC_DEFINES) $(CC_OPTS_C))
E_CC_OPTS_ASM        := $(strip $(INC_OPTS) $(CC_DEFINES) $(CC_OPTS_ASM))


#---------------------------------------------------------------------------------------------
#
#   Specific rules definitions for v850e using ghs compiler
#
#---------------------------------------------------------------------------------------------

define CompileCoreAsmSources
$(CORE_OUTPUT_REL_DIR)\$(2).o : $(1)
	$(CC) $(E_CC_OPTS_ASM) $$< -o $$@

endef

define CompileCoreSources
$(CORE_OUTPUT_REL_DIR)\$(2).o : $(1)
	$(CC) $(E_CC_OPTS_C) $$< -o $$@

endef

define CompileStrongLinkAsmSources
$(OBJ_REL_DIR)\$(2).o : $(1)
	$(CC) $(E_CC_OPTS_ASM) $$< -o $$@

endef

define CompileStrongLinkCSources
$(OBJ_REL_DIR)\$(2).o : $(1)
	$(CC) $(E_CC_OPTS_C) $$< -o $$@

endef

define CompileCSources
$(OBJ_REL_DIR)\$(2).o : $(1)
	$(CC) $(E_CC_OPTS_C) $$< -o $$@
endef


# Default filename of relocatable and absolute linker invocation file

LINKER_INV_REL_NAME        := group_$(MCU_TYPE)_$(TOOLCHAIN).ld
LINKER_INV_ABS_NAME        := locate_$(MCU_TYPE)_$(TOOLCHAIN).ld
LINKER_INV_REL_FILE        := $(strip $(LINKER_INV_REL_FILE))
LINKER_INV_ABS_FILE        := $(strip $(LINKER_INV_ABS_FILE))

ifndef LINKER_INV_REL_FILE 
LINKER_INV_REL_FILE        := $(SWB_HOME_DIR)\$(LINKER_INV_REL_NAME)
endif

ifndef LINKER_INV_ABS_FILE
LINKER_INV_ABS_FILE        := $(SWB_HOME_DIR)\$(LINKER_INV_ABS_NAME)
endif


# Name and location of preprocessed relocatable and absolute linker invocation file
ifneq ($(LINKER_INV_REL_FILE),$(empty))
LINKER_INV_REL_PREPRC      := $(MAKEOUT_REL_DIR)\group_sections.ld
endif

ifneq ($(LINKER_INV_ABS_FILE),$(empty))
LINKER_INV_ABS_PREPRC      := $(MAKEOUT_REL_DIR)\memlay_confout.ld
endif

ifneq ($(PED_CHKSUM_SCRIPT),$(empty))
PED_CHKSUM_SCRIPT_PREPRC      := $(MAKEOUT_REL_DIR)\ped_chksum_confout.dcm
endif

#
#CC option files
#
CC_OPTS_C_FILE               :=$(MAKEOUT_REL_DIR)\$(MCU_TYPE)_$(TOOLCHAIN).inc
CC_OPTS_ASM_FILE             :=$(MAKEOUT_REL_DIR)\$(MCU_TYPE)_$(TOOLCHAIN).ina
CC_OPTS_LINK_FILE            :=$(MAKEOUT_REL_DIR)\$(MCU_TYPE)_$(TOOLCHAIN).inl
CC_OPTS_CPP_FILE             :=$(MAKEOUT_REL_DIR)\$(MCU_TYPE)_$(TOOLCHAIN).inp


# MAP files
MAPFILES                    := $(MAKEOUT_REL_DIR)\$(PROGRAMNAME).map
RESOURCE_ANALYSER           := $(RESOURCE_ANALYSER_DIR)\mapFileResourceAnalysis.py
RESOURCE_ANALYSIS_CONFIG    := $(PST_REL_DIR)\BswLib\Make\SesourceAnalyse_SegmentInf.rac
MAP_SYMBOL_SORT             := num
#---------------------------------------------------------------------------------------------
#
#   TARGET : prepare_cc_opts_files
#
#---------------------------------------------------------------------------------------------
.PHONY: prepare_cc_opts_files
prepare_cc_opts_files: FORCE
	@$(MSG_PREPARE_COMPILATION_FILE)
	$(SHOW)$(PRINTF) "" > $(CC_OPTS_LINK_FILE)
  ifeq ($(NO_LIB_GEN), yes)
	$(foreach obj, $(CORE_C_OBJS),      $(call CommonWriteToFile,$(strip $(obj)),$(CC_OPTS_LINK_FILE)))
	$(foreach obj, $(CORE_ASM_OBJS),  $(call CommonWriteToFile,$(strip $(obj)),$(CC_OPTS_LINK_FILE)))
  endif
	$(foreach obj, $(C_OBJS),$(call CommonWriteToFile,$(strip $(obj)),$(CC_OPTS_LINK_FILE)))
	$(foreach obj, $(STRONG_LINK_C_OBJS),$(call CommonWriteToFile,$(strip $(obj)),$(CC_OPTS_LINK_FILE)))
	$(foreach obj, $(STRONG_LINK_ASM_OBJS),$(call CommonWriteToFile,$(strip $(obj)),$(CC_OPTS_LINK_FILE)))
	$(foreach obj, $(OBJ_OBJS),  $(call CommonWriteToFile,$(strip $(obj)),$(CC_OPTS_LINK_FILE)))
	$(foreach lib, $(LINKLIBS),  $(call CommonWriteToFile,$(strip $(lib)),$(CC_OPTS_LINK_FILE)))
	$(shell $(RM) -f $(CC_OPTS_CPP_FILE))
	$(shell $(PRINTF) "*cpp: \n+" >> $(CC_OPTS_CPP_FILE))
	$(shell $(PRINTF) "     \\\n-I-" >> $(CC_OPTS_CPP_FILE))
	$(foreach src,$(subst \,\\\\, $(INC_OPTS_INV) $(CC_DEFINES)), $(shell $(PRINTF) "      \\\n$(src)" >> $(CC_OPTS_CPP_FILE)))
	$(shell $(PRINTF) "\n" >> $(CC_OPTS_CPP_FILE))
	@$(MSG_START_COMPILATION)


$(CC_OPTS_LINK_FILE) :
	@$(MSG_PREPARE_COMPILATION_FILE)
	$(SHOW)$(PRINTF) "" > $(CC_OPTS_LINK_FILE)
  ifeq ($(NO_LIB_GEN), yes)
	$(foreach obj, $(CORE_C_OBJS),      $(call CommonWriteToFile,$(strip $(obj)),$(CC_OPTS_LINK_FILE)))
	$(foreach obj, $(CORE_ASM_OBJS),  $(call CommonWriteToFile,$(strip $(obj)),$(CC_OPTS_LINK_FILE)))
  endif
	$(foreach obj, $(C_OBJS),$(call CommonWriteToFile,$(strip $(obj)),$(CC_OPTS_LINK_FILE)))
	$(foreach obj, $(STRONG_LINK_C_OBJS),$(call CommonWriteToFile,$(strip $(obj)),$(CC_OPTS_LINK_FILE)))
	$(foreach obj, $(STRONG_LINK_ASM_OBJS),$(call CommonWriteToFile,$(strip $(obj)),$(CC_OPTS_LINK_FILE)))
	$(foreach obj, $(OBJ_OBJS),  $(call CommonWriteToFile,$(strip $(obj)),$(CC_OPTS_LINK_FILE)))
	$(foreach lib, $(LINKLIBS),  $(call CommonWriteToFile,$(strip $(lib)),$(CC_OPTS_LINK_FILE)))
    
    
$(CC_OPTS_CPP_FILE) :
	@$(MSG_PREPARE_PRECOMPILATION_FILE)
	$(shell $(RM) -f $(CC_OPTS_CPP_FILE))
	$(shell $(PRINTF) "*cpp: \n+" >> $(CC_OPTS_CPP_FILE))
	$(shell $(PRINTF) "     \\\n-I-" >> $(CC_OPTS_CPP_FILE))
	$(foreach src,$(subst \,\\\\, $(INC_OPTS_INV) $(CC_DEFINES)), $(shell $(PRINTF) "      \\\n$(src)" >> $(CC_OPTS_CPP_FILE)))
	$(shell $(PRINTF) "\n" >> $(CC_OPTS_CPP_FILE))




.PHONY: PerformResourceAnalysis
PerformResourceAnalysis: FORCE
	@$(MSG_PERFORM_RESOURCE_ANALYSIS)
	$(PYTHON) $(RESOURCE_ANALYSER) $(RESOURCE_ANALYSIS_CONFIG) $(MAKEOUT_REL_DIR) $(MAP_SYMBOL_SORT) $(MAPFILES)
#---------------------------------------------------------------------------------------------
#
#   TARGET : $(PROGRAM_HEXFILE)
#
#---------------------------------------------------------------------------------------------
$(PROGRAM_HEXFILE): $(LINKER_HEXFILE)    \
                    $(PED_CHKSUM_SCRIPT_PREPRC)
	@$(MSG_CREATE_PROGRAM_HEX)
    # Executes generated PED script by using PED++
	$(PED)                                                          \
       -l $(PED_CHKSUM_LOG)                                         \
       -x $(PED_CHKSUM_SCRIPT_PREPRC)                               \
          $< $@ $(PROGRAMNAME)

#---------------------------------------------------------------------------------------------
#
#   TARGET : $(PROGRAM_HEXFILE)
#
#---------------------------------------------------------------------------------------------
ifeq ($(PRJ_TYPE_DEF),TSW)
$(CRC_HEXFILE): 
	@$(MSG_CONF_NONE)
$(CRC_NOBOOT_HEXFILE):
	@$(MSG_CONF_NONE)
else
    ifeq ($(PLATFORM),BCM3_5)
$(CRC_HEXFILE): $(PROGRAM_HEXFILE)
	$(HEXVIEW) -Infile $(PROGRAM_HEXFILE) /CS$(CRC_CHECKSUM):@$(CRC_ADDR);$(ASWCRC_STARTADDR)-$(ASWCRC_ENDADDR) /XI -o $(CRC_HEXFILE) /s
$(CRC_NOBOOT_HEXFILE): $(PROGRAM_HEXFILE)
	$(HEXVIEW) -Infile $(CRC_HEXFILE) /CR:$(PAD_START_ADDRESS)-$(DEL_ADDR) /XI -o $(CRC_NOBOOT_HEXFILE) /s
    else
$(CRC_HEXFILE): 
	@$(MSG_CONF_NONE)
$(CRC_NOBOOT_HEXFILE):
	@$(MSG_CONF_NONE)
    endif
endif

#---------------------------------------------------------------------------------------------
#
#   TARGET : $(PED_CHKSUM_SCRIPT_PREPRC)
#
#---------------------------------------------------------------------------------------------
#   Target for preprocessing of the ped script file for rom checksum.
#---------------------------------------------------------------------------------------------

$(PED_CHKSUM_SCRIPT_PREPRC) : $(PED_CHKSUM_SCRIPT)
	$(GCC) $(GCC_PRE_OPTS) -specs=$(CC_OPTS_CPP_FILE) -o $@ $<


#---------------------------------------------------------------------------------------------
#
#   TARGET : $(LINKER_HEXFILE)
#
#---------------------------------------------------------------------------------------------
#---------------------------------------------------------------------------------------------
#
#   TARGET : $(LINKER_OUTPUT)
#
#---------------------------------------------------------------------------------------------
#   Calls linker to retrieve absolute ELF file.
#---------------------------------------------------------------------------------------------
$(LINKER_HEXFILE)   \
$(LINKER_OUTPUT):  $(CORE_C_OBJS)            \
                   $(CORE_ASM_OBJS)          \
                   $(LINKLIBS)               \
                   $(C_OBJS)                 \
                   $(STRONG_LINK_C_OBJS)     \
                   $(STRONG_LINK_ASM_OBJS)   \
                   $(OBJ_OBJS)               \
                   $(CC_OPTS_LINK_FILE)      \
                   $(LINKER_INV_ABS_PREPRC)
	@$(MSG_LINK_ABSOLUTE_ELF_FILE)
	$(CC) $(LINKOPTS) $(START_FILES_OPT) $(ENTRY_SYMBOL_OPT) $(LINKER_INV_ABS_PREPRC) -o $(LINKER_OUTPUT)  @$(CC_OPTS_LINK_FILE)   > $(TEMPEXEC)
	@$(MSG_CREATE_LINKER_HEX)
	$(HEX) $(LINKER_HEX_OPTS) $(LINKER_OUTPUT) -o $(LINKER_HEXFILE)	
	$(DEBUG)echo $(LINKER_OUTPUT) generated successfully > $(ELF_TAG)

#---------------------------------------------------------------------------------------------
#
#   TARGET : $(LINKER_INV_ABS_PREPRC)
#
#---------------------------------------------------------------------------------------------
#   Target for preprocessing of the absolute linker invocation file.
#---------------------------------------------------------------------------------------------

$(LINKER_INV_ABS_PREPRC) :          $(LINKER_INV_ABS_FILE)  \
                                    $(CC_OPTS_CPP_FILE)
	$(GCC) $(GCC_PRE_OPTS) -specs=$(CC_OPTS_CPP_FILE) -o $@ $<


#---------------------------------------------------------------------------------------------
#
#   TARGET : $(CORE_LIB_GEN)
#
#---------------------------------------------------------------------------------------------
#   Generates the CORE library from object files specified in the CORE file lists.
#---------------------------------------------------------------------------------------------
$(CORE_LIB_GEN):     $(CORE_C_OBJS) $(CORE_ASM_OBJS)
	@$(MSG_GENERATE_CORE_LIB)
	$(SHOW)$(PRINTF) "" > $(CORE_LIB_SCRIPT_FILE)
	$(foreach obj, $(CORE_C_OBJS),     $(call CommonWriteToFile,$(obj),$(CORE_LIB_SCRIPT_FILE)))
	$(foreach obj, $(CORE_ASM_OBJS), $(call CommonWriteToFile,$(obj),$(CORE_LIB_SCRIPT_FILE)))
	$(CC) -archive -o $@ @$(CORE_LIB_SCRIPT_FILE)
	@$(MSG_CONTINUE_COMPILATION)
