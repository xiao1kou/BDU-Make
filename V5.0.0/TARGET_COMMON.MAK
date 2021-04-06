#---------------------------------------------------------------------------------------------
#
#   M E S S A G E   D E F I N I T I O N S
#
#---------------------------------------------------------------------------------------------
define MSG_REMOVE_MAKE_DIRS
  echo #----------------------------------------------
  echo #-----                                    -----
  echo #-----     Remove make output folders     -----
  echo #-----                                    -----
  echo #----------------------------------------------
endef

define MSG_REMOVE_MAKE_GEN_FILES
  echo #----------------------------------------------
  echo #-----                                    -----
  echo #-----     Remove make generated files    -----
  echo #-----                                    -----
  echo #----------------------------------------------
endef

define MSG_CREATE_MAKE_DIRS
  echo #----------------------------------------------
  echo #-----                                    -----
  echo #-----  Create makeout and delivery path  -----
  echo #-----                                    -----
  echo #----------------------------------------------
endef

define MSG_COPY_HEADER_FILES
  echo #----------------------------------------------
  echo #-----                                    -----
  echo #----- Copy header files to common folder -----
  echo #-----                                    -----
  echo #----------------------------------------------
endef

define MSG_PREPARE_COMPILATION_FILE
  echo #----------------------------------------------
  echo #-----       Prepare generated file       -----
  echo #-----                                    -----
  echo #-----           for compilation          -----
  echo #----------------------------------------------
endef

define MSG_PREPARE_PRECOMPILATION_FILE
  echo #----------------------------------------------
  echo #-----       Prepare generated file       -----
  echo #-----                                    -----
  echo #-----        for Pre-compilation         -----
  echo #----------------------------------------------
endef

define MSG_START_COMPILATION
  echo #----------------------------------------------
  echo #-----                                    -----
  echo #-----        Start compilation           -----
  echo #-----                                    -----
  echo #----------------------------------------------
endef

define MSG_CONTINUE_COMPILATION
  echo #----------------------------------------------
  echo #-----                                    -----
  echo #-----      Continue compilation          -----
  echo #-----                                    -----
  echo #----------------------------------------------
endef

define MSG_GENERATE_CORE_LIB
  echo #----------------------------------------------
  echo #-----                                    -----
  echo #-----      Generate CORE library         -----
  echo #-----                                    -----
  echo #----------------------------------------------
endef

define MSG_GENERATE_DAMOS_FILES
  echo #----------------------------------------------
  echo #-----       Generate DAMOS related       -----
  echo #-----                                    -----
  echo #-----          D, H and C files          -----
  echo #----------------------------------------------
endef

define MSG_GENERATE_DEPENDENCY
  echo #----------------------------------------------
  echo #-----                                    -----
  echo #----- Generate source files dependencies -----
  echo #-----                                    -----
  echo #----------------------------------------------
endef

define MSG_LINK_RELOCATABLE_ELF_FILE
  echo #----------------------------------------------
  echo #-----            Use linker to           -----
  echo #-----                                    -----
  echo #-----   generate relocatable ELF file    -----
  echo #----------------------------------------------
endef

define MSG_GENERATE_ABSOLUTE_LINKER_COMMAND_FILE
  echo #----------------------------------------------
  echo #-----     Generate absolute locate       -----
  echo #-----                                    -----
  echo #-----       linker command file          -----
  echo #----------------------------------------------
endef

define MSG_GENERATE_RELOVATABLE_LINKER_COMMAND_FILE
  echo #----------------------------------------------
  echo #-----       Generate relocatable         -----
  echo #-----                                    -----
  echo #-----       linker command file          -----
  echo #----------------------------------------------
endef

define MSG_LINK_ABSOLUTE_ELF_FILE
  echo #----------------------------------------------
  echo #-----       Use linker to generate       -----
  echo #-----                                    -----
  echo #----- absolute located ELF file          -----
  echo #----------------------------------------------
endef

define MSG_CREATE_LINKER_HEX
  echo #----------------------------------------------
  echo #-----      Create linker hex file        -----
  echo #----------------------------------------------
endef

define MSG_CREATE_PROGRAM_HEX
  echo #----------------------------------------------
  echo #-----     Create program hex file        -----
  echo #----------------------------------------------
endef

