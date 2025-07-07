# Makefile for building Rust staticlib and packaging as xcframework

LIB_NAME=markdown_bridge
LIB_FILENAME=lib$(LIB_NAME).a
BUILD_DIR=target
XCFRAMEWORK_DIR=$(LIB_NAME).xcframework

TARGET_AARCH64_APPLE_DARWIN=aarch64-apple-darwin
TARGET_AARCH64_APPLE_IOS=aarch64-apple-ios
TARGET_AARCH64_APPLE_IOS_MACABI=aarch64-apple-ios-macabi
TARGET_AARCH64_APPLE_IOS_SIM=aarch64-apple-ios-sim
TARGET_X86_64_APPLE_DARWIN=x86_64-apple-darwin
TARGET_X86_64_APPLE_IOS=x86_64-apple-ios
TARGET_X86_64_APPLE_IOS_MACABI=x86_64-apple-ios-macabi

ALL_TARGETS=\
	$(TARGET_AARCH64_APPLE_DARWIN) \
	$(TARGET_AARCH64_APPLE_IOS) \
	$(TARGET_AARCH64_APPLE_IOS_MACABI) \
	$(TARGET_AARCH64_APPLE_IOS_SIM) \
	$(TARGET_X86_64_APPLE_DARWIN) \
	$(TARGET_X86_64_APPLE_IOS) \
	$(TARGET_X86_64_APPLE_IOS_MACABI)

all: install-targets clean build-xcframework

install-targets:
	@for t in $(ALL_TARGETS); do \
		rustup target add $$t; \
	done

clean:
	rm -rf $(BUILD_DIR)/universal-ios-sim $(BUILD_DIR)/universal-mac $(BUILD_DIR)/universal-ios-macabi $(XCFRAMEWORK_DIR)

# Build rules for all targets
define BUILD_TARGET_template
build-$(1):
	cargo build --release --target $(1)
endef

$(foreach t,$(ALL_TARGETS),$(eval $(call BUILD_TARGET_template,$t)))

# lipo rules for universal binaries (simulators/mac)
lipo-ios-sim:
	mkdir -p $(BUILD_DIR)/universal-ios-sim; \
	rm -f $(BUILD_DIR)/universal-ios-sim/$(LIB_FILENAME); \
	lipo -create \
		$(BUILD_DIR)/$(TARGET_AARCH64_APPLE_IOS_SIM)/release/$(LIB_FILENAME) \
		$(BUILD_DIR)/$(TARGET_X86_64_APPLE_IOS)/release/$(LIB_FILENAME) \
		-output $(BUILD_DIR)/universal-ios-sim/$(LIB_FILENAME)

lipo-mac:
	mkdir -p $(BUILD_DIR)/universal-mac; \
	rm -f $(BUILD_DIR)/universal-mac/$(LIB_FILENAME); \
	lipo -create \
		$(BUILD_DIR)/$(TARGET_AARCH64_APPLE_DARWIN)/release/$(LIB_FILENAME) \
		$(BUILD_DIR)/$(TARGET_X86_64_APPLE_DARWIN)/release/$(LIB_FILENAME) \
		-output $(BUILD_DIR)/universal-mac/$(LIB_FILENAME)

lipo-ios-macabi:
	mkdir -p $(BUILD_DIR)/universal-ios-macabi; \
	rm -f $(BUILD_DIR)/universal-ios-macabi/$(LIB_FILENAME); \
	lipo -create \
		$(BUILD_DIR)/$(TARGET_AARCH64_APPLE_IOS_MACABI)/release/$(LIB_FILENAME) \
		$(BUILD_DIR)/$(TARGET_X86_64_APPLE_IOS_MACABI)/release/$(LIB_FILENAME) \
		-output $(BUILD_DIR)/universal-ios-macabi/$(LIB_FILENAME)

build-xcframework: $(foreach t,$(ALL_TARGETS),build-$(t)) lipo-ios-sim lipo-mac lipo-ios-macabi
	if [ ! -d ./include ] || [ -z "$(wildcard ./include/*.h)" ]; then \
		echo "Error: ./include directory missing or no header files found."; \
		exit 1; \
	fi; \
	rm -rf $(XCFRAMEWORK_DIR); \
	xcodebuild -create-xcframework \
		-library $(BUILD_DIR)/$(TARGET_AARCH64_APPLE_IOS)/release/$(LIB_FILENAME) -headers ./include \
		-library $(BUILD_DIR)/universal-ios-sim/$(LIB_FILENAME) -headers ./include \
		-library $(BUILD_DIR)/universal-mac/$(LIB_FILENAME) -headers ./include \
		-library $(BUILD_DIR)/universal-ios-macabi/$(LIB_FILENAME) -headers ./include \
		-output $(XCFRAMEWORK_DIR)
