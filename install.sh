#!/usr/bin/env bash

# Where Ferdi/Franz may have config
BASE_DIRS=(
    "${HOME}/.config/Ferdi"
    "${HOME}/.config/Franz"
    "${HOME}/Library/Application Support/Ferdi"
    "${HOME}/Library/Application Support/Franz"
)

# Files to copy from this repo
COPY_FILES=(
    icon.svg
    icon.png
    index.js
    package.json
    webview.js
)

PLUGIN_DIR="anylist"

error() {
    echo >&2 '[Error]' "$@"
    exit 1
}

info() {
    echo "$@"
}

create_base_dir() {
    # Determine what our base directory is
    for dir in "${BASE_DIRS[@]}"; do
        if [ -d "${dir}" ]; then
            BASE_DIR="${dir}/recipes/dev/${PLUGIN_DIR}"
            return
        fi
    done
    error Cannot find Ferdi or Franz installation directory
}

main() {
    create_base_dir
    if [[ ! -d "${BASE_DIR}" ]]; then
        mkdir -p "${BASE_DIR}" || error "Could not create directory ${BASE_DIR}"
        cp "${COPY_FILES[@]}" "${BASE_DIR}" || error Copy failed to "${BASE_DIR}"
    fi

    info Installation successful - restart Ferdi/Franz

}
# Run main function
main
