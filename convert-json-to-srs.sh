# ANSI color codes
ORANGE='\033[0;33m'
NC='\033[0m' # No Color

# Function to print in orange
print_orange() {
    printf "${ORANGE}%s${NC}\n" "$1"
}

# Check if sing-box command exists
if ! command -v sing-box > /dev/null 2>&1
then
    print_orange "sing-box command not found. Please ensure it's installed and added to PATH."
    exit 1
fi

# Loop through all .json files in the current directory
for json_file in *.json
do
    # Check if file exists (to prevent *.json from not matching any files)
    if [ -f "$json_file" ]; then
        # Construct output .srs filename
        srs_file=$(echo "$json_file" | sed 's/\.json$/.srs/')
        
        print_orange "Converting $json_file to $srs_file..."
        
        # Use sing-box command for conversion
        if sing-box rule-set compile --output "$srs_file" "$json_file"; then
            print_orange "Successfully converted $json_file to $srs_file"
        else
            print_orange "Failed to convert $json_file"
        fi
    fi
done

print_orange "All conversion operations completed."
