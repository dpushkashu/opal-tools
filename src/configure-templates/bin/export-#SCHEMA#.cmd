@call #OPAL_TOOLS_USER_ENV_SCRIPT#

@REM Notes for shell scripting:
@REM - if * is specified without characters around it (* vs. LOG* or *LOG) it needs to be put in quotes for the shell: "*"
@REM - if using multiline commands, the ^ character MUST be the LAST character on the line, else you will get errors

@call opal-export.cmd --output-dir "%OPAL_TOOLS_SRC_SQL_DIR%" ^
    --dependent-objects table:comment,index,object_grant,trigger view:comment,object_grant "materialized view:comment,index,materialized_view_log,object_grant" ^
    --pre-script "%OPAL_TOOLS_HOME_DIR%/conf/opal-export-pre-script.sql" ^
    --post-script "%OPAL_TOOLS_HOME_DIR%/conf/opal-export-post-script.sql" ^
    --skip-errors ^
    --include "*" ^
    --exclude SYS_* AQ$* ^
    --extension-map package:pks "package body:pkb" ^
    --directory-map "package body:packages" ^
    --connection-pool-name #SCHEMA# ^
    --connection-pool-file "%OPAL_TOOLS_USER_CONFIG_DIR%\connections-#ENV#.json"

start explorer "%OPAL_TOOLS_SRC_SQL_DIR%\#SCHEMA#"
cd /d "%OPAL_TOOLS_SRC_SQL_DIR%\#SCHEMA#"

cmd /k
