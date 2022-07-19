#!/bin/zsh

echo "Installing SDKMAN! and basic Java dependencies"
# Install SDKMAN!
curl -s "https://get.sdkman.io?rcupdate=false" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh" || sdk version || echo "Try running \"source \
\"$HOME/.sdkman/bin/sdkman-init.sh\"\""
# Install JDKs
yes | sdk install java 8.0.332-tem || true
yes | sdk install java 11.0.15-tem || true
yes | sdk install java 18.0.1-tem || true
sdk default java 11.0.15-tem || true
# jdks can be found at: ~/.sdkman/candidates/java
# Install maven and gradle
yes | sdk install maven || true
sdk default maven || true
# maven can be found at: ~/.sdkman/candidates/maven
yes | sdk install gradle || true
sdk default gradle || true
# gradle can be found at: ~/.sdkman/candidates/gradle
