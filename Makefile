PWD			:= $(shell pwd)
NO_ERROR	:= 2> /dev/null

.PHONY: all
all: install zshrc 

.PHONY: install
install:
	@ln -s $(PWD)/file_rc/ ~/.file_rc/
	@cp -v $(PWD)/.gitconfig ~/
	@cp -vr $(PWD)/ssh ~/.ssh

.PHONY zshrc
zshrc:
	@mv ~/.zshrc ~/.zshrc.old $(NO_ERROR)
	@cp $(PWD)/zshrc ~/.zshrc

