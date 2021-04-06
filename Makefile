include MAK\MakGen\PATHDEF.mak
include MAK\MakGen\IGNORE.mak



WORK_PATH	:= $(shell cd)
WORK_DIR	:= $(notdir $(WORK_PATH))
 
CFLAGS1 = -D__ghs__  --diag_error=12 -individual_attribute_data_sections -individual_pragma_data_sections -individual_data_sections -individual_section_name_extra_dot -gnu99 -c -language=c --no_commons -passsource --prototype_errors -Wshadow --warnings --ghstd=last -Wundef -Ospeed -Omax -ffunc -I- -Iud/Bsw/Lin/Implementation -I_gen/swb/filegroup/includes/project



CFLAGS2 =  -g -dwarf2 -cpu=tc1v162



DIR_DEPS = _gen\swb\filegroup\depends



DIR_EXES = 



DIR_OBJS = _gen\swb\filegroup\objects



DIR_PROJECTS = _gen/swb/filegroup/includes/project



DIR_BUILD = _gen\swb\module\build



DIR_LIBS = _gen\swb\filegroup\linker\libs



TARGET = test







# IGNORE_FILE = $(shell $(FIND_EXE) -name $(IGNORE_FILE_NAMES))

# Search for source files with ignore


###############
ALL_SOURCES0 =$(shell $(FIND_EXE) -name '\*.c')
# echo $(ALL_SOURCES0) > ALL_SOURCES0.txt
ignore_folderCfiles0 := $(foreach dir,$(IGNORE_FOLDER),$(shell $(FIND_EXE) $(dir) -name  '\*.c'))
ignore_folderCfiles1 := $(addprefix ./,$(ignore_folderCfiles0))

ignore_files0 := $(addprefix ./, $(IGNORE_FILE_NAMES) )

all_ignore_Cfiles := $(ignore_folderCfiles1) $(ignore_files0)

ALL_SOURCES := $(filter-out $(all_ignore_Cfiles),$(ALL_SOURCES0))
ALL_SOURCES_NODIR :=$(notdir $(ALL_SOURCES))

###########







SOURCE_TO_OBJECT = $(DIR_OBJS)/$(subst .c,.o,$(notdir $(1)))



SOURCE_TO_DEPENDENCY=$(DIR_DEPS)/$(subst .c,_depend.mak,$(notdir $(1)))



ALL_OBJECTS := $(foreach src,$(ALL_SOURCES),$(call SOURCE_TO_OBJECT,$(src)))







define CREATE_OBJECT_TARGET



$(call SOURCE_TO_OBJECT,$(1)) : $(1) $(SOURCE_TO_DEPENDENCY) | $(DIR_DEPS)



		$(CC) $(CFLAGS1) -MMD -MF $(SOURCE_TO_DEPENDENCY) $(CFLAGS2) $(CPPFLAGS) $(TARGET_ARCH) $$< -o $$@ 



endef







#Find all .h files and copy to the target path



DIR_HFILES := _gen/swb/filegroup/includes/project

# Search for h files with ignore


