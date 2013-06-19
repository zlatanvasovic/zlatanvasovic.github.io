CSS ?= ./assets/css/zd.css
LESS ?= ./assets/less/zd.less
CHECK=\033[32m✔ Done\033[39m
HR=\033[37m--------------------------------------------------\033[39m

#
# LESS COMPILE
#

build:
	@printf "\nCompiling and minifying LESS..."
	@recess --compile ${LESS} > ${CSS}
	@echo "             ${CHECK}"
	@echo "${HR}"
	@echo "\033[36mCompile is complete!\n\033[39m"
	@echo "\033[37m<3 @ZDroid\n\033[39m"
