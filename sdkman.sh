#!/bin/zsh

echo "Installing SDKMAN! and basic Java dependencies"
# Install SDKMAN!
curl -s "https://get.sdkman.io?rcupdate=false" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh" || sdk version || echo "Try running \"source \
\"$HOME/.sdkman/bin/sdkman-init.sh\"\""

# Resolve the latest available Temurin (-tem) identifier for a given JDK major
# version from `sdk list java`. Echoes the identifier (e.g. 21.0.7-tem) or nothing.
latest_tem() {
  local major="$1"
  sdk list java 2>/dev/null \
    | grep -oE '[0-9]+(\.[0-9]+)*-tem' \
    | grep -E "^${major}\." \
    | sort -V | tail -1
}

# Install JDKs (latest Temurin build per major), then make 25 the default.
managed_majors=(11 17 21 25)
keep_ids=()
default_jdk=""
for major in "${managed_majors[@]}"; do
  id="$(latest_tem "$major")"
  if [ -z "$id" ]; then
    echo "Could not resolve a Temurin build for JDK ${major}, skipping"
    continue
  fi
  echo "Installing JDK ${major}: ${id}"
  yes | sdk install java "$id" || true
  keep_ids+=("$id")
  [ "$major" = "25" ] && default_jdk="$id"
done
# jdks can be found at: ~/.sdkman/candidates/java
if [ -n "$default_jdk" ]; then
  sdk default java "$default_jdk" || true
fi

# Clean up superseded Temurin builds: for the majors we manage, remove any
# installed -tem version other than the one we just installed. Other vendors
# and other majors are left untouched.
for dir in "$HOME/.sdkman/candidates/java"/*(/N); do
  installed_id="${dir:t}"
  [ "$installed_id" = "current" ] && continue
  case "$installed_id" in *-tem) ;; *) continue ;; esac
  major="${installed_id%%.*}"
  (( ${managed_majors[(Ie)$major]} )) || continue          # skip unmanaged majors
  (( ${keep_ids[(Ie)$installed_id]} )) && continue         # keep current build
  echo "Removing superseded JDK: ${installed_id}"
  yes | sdk uninstall java "$installed_id" || true
done

# Install maven and gradle
yes | sdk install maven || true
sdk default maven || true
# maven can be found at: ~/.sdkman/candidates/maven
yes | sdk install gradle || true
sdk default gradle || true
# gradle can be found at: ~/.sdkman/candidates/gradle