define MSG_PERFORM_RESOURCE_ANALYSIS
  echo #----------------------------------------------
  echo #-----     Perform resource analysis      -----
  echo #----------------------------------------------
endef

define MSG_GENERATE_QAC_ENVIRONMENT
  echo #----------------------------------------------
  echo #-----       Generate QAC environment     -----
  echo #-----                                    -----
  echo #-----            related files           -----
  echo #----------------------------------------------
endef

define MSG_CREATE_QAC_DIRS
  echo #----------------------------------------------
  echo #-----    Create QAC output folder        -----
  echo #----------------------------------------------
endef

define MSG_CLEAN_QAC_DIRS
  echo #----------------------------------------------
  echo #-----     Clean QAC output folder        -----
  echo #----------------------------------------------
endef

define MSG_GENERATE_QAC_MESSAGE_CONF
  echo #----------------------------------------------
  echo #-----   Generate QAC message conf file   -----
  echo #----------------------------------------------
endef

define MSG_GENERATE_QAC_ANALYSER_CONF
  echo #----------------------------------------------
  echo #-----   Generate QAC analyser conf file  -----
  echo #----------------------------------------------
endef

define MSG_GENERATE_QAC_COMPILER_CONF
  echo #----------------------------------------------
  echo #-----   Generate QAC compiler conf file  -----
  echo #----------------------------------------------
endef

define MSG_GENERATE_QAC_PROJECT_CONF
  echo #----------------------------------------------
  echo #-----      Generate QAC project file     -----
  echo #----------------------------------------------
endef

define MSG_RUN_UBC_GUI
  echo #----------------------------------------------
  echo #-----           Open UBC GUI             -----
  echo #----------------------------------------------
endef

define MSG_CONF_PROCESS
  echo #----------------------------------------------
  echo #-----                                    -----
  echo #-----    Perform CORE configuration      -----
  echo #-----                                    -----
  echo #----------------------------------------------
endef

define MSG_CONF_NONE
  echo None CRC
endef

