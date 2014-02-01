
PRODUCT_VERSION_MAJOR = 2
PRODUCT_VERSION_MINOR = 2
PRODUCT_VERSION_MAINTENANCE = 0

JCROM_VERSION := JCROM-$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE)

# Version information used on all builds
PRODUCT_BUILD_PROP_OVERRIDES += BUILD_VERSION_TAGS=release-keys USER=android-build BUILD_UTC_DATE=$(shell LANG=en date +"%s")

DATE = $(shell vendor/aokp/tools/getdate)
JCDATE = $(shell LANG=en date +%Y%m%d)
AOKP_BRANCH=kitkat

ifneq ($(AOKP_BUILD),)
    # AOKP_BUILD=<goo version int>/<build string>
    PRODUCT_PROPERTY_OVERRIDES += \
        ro.goo.developerid=aokp \
        ro.goo.rom=aokp \
        ro.goo.version=$(shell echo $(AOKP_BUILD) | cut -d/ -f1) \
        ro.aokp.orig.version=$(TARGET_PRODUCT)_$(AOKP_BRANCH)_$(shell echo $(AOKP_BUILD) | cut -d/ -f2)
else
    ifneq ($(AOKP_NIGHTLY),)
        # AOKP_NIGHTLY=true
        PRODUCT_PROPERTY_OVERRIDES += \
            ro.aokp.orig.version=$(TARGET_PRODUCT)_$(AOKP_BRANCH)_nightly_$(DATE)
    else
        PRODUCT_PROPERTY_OVERRIDES += \
            ro.aokp.orig.version=$(TARGET_PRODUCT)_$(AOKP_BRANCH)_unofficial_$(DATE)
    endif
endif

# needed for statistics
PRODUCT_PROPERTY_OVERRIDES += \
        ro.aokp.branch=$(AOKP_BRANCH) \
        ro.aokp.device=$(AOKP_PRODUCT)

PRODUCT_PROPERTY_OVERRIDES += \
    ro.aokp.version=$(JCROM_VERSION)

PRODUCT_PROPERTY_OVERRIDES += \
    ro.aokp.otapackage=$(JCROM_VERSION)-$(TARGET_PRODUCT)_$(AOKP_BRANCH)

# Camera shutter sound property
PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.camera-sound=1
