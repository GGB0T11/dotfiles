#!/usr/bin/env bash

set -e  # Exit on error

# INITIAL SETTINGS
MODE="$1"  # 'full' or 'incremental'
LABEL="backupBTRFS"
SNAPSHOT_NAME="snap_$(date +%Y-%m-%d_%H-%M-%S)"
SNAPSHOT_NAME_BASE="${SNAPSHOT_NAME}_base"
SNAPSHOT_DIR="/.snapshots"
DEST_MOUNTPOINT="/media/backup"
DEST_DIR="$DEST_MOUNTPOINT/system_snapshot"

# AUXILIARIES FUNCTIONS
erro() {
  echo "[ERROR] $1" >&2
  exit 1
}

log() {
  echo "[INFO] $1"
}

# PARAMETERS VALIDATION
if [[ "$MODE" != "full" && "$MODE" != "incremental" ]]; then
  erro "Usage: $0 [full|incremental]"
fi

# CREATING SNAPSHOTS DIRECTORY
if [[ ! -d "$SNAPSHOT_DIR" || -z $(sudo btrfs subvolume show "$SNAPSHOT_DIR" 2>/dev/null) ]]; then
  log "Creating subvolume snapshots in $SNAPSHOT_DIR..."
  sudo btrfs subvolume create "$SNAPSHOT_DIR"
fi

# CREATE READ-ONLY ACTUAL SNAPSHOT
log "Creating snapshot: $SNAPSHOT_NAME..."
sudo btrfs subvolume snapshot -r / "$SNAPSHOT_DIR/$SNAPSHOT_NAME"

# MOUNTING EXTERNAL DEVICE
if ! findmnt | grep -q "$DEST_MOUNTPOINT"; then
  log "Mounting external device..."
  sudo mkdir -p "$DEST_MOUNTPOINT"
  sudo mount LABEL="$LABEL" "$DEST_MOUNTPOINT" || erro "Failed to mount external device."
fi

# ENSURE BACKUPS SUBVOLUME AT DESTINATION
if [[ ! -d "$DEST_DIR" || -z $(sudo btrfs subvolume show "$DEST_DIR" 2>/dev/null) ]]; then
  log "Creating subvolume at: $DEST_DIR..."
  sudo btrfs subvolume create "$DEST_DIR"
fi

# SENDING SNAPSHOT
cd "$SNAPSHOT_DIR"

if [[ "$MODE" == "full" ]]; then
  log "Making ful backup to $DEST_DIR..."
  sudo btrfs send "$SNAPSHOT_NAME" | sudo btrfs receive "$DEST_DIR"

  log "Defining $SNAPSHOT_NAME with snapshot base..."
  sudo btrfs subvolume snapshot -r "$SNAPSHOT_DIR/$SNAPSHOT_NAME" "$SNAPSHOT_DIR/$SNAPSHOT_NAME_BASE"

elif [[ "$MODE" == "incremental" ]]; then
  BASE_SNAPSHOT=$(sudo btrfs subvolume list "$DEST_DIR" | awk '{print $NF}' | grep "_base$" | sort | tail -n1)

  if [[ -z "$BASE_SNAPSHOT" ]]; then
    log "Snapshot base not find. Making full backup and defining with base."
    sudo btrfs send "$SNAPSHOT_NAME" | sudo btrfs receive "$DEST_DIR"
    sudo btrfs subvolume snapshot -r "$SNAPSHOT_DIR/$SNAPSHOT_NAME" "$SNAPSHOT_DIR/$SNAPSHOT_NAME_BASE"
  else
    log "Incremental backup based on: $BASE_SNAPSHOT"
    sudo btrfs send -p "$DEST_DIR/$BASE_SNAPSHOT" "$SNAPSHOT_NAME" | sudo btrfs receive "$DEST_DIR"
  fi
fi

log "Backup $MODE completed successfully: $SNAPSHOT_NAME"