#---------------------------------------------------------------------------------------------
#
#   Source file list generation, format and usage
#
#---------------------------------------------------------------------------------------------
# Execute tool and include after runlevel '0' ?
ifneq ($(MAKELEVEL),0)
  ifneq ($(MAKEOPTION),clean)
    ifneq ($(MAKELEVEL),2)
        ALL_SOURCES0 =$(shell $(FIND_EXE) -name '\*.c')
		ignore_folderCfiles0 := $(foreach dir,$(IGNORE_FOLDER),$(shell $(FIND_EXE) $(dir) -name  '\*.c'))
		ignore_folderCfiles1 := $(addprefix ./,$(ignore_folderCfiles0))
		ignore_files0 := $(addprefix ./, $(IGNORE_FILE_NAMES) )
		all_ignore_Cfiles := $(ignore_folderCfiles1) $(ignore_files0)
		ALL_SOURCES := $(filter-out $(all_ignore_Cfiles),$(ALL_SOURCES0))
		ALL_SOURCES_NODIR :=$(notdir $(ALL_SOURCES))
		LIB_FG :=
		STRONG_LINK_C_SRC_FG :=
		STRONG_LINK_ASM_SRC_FG :=
		C_SRC_FG := $(ALL_SOURCES)
		CORE_C_SRC_FG :=
		CORE_ASM_SRC_FG :=
		H_SRC_FG :=
		CORE_H_SRC_FG :=
		D_SRC_FG :=
		CORE_D_SRC_FG :=
		ALL_HFILES0 :=$(filter-out $(wildcard ./$(MAKEOUT_INCLUDE_DIR)/*),$(shell $(FIND_EXE)  -name "\*.h"))
		ignore_folderHfiles0 := $(foreach dir,$(IGNORE_FOLDER),$(shell $(FIND_EXE) $(dir) -name  '\*.h'))
		ignore_folderHfiles1 := $(addprefix ./,$(ignore_folderHfiles0))
		all_ignore_Hfiles := $(ignore_folderHfiles1) $(ignore_files0)
		ALL_HFILES := $(filter-out $(all_ignore_Hfiles),$(ALL_HFILES0))
		HFILE_TO_TAR = $(MAKEOUT_INCLUDE_DIR)/$(notdir $(1))
		ALL_TAR_HFILES := $(foreach hfile,$(ALL_HFILES),$(call HFILE_TO_TAR,$(hfile)))
		H_SRC_FG := $(HFILE_TO_TAR)
    endif
#    include $(SOURCE_FILELIST)
  endif  
endif

#####################################################################
##
## T A R G E T    S E C T I O N
##
#####################################################################
#---------------------------------------------------------------------------------------------
#
#   C O M M O N   T E M P L A T E   M A C R O S
#
#---------------------------------------------------------------------------------------------

# The template macro writes the delivered string $(1)
# to the delivered file (2) by using the "echo" command.
# Note : One blank line (preceeding or suceeding) is necessary for a proper
#        interworking with the calling $(foreach ...) make function.
#        A preceeding  a n d  suceeding blank line will increase
#        memory consumption of makefiles due to a problem in make tool.
define CommonWriteToFile

  @echo $(1) >> $(2)
endef
TARGET_SPEC_BUILD_MAKE    := $(SWB_HOME_DIR)\$(MCU_TYPE)_$(TOOLCHAIN).MAK
include $(TARGET_SPEC_BUILD_MAKE)

## +-----------------------------------------------------------------
## |
## |      Targets: Main targets
## |
## +-----------------------------------------------------------------
build_all :       cleandelivery  CreateOutDir all_targets

rebuild_all :     cleanup CreateOutDir all_targets

rebuild_qac :     cleanqac qac_targets

runqac :          OpenQacProject


## +-----------------------------------------------------------------
## |      Target:  all_targets:
## +-----------------------------------------------------------------
##all_targets :
##	$(SHOW)$(MAKE) -f MAKEFILE.MAK make_targets


all_targets :      BatchBeforeMake
	@$(MSG_COPY_HEADER_FILES)
	$(DEBUG)$(MAKE) $(JOBS_OPT) --no-print-directory -f MAKEFILE.MAK BuckupHeadFile
	@$(MSG_START_COMPILATION)
	$(DEBUG)$(MAKE) $(JOBS_OPT) --no-print-directory -f MAKEFILE.MAK $(LINKER_HEXFILE)
	$(DEBUG)$(MAKE) $(JOBS_OPT) --no-print-directory -f MAKEFILE.MAK $(PROGRAM_HEXFILE)
	$(DEBUG)$(MAKE) $(JOBS_OPT) --no-print-directory -f MAKEFILE.MAK $(RESOURCE_ANALYSIS) 
	@$(BatchAfterMake)


               
#                   $(LINKER_HEXFILE)  \
#                   $(LINKER_OUTPUT) \
#                   $(PROGRAM_HEXFILE) \
#                   $(RESOURCE_ANALYSIS) \

#---------------------------------------------------------------------------------------------
#
#   Targets backup all of h files
#
#---------------------------------------------------------------------------------------------

define CopyFile
$(2) : $(1)
	$(DEBUG)$(COPY) $$< $$@
	@$(PRINTF) "."

endef

ALL_H_SRC               := $(sort $(strip $(H_SRC_FG) $(D_SRC_FG) $(CORE_H_SRC_FG) $(CORE_D_SRC_FG)))
ALL_H_FILE_IN_MAKEOUT   := $(addprefix $(MAKEOUT_INCLUDE_REL_DIR)\,$(notdir $(ALL_H_SRC)))

$(foreach HFile, $(ALL_H_SRC), $(eval $(call CopyFile, $(HFile), $(MAKEOUT_INCLUDE_REL_DIR)\$(notdir $(HFile)))))

BuckupHeadFileMsg:   FORCE
	@$(MSG_COPY_HEADER_FILES)

.PHONY: BuckupHeadFile
BuckupHeadFile:     $(ALL_H_FILE_IN_MAKEOUT)
	@$(PRINTF) "\n"


#---------------------------------------------------------------------------------------------
#   Creates the make directories.
#---------------------------------------------------------------------------------------------
define CreateDir
$(1):
	$(MKDIR) -p $(subst \,/,$(subst $(PST_DIR)\,,$$@))

endef

define CreatePath
	@$(PRINTF) .
	$(shell md $(1))
endef

$(foreach dir, $(CREATE_DIRS), $(eval $(call CreateDir,$(dir))))


CreateOutDirMsg: 
	@$(MSG_CREATE_MAKE_DIRS)

.PHONY: CreateOutDir
CreateOutDir : $(CreateOutDirMsg) \
               $(CREATE_DIRS)


.PHONY: CreateQacDir
CreateQacDir : FORCE 
	@$(MSG_CREATE_QAC_DIRS)
	$(foreach dir, $(QAC_OUTPUT_DIRS), $(call CreatePath,$(dir)))
	@$(PRINTF) "\n"


## +-----------------------------------------------------------------
## |
## |      Target:  clean
## |
## +-----------------------------------------------------------------
define DeleteFilesOfDir
	$(RM) -f $(subst \,/,$(subst $(PST_DIR)\,,$(1)))/*.*

endef

.PHONY: cleanup
cleanup :FORCE
	@$(MSG_REMOVE_MAKE_DIRS)
	$(foreach dir, $(DELETE_DIRS), $(call DeleteFilesOfDir,$(dir)))
	$(RM) -rf $(MAKEOUT_QAC_REL_DIR)
	$(RM) -rf $(MAKEOUT_UBC_REL_DIR)


.PHONY: cleanqac
cleanqac :FORCE
	@$(MSG_CLEAN_QAC_DIRS)
	$(RM) -rf $(MAKEOUT_QAC_REL_DIR)


.PHONY: cleandelivery
cleandelivery :FORCE
	@$(MSG_REMOVE_MAKE_GEN_FILES)
	$(foreach dir, $(DELIVERY_REL_DIR), $(call DeleteFilesOfDir,$(dir)))
	$(RM) -f $(MAKEOUT_REL_PATH)/*.csv
	$(RM) -f $(MAKEOUT_REL_PATH)/*.dep
	$(RM) -f $(MAKEOUT_REL_PATH)/*.dla
	$(RM) -f $(MAKEOUT_REL_PATH)/*.dle
	$(RM) -f $(MAKEOUT_REL_PATH)/*.dnm
	$(RM) -f $(MAKEOUT_REL_PATH)/*.elf
	$(RM) -f $(MAKEOUT_REL_PATH)/*.hex
	$(RM) -f $(MAKEOUT_REL_PATH)/*.map
	$(RM) -f $(MAKEOUT_REL_PATH)/*.run

## +-----------------------------------------------------------------
## |
## |      Target:  BatchBeforeMake BatchAfterMake
## |
## +-----------------------------------------------------------------
.PHONY: BatchBeforeMake
BatchBeforeMake:
	$(subst \\,\\\,$(strip $(USER_PRE_PROCESS)))


define BatchAfterMake
	$(subst \\,\\\,$(strip $(USER_POST_PROCESS)))
endef

#---------------------------------------------------------------------------------------------
#
#   Targets c -> o, s -> o expansion
#
#---------------------------------------------------------------------------------------------
#
# Each target rule make file should implement rule packages: CompileCSources, CompileCoreAsmSources, CompileCoreCSources, CompileStrongLinkCSources, CompileStrongLinkAsmSources
#

C_SRCDIRS := $(sort $(C_SRCS))
$(foreach srcpath, $(C_SRCDIRS), $(eval $(call CompileCSources,$(srcpath),$(basename $(notdir $(srcpath))))))

CORE_ASM_SRCDIRS := $(sort $(CORE_ASM_SRCS))
$(foreach srcpath, $(CORE_ASM_SRCDIRS), $(eval $(call CompileCoreAsmSources,$(srcpath),$(basename $(notdir $(srcpath))))))

CORE_C_SRCDIRS := $(sort $(CORE_C_SRCS))
$(foreach srcpath, $(CORE_C_SRCDIRS), $(eval $(call CompileCoreSources,$(srcpath),$(basename $(notdir $(srcpath))))))

STRONG_LINK_C_SRCDIRS := $(sort $(STRONG_LINK_C_SRCS))
$(foreach srcpath, $(STRONG_LINK_C_SRCDIRS), $(eval $(call CompileStrongLinkCSources,$(srcpath),$(basename $(notdir $(srcpath))))))

STRONG_LINK_ASM_SRCDIRS := $(sort $(STRONG_LINK_ASM_SRCS))
$(foreach srcpath, $(STRONG_LINK_ASM_SRCDIRS), $(eval $(call CompileStrongLinkAsmSources,$(srcpath),$(basename $(notdir $(srcpath))))))




## +-----------------------------------------------------------------
## |
## |      Target:  The static analyser for C code, QAC project  
## |
## +-----------------------------------------------------------------

.PHONY: OpenQacProject
OpenQacProject : FORCE	
	$(DEBUG)echo @echo off > $(TEMPEXEC)
	$(DEBUG)echo if exist C:\Users\$(USERNAME)\AppData\Local\PRQA\PRQA-Framework-2.3.0\app\qa-framework-app.xml ( >> $(TEMPEXEC)
	$(DEBUG)echo 	for /f "tokens=* delims= " %%%%i in ('findstr "5055" C:\Users\$(USERNAME)\AppData\Local\PRQA\PRQA-Framework-2.3.0\app\qa-framework-app.xml') do (  >> $(TEMPEXEC)
	$(DEBUG)echo 		echo License Has Been Configured >> $(TEMPEXEC)
	$(DEBUG)echo 		start $(QAC_PRQA_GUI) >> $(TEMPEXEC)
	$(DEBUG)echo 		echo OPEN THE PROJECT FROM $(MAKEOUT_QAC_DIR)\prqaproject.xml >> $(TEMPEXEC)
	$(DEBUG)echo 		echo QAC is running... >> $(TEMPEXEC)
	$(DEBUG)echo 		pause >> $(TEMPEXEC)
	$(DEBUG)echo 		exit >> $(TEMPEXEC)
	$(DEBUG)echo 	) >> $(TEMPEXEC)
	$(DEBUG)echo ) >> $(TEMPEXEC)	
	$(DEBUG)echo echo "License Has NOT Been Configured!  Now Start Configuring..." >> $(TEMPEXEC)
	$(DEBUG)echo start /wait $(QAC_PRQA_CLI) admin --set-license-server 5055@174.34.53.47 >> $(TEMPEXEC) 
	$(DEBUG)echo echo License Configured Successfully >> $(TEMPEXEC)
	$(DEBUG)echo start /wait $(QAC_PRQA_GUI) >> $(TEMPEXEC)
	$(DEBUG)echo echo Open The Project From $(MAKEOUT_QAC_DIR)\prqaproject.xml  >> $(TEMPEXEC)
	$(DEBUG)echo echo QAC is running...>> $(TEMPEXEC)
	$(DEBUG)echo pause >> $(TEMPEXEC)
	$(DEBUG)echo exit >> $(TEMPEXEC)
	$(DEBUG)$(TEMPEXEC)
	$(DEBUG)$(RM) -f $(TEMPEXEC)


.PHONY: qac_targets
qac_targets : generate_qac_environment_info \
              CreateQacDir                  \
              QAC_PRJ_CREATE


.PHONY: generate_qac_environment_info
generate_qac_environment_info : FORCE
	@$(MSG_GENERATE_QAC_ENVIRONMENT)

.PHONY: QAC_PRJ_CREATE
QAC_PRJ_CREATE : FORCE
	@$(MSG_GENERATE_QAC_PROJECT_CONF)
	$(shell md $(MAKEOUT_QAC_REL_DIR)\include)
	$(shell $(QAC_PRQA_CLI) admin --qaf-project-config --qaf-project $(MAKEOUT_QAC_REL_DIR) --cct $(QAC_PRQA_CONF)\GHS_MULTI_ccppc_201514_SPC572L64_C.cct --acf $(QAC_PRQA_CONF)\project.acf --rcf $(QAC_PRQA_CONF)\project.rcf)
	$(PYTHON) $(QAC_PY_FILE) $(PST_DIR)

MACRO_LABELS_STRIP   = $(strip $(subst .H",.H>,$(subst .h",.h>,$(subst =",=<,$(MACRO_LABELS)))))

#---------------------------------------------------------------------------------------------
#
#   FORCE : DUMMY TARGET
#
#---------------------------------------------------------------------------------------------

FORCE :


################################################################################
#   dependency file for C sources - generated after D-file generation, included on next make run
define IncludeFile
  -include $(1)
endef

# Include dependency list (from previous run)
tmp:=$(foreach file, $(DEP_FILES), $(eval $(call IncludeFile, $(file))))

#-------------------------------------------------------------------------------

