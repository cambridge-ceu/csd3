# This Makefile is a shim for users with muscle memory for the "make" command.
# It's not intended for production usage or anything important.

# Default target to pull, clean, configure, build, and install
all: pull configure build install

# Pull the latest changes from the repository
pull:
	@echo "Loading modules and pulling latest code..."
	@if command -v module > /dev/null 2>&1; then \
		. /etc/profile.d/modules.sh; \
		module purge; \
		module load rhel8/default-icl; \
		module load python/3.8.11/gcc/pqdmnzmw; \
	else \
		echo "Module system not available. Skipping module commands."; \
	fi
	git pull

# Configure the build environment
configure:
	@echo "Running configuration with prefix: $(CEUADMIN)/firefox/nightly"
	@# Ensure CEUADMIN is set or use a default value
	$(if $(CEUADMIN),,$(error "CEUADMIN environment variable not set"))
	./mach configure --prefix=$(CEUADMIN)/firefox/nightly

# Build the project
build:
	@echo "Building the project..."
	./mach build

# Install the project
install:
	@echo "Installing the project..."
	./mach install

# Clean the build
clean:
	@echo "Cleaning the build..."
	./mach clobber

# Mark targets that don't represent files
.PHONY: all pull configure build install clean
