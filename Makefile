# Dynamically get version from git tag (v1.0 -> 1.0) or fallback
VERSION = $(shell git describe --tags --abbrev=0 2>/dev/null | sed 's/^v//' || echo "0.1-dev")
PACKAGE_NAME = refind-set-default
BUILD_DIR = build_root

.PHONY: all build clean install

all: build

build: clean
	@echo "Building version $(VERSION)..."
	@mkdir -p $(BUILD_DIR)/DEBIAN
	@mkdir -p $(BUILD_DIR)/etc/kernel/postinst.d
	@mkdir -p $(BUILD_DIR)/usr/share/doc/$(PACKAGE_NAME)/examples
	
	@cp DEBIAN/control $(BUILD_DIR)/DEBIAN/
	@sed -i "s/^Version:.*/Version: $(VERSION)/" $(BUILD_DIR)/DEBIAN/control
	
	@cp DEBIAN/postinst $(BUILD_DIR)/DEBIAN/
	@cp DEBIAN/postrm $(BUILD_DIR)/DEBIAN/
	@cp scripts/zz-refind-set-default $(BUILD_DIR)/etc/kernel/postinst.d/
	@cp examples/refind.default $(BUILD_DIR)/usr/share/doc/$(PACKAGE_NAME)/examples/
	@cp README.md $(BUILD_DIR)/usr/share/doc/$(PACKAGE_NAME)/
	
	@chmod +x $(BUILD_DIR)/DEBIAN/postinst
	@chmod +x $(BUILD_DIR)/DEBIAN/postrm
	@chmod +x $(BUILD_DIR)/etc/kernel/postinst.d/zz-refind-set-default
	
	@dpkg-deb --build $(BUILD_DIR) $(PACKAGE_NAME)_$(VERSION)_all.deb

clean:
	@rm -rf $(BUILD_DIR)
	@rm -f *.deb

install:
	@sudo apt install ./$(PACKAGE_NAME)_$(VERSION)_all.deb
