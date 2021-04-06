::**********************************************************
:: please double click this batch 
:: to start CSP-MICROSAR rebuild
::**********************************************************
@Set timestring=%time:~0,8%

del .\*.log
.\MAK\MakUtil\ftee32.exe .\MAK\MakUtil\Rebuild_start.bat>rebuild_%date%-%timestring::=_%.log

@echo #+-------------------------------------------------------------+
@echo #
@echo #          Start Resource Analysis
@echo #          %date% at  %time%
@echo #          Weclome %USERNAME% to Use
@echo #+-------------------------------------------------------------+
C:\BCM_SWB\tools\python\2v6\python.exe C:\BCM_SWB\tools\ResourceAnalyse\ghs\mapFileResourceAnalysis.py .\MAK\MakGen\ResourceAnalCfg.rac .\_gen num .\_gen\swb\module\build\MDGB_BasePVER.map
@echo #+-------------------------------------------------------------+
@echo #
@echo #          Resource Analysis End
@echo #          %date% at  %time%
@echo #+-------------------------------------------------------------+

@echo #+-------------------------------------------------------------+
@echo #
@echo #          Start SwSharing Proccess
@echo #          %date% at  %time%
@echo #          Weclome %USERNAME% to Use
@echo #+-------------------------------------------------------------+
.\MAK\MakUtil\beexport.exe -i MAK\MakGen\config.ini -n MAK\MakGen\IGNORE.mak
@echo #+-------------------------------------------------------------+
@echo #
@echo #          SwSharing Proccess End
@echo #          %date% at  %time%
@echo #+-------------------------------------------------------------+
pause