ALL_HFILES0 :=$(filter-out $(wildcard ./$(DIR_HFILES)/*),$(shell $(FIND_EXE)  -name "\*.h"))

ignore_folderHfiles0 := $(foreach dir,$(IGNORE_FOLDER),$(shell $(FIND_EXE) $(dir) -name  '\*.h'))
ignore_folderHfiles1 := $(addprefix ./,$(ignore_folderHfiles0))


all_ignore_Hfiles := $(ignore_folderHfiles1) $(ignore_files0)

ALL_HFILES := $(filter-out $(all_ignore_Hfiles),$(ALL_HFILES0))

HFILE_TO_TAR = $(DIR_HFILES)/$(notdir $(1))

ALL_TAR_HFILES := $(foreach hfile,$(ALL_HFILES),$(call HFILE_TO_TAR,$(hfile)))



ALL_HFILE_DIR := $(sort $(dir $(ALL_HFILES)))

define CP_HFILE
	
$(call HFILE_TO_TAR,$(1)) : $(1)

		$(CP) -fp $$^ $(DIR_HFILES)

endef



#Find all .o files and generate target .txt

ALL_OBJFILES_WITHDIR = $(shell $(FIND_EXE) -name '\*.o')

ignore_folderOfiles0 := $(foreach dir,$(IGNORE_FOLDER),$(shell $(FIND_EXE) $(dir) -name  '\*.o'))
ignore_folderOfiles1 := $(addprefix ./,$(ignore_folderOfiles0))

all_ignore_Ofiles := $(ignore_folderOfiles1) $(ignore_files0)
#all_ignore_Ofiles_lowercase := $(foreach obj, $(all_ignore_Ofiles), $(shell echo $(obj) | $(TR) A-Z a-z))

ALL_OBJECTS_WITHOUTIGNONE = $(filter-out $(all_ignore_Ofiles),$(ALL_OBJFILES_WITHDIR))
ALL_OBJFILES = $(sort $(ALL_OBJECTS_WITHOUTIGNONE))
ALL_OBJFILES_PRESORT = $(foreach obj, $(ALL_OBJFILES), $(dir $(obj))?$(notdir $(obj)))
ALL_OBJFILES_SORTED = $(shell $(CAT_EXE) $(GEN_TXT) | $(TR) -d ?)
ALL_OBJFILES_FINAL = $(subst ./,,$(ALL_OBJFILES_SORTED))

#ALL_OBJFILES_NOTDIR =$(notdir $(ALL_OBJECTS_WITHOUTIGNONE))
#ALL_OBJFILES_NOTDIR_SORTED=$(sort $(foreach obj, $(ALL_OBJFILES_NOTDIR), $(shell echo $(obj) | $(TR) A-Z a-z)))
#ALL_OBJFILES_NOTDIR :=$(shell echo $(ALL_OBJFILES_NOTDIR) | $(TR) A-Z a-z)
#ALL_OBJFILES_SORTED_WITHDIR=$(foreach obj,$(ALL_OBJFILES_NOTDIR_SORTED),$(shell echo $(shell $(FIND_EXE)  -iname $(obj)) |$(TR) A-Z a-z))
#ALL_OBJFILES=$(subst ./,,$(filter-out $(all_ignore_Ofiles_lowercase),$(ALL_OBJFILES_SORTED_WITHDIR)))

#ALL_OBJFILES := $(foreach obj, $(ALL_OBJFILES_NOTDIR),  $(shell $(FIND_EXE)  -iname $(obj)))
#ALL_OBJFILES :=$(shell echo $(ALL_OBJFILES) | $(TR) A-Z a-z)

DIR_TXT = _gen/swb/filegroup/linker/cmd/_prj_link_archive_mri.txt
GEN_TXT = _gen/swb/filegroup/linker/cmd/_prj_link_archive_mri_presort.txt







# Create archive using script



# CC_A := C:\HighTec\toolchains\tricore\v4.9.2.0\bin\tricore-ar.exe



DIR_OFILES := _gen/swb/filegroup/linker/cmd/_prj_link_archive_mri.txt







# Processing [SAIC/group.inv]

group_inv = $(shell $(FIND_EXE)  -name "group.inv")



DIR_HFILES_LCF := _gen/swb/filegroup/includes/project



DIR_DEPS_LCF := _gen/swb/filegroup/depends/rel_linker_cmd_depend.mak



TARGET_LCF := _gen/swb/module/build/rel_linker_cmd.lcf



CPPFLAGS_LCF := -D__ghs__ -E -undef -P -xc -I- -Iud/Conf/MICROSAR/GenData -I$(DIR_HFILES_LCF) 



DEPFLAGS_LCF := 







# Processing [locate.inv]

locate_inv  = $(shell $(FIND_EXE)  -name "locate.inv")

# CC_LCF := C:\HighTec\toolchains\tricore\v4.9.2.0\bin\tricore-cpp.exe



DIR_HFILES_LCF := _gen/swb/filegroup/includes/project



DIR_DEPS_LCF_TWO := _gen/swb/filegroup/depends/prj_linker_cmd_depend.mak



TARGET_LCF_TWO := _gen/swb/module/build/prj_linker_cmd.lcf 



DEPFLAGS_LCF_TWO := 







# Find all .a files and generate obj_linker_cmd.lcf

# Search for a files with ignore
ARCHIEVE_AFILE = _gen/swb/filegroup/linker/libs/_prj_link_archive.a

ALL_AFILES = $(sort $(subst ./,,$(shell $(FIND_EXE)  -name '\*.a')))

# ALL_AFILES := $(filter-out $(wildcard ./$(IGNORE_FOLDER)/*),$(ALL_AFILES))

# ALL_AFILES := $(filter-out $(IGNORE_FILE),$(ALL_AFILES))

# ALL_AFILES := $(filter-out $(ARCHIEVE_AFILE),$(ALL_AFILES))




# ALL_AFILES = $(filter-out $(ARCHIEVE_AFILE),$(filter-out $(IGNORE_FILE),$((filter-out $(wildcard ./$(IGNORE_FOLDER)/*),$((subst ./,,$(shell $(FIND_EXE)  -name '\*.a')))))))


DIR_AFILES := _gen/swb/module/build/obj_linker_cmd.lcf



#############
ALL_HEX_FILES0 := $(filter-out $(shell $(FIND_EXE) ./_gen -name '\*.hex') $(shell $(FIND_EXE) ./_bin -name '\*.hex'),$(shell $(FIND_EXE)  -name '\*.hex'))

ignore_folderHexfiles0 := $(foreach dir,$(IGNORE_FOLDER),$(shell $(FIND_EXE) $(dir) -name  '\*.hex'))
ignore_folderHexfiles1 := $(addprefix ./,$(ignore_folderHexfiles0))

# ignore_files0 := $(addprefix ./, $(IGNORE_FILE_NAMES) )

all_ignore_Hexfiles := $(ignore_folderHexfiles1) $(ignore_files0)

ALL_HEX_FILES := $(filter-out $(all_ignore_Hexfiles),$(ALL_HEX_FILES0))


###########

# Linking to get relocatable ELF file [_gen/swb/module/build/relocatable.elf] 



CFLAGS_ELF := -cpu=tc1v162



WIFLAGS_ELF = -LC:\ghs\comp_202015\lib\tri162 -lmath_sf -lmath_sd -lind_sf -lind_sd -lansi -lsys -larch -D__ghs__ -individual_attribute_data_sections -individual_pragma_data_sections -individual_data_sections -individual_section_name_extra_dot -nostdlib -nostartfiles -relobj -Ospeed -Omax -ffunc -delete -Mn -Mx -Mu -T _gen/swb/module/build/rel_linker_cmd.lcf -map=_gen/swb/module/build/relocatable.map  $(ALL_OBJFILES)



TARGET_ELF := _gen/swb/module/build/relocatable.elf







# Linking to get absolute ELF file [_bin/swb/MDGB_BasePVER.elf] 



CFLAGS_ELF_TWO := -nostdlib 



WIFLAGS_ELF_TWO := -LC:\ghs\comp_202015\lib\tri162 -lmath_sf -lmath_sd -lind_sf -lind_sd -lansi -lsys -larch -D__ghs__ -individual_attribute_data_sections -individual_pragma_data_sections -individual_data_sections -individual_section_name_extra_dot -nostdlib -nostartfiles -Ospeed -Omax -ffunc -delete -Mn -Mx -Mu -T _gen/swb/module/build/prj_linker_cmd.lcf -map=_gen/swb/module/build/MDGB_BasePVER.map



TARGET_ELF_TWO := _gen/swb/module/build/relocatable.elf -o _bin/swb/$(WORK_DIR).elf







# Create HEX file [_gen/swb/module/build/MDGB_BasePVER_linker.hex]







OBJFLAGS := -start 0x80000198 -hex386 -noSLA -skip .ram -skip .sbRam -skip .sb_fix_ram _bin/swb/$(WORK_DIR).elf -o 



TARGET_HEX := _gen/swb/module/build/MDGB_BasePVER_linker.hex



# HexModX: Generate final HEX file and cleaned checksum HEX file [_bin/swb/MDGB_BasePVER.hex, _bin/swb/filegroup/results/MDGB_BasePVER_cleaned_chksum.hex]

# Step1: copy template\filelist_gen_merged_exp.txt to _gen\swb\module\coreproc\filelist_gen_merged_exp.txt

merged_corecfg_export_xml := $(shell $(FIND_EXE)  -name "merged_corecfg_export.xml")

merged_corecfg_export_xml_target_dir := _gen\swb\module\coreproc

TEMPLATE_SRC_ONE := MAK/template/filelist_gen_merged_exp.txt

TEMPLATE_TAR_ONE := _gen/swb/module/coreproc/filelist_gen_merged_exp.txt

TEMPLATE_SRC_TWO := MAK/template/hexmod

TEMPLATE_TAR_TWO := _gen/swb/module/hexmod

HEXMOD_TARGET := _gen/swb/module/build/MDGB_BasePVER_linker.hex

HEXMOD_TARGET_NEW := $(TEMPLATE_TAR_TWO)/MDGB_BasePVER_linker.hex

HEXMOD_TARGET_NEW_NAME := $(TEMPLATE_TAR_TWO)/MDGB_BasePVER_src.hex

HEXMOD_TMP := _gen/swb/module/hexmod/MDGB_BasePVER_tmp.hex

HEXMOD_TMP_TAR := _bin/swb

FINAL_HEX := _bin/swb/$(WORK_DIR).hex



HEXMOD_OPTS := --set-start 0x0000 -R .ram -R .sbRam -R .sb_fix_ram -I elf32-tricore -O ihex _bin/swb/$(WORK_DIR).elf $(HEXMOD_TARGET)





all: create_dir hex_mod_three











#generate txt



gentxt: create_objfiles

	$(file > $(DIR_TXT),create _gen/swb/filegroup/linker/libs/_prj_link_archive.a)
	$(file >> $(DIR_TXT),addmod $(ALL_OBJFILES_FINAL))
	$(file >> $(DIR_TXT),save)
	$(file >> $(DIR_TXT),end)


create_objfiles: to_o

	$(file > $(GEN_TXT))

	$(foreach obj,$(ALL_OBJFILES_PRESORT),$(shell echo $(obj)| $(TR) A-Z a-z >> $(GEN_TXT)))

	$(SORT_EXE) -t ? -k 2 $(GEN_TXT) -o $(GEN_TXT)



genlcf: preprocessing_two



	echo GROUP ( > $(DIR_AFILES)



	echo $(ALL_AFILES) _gen/swb/filegroup/linker/libs/_prj_link_archive.a >> $(DIR_AFILES)



	$(foreach afile,$(ALL_AFILES),$(shell echo $(afile) >> $(DIR_AFILES)))
	


	echo ) >> $(DIR_AFILES)







#copy .h files



OUT_DIR  = _gen\swb\filegroup\includes\project

OUT_DIR += _gen\swb\filegroup\objects

OUT_DIR += _gen\swb\filegroup\linker\cmd

OUT_DIR += _gen\swb\filegroup\linker\libs

OUT_DIR += _gen\swb\filegroup\depends

OUT_DIR += _gen\swb\module\build

OUT_DIR += _bin\swb


create_dir:$(OUT_DIR)



$(OUT_DIR):

	-${MKDIR} -p _gen/swb/filegroup/includes/project
	-${MKDIR} -p _gen/swb/filegroup/objects
	-${MKDIR} -p _gen/swb/filegroup/linker/cmd
	-${MKDIR} -p _gen/swb/filegroup/linker/libs
	-${MKDIR} -p _gen/swb/filegroup/depends
	-${MKDIR} -p _gen/swb/module/build
	-${MKDIR} -p _gen/swb/module/coreproc
	-${MKDIR} -p _bin/swb
	-${MKDIR} -p _log/swb/module/hexmod



clean:
	-rm  -rf _bin

	-rm  -rf _gen

	-rm  -rf _log



	


to_o: $(ALL_TAR_HFILES) $(ALL_OBJECTS) 




to_a: gentxt


	echo ("omit to_a")
# $(CC_A) -M < $(DIR_OFILES)







preprocessing_one: to_a



	$(CC_LCF) $(CPPFLAGS_LCF) $(DEPFLAGS_LCF) $(group_inv) -o $(TARGET_LCF)







preprocessing_two: preprocessing_one



	$(CC_LCF) $(CPPFLAGS_LCF) $(DEPFLAGS_LCF_TWO) ${locate_inv} -o $(TARGET_LCF_TWO)






# Linking to get relocatable ELF file [_gen/swb/module/build/relocatable.elf] (1/1)
linking_one: genlcf
	$(CC) $(CFLAGS_ELF) $(WIFLAGS_ELF) -o $(TARGET_ELF)


# Linking to get absolute ELF file [_bin/swb/MDGB_BasePVER.elf] (1/1)
linking_two:linking_one
	$(CC) $(CFLAGS_ELF)  $(CFLAGS_ELF_TWO) $(WIFLAGS_ELF_TWO) $(TARGET_ELF_TWO)







hex_one:linking_two


	echo "------------- $(CC_HEX) $(OBJFLAGS) $(TARGET_HEX) ---------------"
	$(CC_HEX) $(OBJFLAGS) $(TARGET_HEX)



hex_mod_one:hex_one

	-$(CP) -fp  $(TEMPLATE_SRC_ONE) $(TEMPLATE_TAR_ONE)

	-$(CP) -fp  $(merged_corecfg_export_xml) $(merged_corecfg_export_xml_target_dir)

	-$(CP) -fp  -R  $(TEMPLATE_SRC_TWO) $(TEMPLATE_TAR_TWO)

    





hex_mod_two:hex_mod_one
	$(file > _gen\swb\module\hexmod\all_hex_files.lst)
	$(foreach hex_file,$(ALL_HEX_FILES),$(file >> _gen\swb\module\hexmod\all_hex_files.lst,$(hex_file)))

#	echo $(ALL_HEX_FILES) > _gen\swb\module\hexmod\all_hex_files.lst



hex_mod_three:hex_mod_two

	-$(CP) -fp $(HEXMOD_TARGET) $(HEXMOD_TARGET_NEW)

	-$(MV) $(HEXMOD_TARGET_NEW) $(HEXMOD_TARGET_NEW_NAME)

	$(HexmodX_cmd) --optionsfile _gen/swb/module/hexmod/opt/options_cfg_hexmod_merge.opt

	-$(CP) -fp $(HEXMOD_TMP) $(FINAL_HEX)




$(TARGET):$(ALL_OBJECTS)



	$(CC) -o $@ $^







DEPFLAGS :=  -MT $@ -MMD -MP -MF $(DIR_DEPS)/$*_depend.mak







COMPILE.c = $(CC) $(DEPFLAGS) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c -o 




DEPFILES := $(ALL_SOURCES_NODIR:%.c=$(DIR_DEPS)/%_depend.mak)



$(DEPFILES):



include $(wildcard $(DEPFILES))







$(foreach src,$(ALL_SOURCES),$(eval $(call CREATE_OBJECT_TARGET,$(src))))

$(foreach hfile,$(ALL_HFILES),$(eval $(call CP_HFILE,$(hfile))))\







debug:



	@echo $(ALL_SOURCES_NODIR)





showvar:

	@echo ""

	@echo "--(ALL_HFILES)----------all h file------------"

	@echo $(ALL_HFILES)

	@echo ""

	@echo ""

	@echo "--(ALL_OBJFILES)----------all objs file------------"

	@echo $(ALL_OBJFILES)

	@echo ""



	@echo ""

	@echo "--(ALL_SOURCES)----------all source file------------"

	@echo $(ALL_SOURCES)

	@echo ""





	@echo ""

	@echo "--(ALL_AFILES)----------all dir a/lib file------------"

	@echo $(ALL_AFILES)

	@echo ""



write_var:

	$(file > ALL_SOURCES, $(ALL_SOURCES))
	$(file > ALL_OBJFILES, $(ALL_OBJFILES))
	$(file > ignore_folderCfiles0, $(ignore_folderCfiles0))
	$(file > ignore_folderOfiles0, $(ignore_folderOfiles0))
	$(file > ALL_HEX_FILES0, $(ALL_HEX_FILES0))
	$(file > ALL_HEX_FILES, $(ALL_HEX_FILES))

.PHONY: all clean release showvar gentxt create_objfiles copyhfiles to_a preprocessing_one preprocessing_two genlcf linking_one linking_two hex_one create_dir hex_mod_one hex_mod_two hex_mod_three


print-%: ; @echo $* = $($*)	