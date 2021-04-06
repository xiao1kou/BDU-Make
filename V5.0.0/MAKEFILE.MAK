#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#   (C) All rights reserved by UAES, China & Robert Bosch GmbH, Germany
#
#+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#
#   Filename      : MAKEFILE.MAK
#
#   Version       : 1.0.0
#
#   Company       : UAES, China & Robert Bosch GmbH, Germany
#
#   Department    : UAES/XE/ESW
#
#   Author(s)     : Yuan Tao
#
#   Last Updated  : 04.06.2021
#
#   Functionality : entry makefile of general ECU SW build
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

define MSG_STARTUP
    echo #+---------------------------------------------------------------+
    echo #
    echo #          MAKE $(PLATFORM), Version $(MAKEVERSION), started:
    echo #          $(shell date /t) at  $(shell time /t)
    echo #
    echo #          Programmname      - $(PLATFORM)
    echo #          Username          - $(USERNAME)
    echo #          Current directory - $(CUR_DIR)
    echo #
    echo #+---------------------------------------------------------------+	
endef
define MSG_FINISH
    $(DEBUG)echo @echo off > $(TEMPEXEC)
	$(DEBUG)echo start /wait $(CUR_DIR)\Mak\Tools\MakeGen\FindSwVersion.exe >> $(TEMPEXEC)
	$(DEBUG)$(TEMPEXEC)
	$(DEBUG)$(RM) -f $(TEMPEXEC)
    echo #
    echo #+---------------------------------------------------------------+
    echo #
    echo #          MAKE $(PLATFORM), Version $(MAKEVERSION), correct finished:
    echo #          $(shell date /t) at  $(shell time /t)
    echo #
    echo #+---------------------------------------------------------------+
endef

#---------------------------------------------------------------------------------------------
#
#   SPECIAL BUILT-IN TARGETS
#
#---------------------------------------------------------------------------------------------

.PHONY : rebuild build clean rebuildqac \
         doit_rebuild doit_build doit_final               \
         doit_cleanup doit_rebuildqac startup_info finish_info


#---------------------------------------------------------------------------------------------
#
#   MAIN TARGETS
#
#---------------------------------------------------------------------------------------------
#   ATTENTION : NO INCLUDE before this rules !!!
#
#   No recursion allowed for main targets.
#---------------------------------------------------------------------------------------------

ifeq ($(MAKELEVEL),0)   ### BEGIN of runlevel '0'

  rebuild   : startup_info   \
              doit_rebuild   \
              finish_info

  build     : startup_info   \
              doit_build     \
              finish_info

  clean  :    startup_info   \
              doit_clean   \
              finish_info

  rebuildqac: startup_info   \
              doit_rebuildqac \
              finish_info


#---------------------------------------------------------------------------------------------
#
#   TARGETS : doit_rebuild , doit_build, doit_partcore, doit_partdamos,doit_partbuild,
#             doit_final, doit_cb, doit_ctprot, doit_absolute_elf, doit_cleanup
#
#---------------------------------------------------------------------------------------------
#   The first command of this targets retrieves the maketype ('rebuild', 'build', 'partcore',
#   'partdamos', 'partbuild', 'final', 'cb' or 'ctprot') by generation of an option file.
#   This option file contains the macro MAKEOPTION and is the first file included in the
#   INCLUDE SECTION. The second command of this targets starts the "real" makefile with the
#   corresponding target in TARGET.MAK.
#
#   The targets are used at runlevel 0 only.
#---------------------------------------------------------------------------------------------

  doit_rebuild   :
	$(DEBUG)echo MAKEOPTION:=rebuild>$(OPTION_FILE)
	$(SHOW)$(MAKE) -f MAKEFILE.MAK rebuild_all

  doit_build     :
	$(DEBUG)echo MAKEOPTION:=build>$(OPTION_FILE)
	$(SHOW) $(IGNORE_FILE_CONTENT)
	$(SHOW)$(MAKE) -f MAKEFILE.MAK build_all

  doit_clean   :
	$(DEBUG)echo MAKEOPTION:=clean>$(OPTION_FILE)
	$(SHOW)$(MAKE) -f MAKEFILE.MAK cleanup

  doit_rebuildqac   :
	$(DEBUG)echo MAKEOPTION:=rebuildqac>$(OPTION_FILE)
	$(SHOW)$(MAKE) -f MAKEFILE.MAK rebuild_qac

endif   ### END of runlevel '0'



#---------------------------------------------------------------------------------------------
#
#   TARGET : finish_info
#
#---------------------------------------------------------------------------------------------
finish_info :
	@$(MSG_FINISH)
	
#---------------------------------------------------------------------------------------------
#
#   TARGET : startup_info
#
#---------------------------------------------------------------------------------------------
startup_info :
	@$(MSG_STARTUP)





#---------------------------------------------------------------------------------------------
#
#   INCLUDE SECTION
#
#---------------------------------------------------------------------------------------------
CUR_DIR      := $(strip $(subst /,\,$(CURDIR)))

MAKEOPTION   := $(MAKECMDGOALS)
OPTION_FILE  := mak_makefile.opt

# Include after runlevel '0' ?
ifneq ($(MAKELEVEL),0)
  include $(OPTION_FILE)
endif

CONFIG_MAKE  := $(CUR_DIR)\CONFIG.MAK

include $(CONFIG_MAKE)

# HOME_DIR is defined in CONFIG.MAK and is the location of the home of SWB
SWB_HOME_DIR            := $(MAK_DIR)\v$(MAKEVERSION)

TARGET_SPEC_CONFIG_MAKE := $(SWB_HOME_DIR)\$(MCU_TYPE)_$(TOOLCHAIN)_config.MAK
EVALMAKE                := $(SWB_HOME_DIR)\EVALMAKE.MAK
TOOL_MAKE               := $(SWB_HOME_DIR)\TOOL_CHECK.MAK
TARGET_COMMON_MAKE      := $(SWB_HOME_DIR)\TARGET_COMMON.MAK

include $(TARGET_SPEC_CONFIG_MAKE)
include $(EVALMAKE)
include $(TOOL_MAKE)
include $(TARGET_COMMON_MAKE)


