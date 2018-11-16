PWD			:= $(shell pwd)
NO_ERROR	:= 2> /dev/null

.PHONY: all
all: rc_file git ssh

.PHONY:git ssh rc_file
git:
	@cp -v $(PWD)/.gitconfig ~/

ssh:
	@cp -vr $(PWD)/ssh ~/.ssh

rc_file:
	@ln -s $(PWD)/file_rc ~/.file_rc
	@if [ -f ~/.zshrc ] ; \
	then \
		mv ~/.zshrc ~/.zshrc.old $(NO_ERROR); \
	fi
	@cp $(PWD)/file_rc/zshrc ~/.zshrc
