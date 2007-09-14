# Makefile to update config.
# NOTE: GNU make is required.
ID=$$Id$$#{{{1

all: update
.PHONY: all clean package _package update

SHELL=/bin/sh
# For testing `update', use like DESTDIR=./test
DESTDIR=




# Group definitions  #{{{1
ALL_GROUPS=DOTS VIM $(ALL_GROUPS_$(ENV_WORKING))
ALL_GROUPS_cygwin=CEREJA OPERA SAMURIZE

GROUP_CEREJA_FILES=\
  cereja/config.lua \
  cereja/login.lua \
  cereja/logout.lua
GROUP_CEREJA_RULE=$(patsubst %,$(HOME)/.%,$(1))

GROUP_DOTS_FILES=\
  dot.bash_profile \
  dot.bashrc \
  dot.bash.d/bash_completion \
  dot.bash.d/cdhist.sh \
  dot.bash.d/svk-completion.pl \
  dot.inputrc \
  dot.guile \
  dot.mayu \
  dot.screenrc \
  dot.Xdefaults \
  $(GROUP_DOTS_FILES_$(ENV_WORKING))
GROUP_DOTS_FILES_linux=\
  dot.xmodmaprc \
  dot.xmodmaprc-dvorak
GROUP_DOTS_RULE=$(patsubst dot.%,$(HOME)/.%,$(1))

GROUP_OPERA_FILES=\
  opera/keyboard/my-keyboard.ini \
  opera/menu/my-menu.ini \
  opera/search.ini \
  opera/skin/windows_skin3.zip \
  opera/styles/user.css \
  opera/toolbar/my-toolbar.ini
GROUP_OPERA_RULE=$(patsubst opera/%,$(GROUP_OPERA_DIR)/%,$(1))
GROUP_OPERA_DIR=$(abspath opera/profile-link)

GROUP_VIM_FILES=\
  vim/dot.vim/after/ftplugin/xml_autons.vim \
  vim/dot.vim/colors/black_angus.vim \
  vim/dot.vim/colors/gothic.vim \
  vim/dot.vim/colors/less.vim \
  $(GROUP_VIM_DOC_FILES) \
  vim/dot.vim/ftplugin/bugs.vim \
  vim/dot.vim/ftplugin/c_tofunc.vim \
  vim/dot.vim/ftplugin/issue.vim \
  vim/dot.vim/ftplugin/vim_tofunc.vim \
  vim/dot.vim/ftplugin/xml_move.vim \
  vim/dot.vim/plugin/buffuzzy.vim \
  vim/dot.vim/plugin/cygclip.vim \
  vim/dot.vim/plugin/scratch.vim \
  vim/dot.vim/plugin/surround.vim \
  vim/dot.vim/plugin/tofunc.vim \
  vim/dot.vim/plugin/vcscommand.vim \
  vim/dot.vim/plugin/vcscvs.vim \
  vim/dot.vim/plugin/vcssvk.vim \
  vim/dot.vim/plugin/vcssvn.vim \
  vim/dot.vim/syntax/bugs.vim \
  vim/dot.vim/syntax/CVSAnnotate.vim \
  vim/dot.vim/syntax/issue.vim \
  vim/dot.vim/syntax/rest.vim \
  vim/dot.vim/syntax/SVKAnnotate.vim \
  vim/dot.vim/syntax/SVNAnnotate.vim \
  vim/dot.vim/syntax/vcscommit.vim \
  vim/dot.vimrc
GROUP_VIM_RULE=$(patsubst vim/dot.%,$(HOME)/.%,$(1))
GROUP_VIM_DOC_FILES=\
  vim/dot.vim/doc/buffuzzy.txt \
  vim/dot.vim/doc/cygclip.txt \
  vim/dot.vim/doc/scratch.txt \
  vim/dot.vim/doc/surround.txt \
  vim/dot.vim/doc/tofunc.txt \
  vim/dot.vim/doc/vcscommand.txt \
  vim/dot.vim/doc/xml_autons.txt \
  vim/dot.vim/doc/xml_move.txt
GROUP_VIM_POST_TARGETS=vim-update-local-helptags
vim-update-local-helptags: $(DESTDIR)$(HOME)/.vim/doc/tags
$(DESTDIR)$(HOME)/.vim/doc/tags: $(GROUP_VIM_DOC_FILES)
	vim -n -N -u NONE -U NONE -e -c 'helptags $(dir $@) | q'

GROUP_SAMURIZE_FILES=\
  samurize/my-conf.ini
GROUP_SAMURIZE_RULE=$(patsubst samurize/%,$(GROUP_SAMURIZE_DIR)/%,$(1))
GROUP_SAMURIZE_DIR=$(abspath samurize/profile-link)




# Package definitions  #{{{1
ALL_PACKAGES=\
  all \
  cereja-all \
  opera-all \
  vim-all \
  vim-buffuzzy \
  vim-cygclip \
  vim-scratch \
  vim-tofunc \
  vim-xml_autons \
  vim-xml_move

PACKAGE_all_ARCHIVE=all
PACKAGE_all_BASE=.
PACKAGE_all_FILES=./Makefile \
                  $(foreach g, $(ALL_GROUPS), \
                    $(foreach f, $(GROUP_$(g)_FILES), \
                      ./$(f)))

