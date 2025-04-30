FLOPPY_ZIP="https://github.com/ducthoe/My-Blobs/releases/download/tuff/boot.tar"
# Modifying for GlowingKernel, keeping the floppy values because fuck it
# [
REPLACE_KERNEL_BINARIES()
{
    [ -d "$TMP_DIR" ] && rm -rf "$TMP_DIR"
    mkdir -p "$TMP_DIR"

    echo "Downloading $(basename "$FLOPPY_ZIP")"
    curl -L -s -o "$TMP_DIR/floppy.tar" "$FLOPPY_ZIP"

    echo "Extracting kernel binaries"
    [ -f "$WORK_DIR/kernel/boot.img" ] && rm -rf "$WORK_DIR/kernel/boot.img"
    mkdir "$WORK_DIR/floppy"
    tar xf "$TMP_DIR/floppy.tar" -C "$WORK_DIR/floppy"
    lz4 -q -d "$WORK_DIR/floppy/boot.img.lz4" "$WORK_DIR/floppy/boot.img"
    echo "Replacing kernel binaries"
    mv "$WORK_DIR/floppy/boot.img" "$WORK_DIR/kernel/"
}
# ]

REPLACE_KERNEL_BINARIES
rm -rf "$TMP_DIR"
rm -rf "$WORK_DIR/floppy/"
