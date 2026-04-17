#!/usr/bin/env bash
set -euo pipefail

# Usage: ./download_folder.sh <folder_url_or_id> [output_dir]
#
# Required environment variable:
#   GDRIVE_API_KEY  - Google Drive API key with Drive API enabled
#
# Examples:
#   GDRIVE_API_KEY=your_key ./download_folder.sh "https://drive.google.com/drive/folders/FOLDER_ID"
#   GDRIVE_API_KEY=your_key ./download_folder.sh "https://drive.google.com/drive/folders/FOLDER_ID" ~/downloads

if [[ -z "${GDRIVE_API_KEY:-}" ]]; then
    echo "Error: GDRIVE_API_KEY environment variable is not set." >&2
    echo "Usage: GDRIVE_API_KEY=your_key $0 <folder_url_or_id> [output_dir]" >&2
    exit 1
fi

if [[ $# -lt 1 ]]; then
    echo "Usage: GDRIVE_API_KEY=your_key $0 <folder_url_or_id> [output_dir]" >&2
    exit 1
fi

FOLDER_URL="$1"
OUTPUT_DIR="${2:-$(pwd)}"

python -c "
import gdown
gdown.download_folder(
    '${FOLDER_URL}',
    output='${OUTPUT_DIR}',
    api_key='${GDRIVE_API_KEY}',
    resume=True,
)
"