PACKAGE_cereja_all_ARCHIVE=cereja-all
PACKAGE_cereja_all_BASE=cereja
PACKAGE_cereja_all_FILES=$(GROUP_CEREJA_FILES)

PACKAGE_opera_all_ARCHIVE=opera-all
PACKAGE_opera_all_BASE=opera
PACKAGE_opera_all_FILES=$(GROUP_OPERA_FILES)

PACKAGE_vim_all_ARCHIVE=vim-all
PACKAGE_vim_all_BASE=vim
PACKAGE_vim_all_FILES=$(GROUP_VIM_FILES)

PACKAGE_vim_buffuzzy_ARCHIVE=vim-buffuzzy-0.0.1
PACKAGE_vim_buffuzzy_BASE=vim/dot.vim
PACKAGE_vim_buffuzzy_FILES=\
  vim/dot.vim/doc/buffuzzy.txt \
  vim/dot.vim/plugin/buffuzzy.vim

PACKAGE_vim_cygclip_ARCHIVE=vim-cygclip-0.0
PACKAGE_vim_cygclip_BASE=vim/dot.vim
PACKAGE_vim_cygclip_FILES=\
  vim/dot.vim/doc/cygclip.txt \
  vim/dot.vim/plugin/cygclip.vim

PACKAGE_vim_scratch_ARCHIVE=vim-scratch-0.0
PACKAGE_vim_scratch_BASE=vim/dot.vim
PACKAGE_vim_scratch_FILES=\
  vim/dot.vim/doc/scratch.txt \
  vim/dot.vim/plugin/scratch.vim

PACKAGE_vim_tofunc_ARCHIVE=vim-tofunc-0.0
PACKAGE_vim_tofunc_BASE=vim/dot.vim
PACKAGE_vim_tofunc_FILES=\
  vim/dot.vim/doc/tofunc.txt \
  vim/dot.vim/ftplugin/c_tofunc.vim \
  vim/dot.vim/ftplugin/vim_tofunc.vim \
  vim/dot.vim/plugin/tofunc.vim

PACKAGE_vim_xml_autons_ARCHIVE=vim-xml_autons-0.0.1
PACKAGE_vim_xml_autons_BASE=vim/dot.vim
PACKAGE_vim_xml_autons_FILES=\
  vim/dot.vim/after/ftplugin/xml_autons.vim \
  vim/dot.vim/doc/xml_autons.txt

PACKAGE_vim_xml_move_ARCHIVE=vim-xml_move-0.0.1
PACKAGE_vim_xml_move_BASE=vim/dot.vim
PACKAGE_vim_xml_move_FILES=\
  vim/dot.vim/doc/xml_move.txt \
  vim/dot.vim/ftplugin/xml_move.vim




# package  #{{{1

PACKAGE_NAME=# Set from command line
package:
	if [ -z '$(filter $(PACKAGE_NAME),$(ALL_PACKAGES))' ]; then \
	  echo 'Error: Invalid PACKAGE_NAME "$(PACKAGE_NAME)".'; \
	  false; \
	fi
	$(MAKE) 'package=$(subst -,_,$(PACKAGE_NAME))' _package
_package:
	ln -s $(PACKAGE_$(package)_BASE) $(PACKAGE_$(package)_ARCHIVE)
	tar jcvf $(PACKAGE_$(package)_ARCHIVE).tar.bz2 \
	         $(foreach file, \
	                   $(PACKAGE_$(package)_FILES), \
	                   $(patsubst $(PACKAGE_$(package)_BASE)/%, \
	                              $(PACKAGE_$(package)_ARCHIVE)/%, \
	                              $(file)))
	rm $(PACKAGE_$(package)_ARCHIVE)




# update  #{{{1
# Rules for `update' are generated by eval.

UPDATE_DIR=mkdir -p
UPDATE_FILE=cp

RemoveCurrentDirectory=$(filter-out ./,$(1))
RemoveDuplicates=$(sort $(1))
CallRule=$(call RemoveCurrentDirectory,$(call GROUP_$(1)_RULE,$(2)))

define GenerateRulesToUpdateFile  # (src, dest)
update: $(DESTDIR)$(2)
$(DESTDIR)$(2): $(1)
	$(UPDATE_FILE) '$$<' '$$@'

endef

define GenerateRulesToUpdateDirectory  # (dest)
update: $(DESTDIR)$(1)
$(DESTDIR)$(1):
	$(UPDATE_DIR) '$$@'

endef

define GenerateRulesFromGroups  # (groups = (group_name*))
$(foreach directory, \
  $(call RemoveDuplicates, \
    $(foreach group, \
      $(1), \
      $(dir $(call CallRule,$(group),$(GROUP_$(group)_FILES))))), \
  $(call GenerateRulesToUpdateDirectory,$(directory)))
$(foreach group, \
  $(1), \
  $(foreach file, \
    $(GROUP_$(group)_FILES), \
    $(call GenerateRulesToUpdateFile,$(file),$(call CallRule,$(group),$(file)))))
update .PHONY: $(foreach group,$(1),$(GROUP_$(group)_POST_TARGETS))
endef

$(eval $(call GenerateRulesFromGroups,$(ALL_GROUPS)))




# clean  #{{{1

clean:
	rm -rf `find -name '*~' -or -name ',*'`




# __END__
# vim: foldmethod=marker
