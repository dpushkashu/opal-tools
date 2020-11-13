@call "#OPAL_TOOLS_USER_ENV_SCRIPT#"

@REM Notes for shell scripting:
@REM - if * is specified without characters around it (* vs. LOG* or *LOG) it needs to be put in quotes for the shell: "*"
@REM - if using multiline commands, the ^ character MUST be the LAST character on the line, else you will get errors

@call opal-export.cmd --output-dir "%OPAL_TOOLS_SRC_SQL_DIR%" ^
    --dependent-objects table:comment,index,object_grant view:comment,object_grant,trigger "materialized view:comment,index,materialized_view_log,object_grant" ^
    --pre-scripts "%OPAL_TOOLS_HOME_DIR%/export-scripts/opal-export-pre-script.sql" ^
    --post-scripts "%OPAL_TOOLS_HOME_DIR%/export-scripts/opal-export-post-script.sql" ^
    --skip-errors ^
    --excludes SYS_* AQ$* ^
    --exclude-types LOB "TABLE_PARTITION" "INDEX PARTITION" "JAVA CLASS" JAVA "JAVA RESOURCE" INDEX ^
    --filename-templates default:#schema#/#object_type_plural#/#object_name#.sql package:#schema#/packages/#object_name#.pks "package body:#schema#/packages/#object_name#.pkb" ^
    --connection-pool-name #SCHEMA# ^
    --connection-pool-file "%OPAL_TOOLS_USER_CONFIG_DIR%\connections-#ENV#.json" ^
    --export-template-dir "%OPAL_TOOLS_HOME_DIR%\export-templates"

start explorer "%OPAL_TOOLS_SRC_SQL_DIR%\#SCHEMA#"
cd /d "%OPAL_TOOLS_SRC_SQL_DIR%\#SCHEMA#"

cmd /k
