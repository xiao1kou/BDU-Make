:: *<BASDKey>
:: ***********************************************************************************************************************
:: *
:: * COPYRIGHT RESERVED, United Automotive Electronic Systems Co.,Ltd, 2016. All rights reserved.
:: * The reproduction, distribution and utilization of this document as well as the communication of its contents to
:: * others without explicit authorization is prohibited. Offenders will be held liable for the payment of damages.
:: * All rights reserved in the event of the grant of a patent, utility model or design.
:: *
:: ***********************************************************************************************************************
:: * Template Information
:: *  V1.0   05.05.2016  SongYH
:: *  Created for UAES-TC Non-AutoSAR base software development.
:: ***********************************************************************************************************************
:: * Administrative Information 
:: * $Domain____:BASD$
:: * $Namespace_:\ut_MakUtil\Rebuild_start$
:: * $Class_____:BAT$
:: * $Name______:Rebuild_start$
:: * $Variant___:U1.0.0$
:: * $Revision__:0$
:: ***********************************************************************************************************************
::</BASDKey>



@echo off



echo #-----------------------------------------------------------------------
echo #-----                                                   ---------------
echo #-----      Buid process start                           
echo #-----   start at %time% on %date%                       
echo #-----                                                   ---------------
echo ##----------------------------------------------------------------------

.\MAK\MakUtil\rm.exe -rf _bin
.\MAK\MakUtil\rm.exe -rf _gen
.\MAK\MakUtil\rm.exe -rf _log
set hightec-rt_LICENSE=it00s451@5053;174.34.50.76@5054

set hightec-rt_LICENSE

.\MAK\MakUtil\make.exe  -j8 -f .\MAK\MakGen\Makefile shell=cmd



echo #-----------------------------------------------------------------------
echo #-----                                                             -----
echo #-----      Buid process end                                       
echo #-----   end at %time% on %date%                                   
echo #-----                                                             -----
echo ##----------------------------------------------------------------------

:: *<BASDKey>
:: ***********************************************************************************************************************
:: * $History___:
:: * 
:: * U1.0.0; 0     22.11.2018 UAES/TC/ESW2 Ma Guocheng
:: *   File first created.
:: *
:: * $
:: ***********************************************************************************************************************
::</BASDKey>