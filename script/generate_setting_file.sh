#!/bin/bash
generate_settings_file() {
  local SERVER_ID=$1
  local SONATYPE_USERNAME=$2
  local SONATYPE_PASSWORD=$3
  local GPG_PASSPHRASE=$4

  if [ -z "$SERVER_ID" ] || [ -z "$SONATYPE_USERNAME" ] || [ -z "$SONATYPE_PASSWORD" ] || [ -z "$GPG_PASSPHRASE" ]; then
      echo "Usage: create_settings <SERVER_NAME> <SONATYPE_USERNAME> <SONATYPE_PASSWORD> <GPG_PASSPHRASE>"
      return 1
  fi

  # Define the location to create the temporary settings.xml file
  local temp_settings_file="settings.xml"

  # Read the template file and replace placeholders with the provided values
  sed -e "s/\$SERVER_ID/$SERVER_ID/g" \
      -e "s/\$SONATYPE_USERNAME/$SONATYPE_USERNAME/g" \
      -e "s/\$SONATYPE_PASSWORD/$SONATYPE_PASSWORD/g" \
      -e "s/\$GPG_PASSPHRASE/$GPG_PASSPHRASE/g" \
      Template-Setting.txt > $temp_settings_file

  echo "Temporary settings.xml file created with the provided values."

  # Create the ~/.m2 directory if it doesn't exist
  mkdir -p ~/.m2

  # Copy the generated settings.xml to ~/.m2 directory
  mv $temp_settings_file ~/.m2/settings.xml

  echo "settings.xml file copied to ~/.m2 directory."
}

# Call the function with arguments passed to the script
generate_settings_file "$@"
