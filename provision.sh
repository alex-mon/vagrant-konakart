
#!/usr/bin/env bash

YELLOW='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

SHARE_FOLDER_PATH="/vagrant_data"
KONAKART_INSTALLER_FILE_NAME="KonaKartInstaller"
KONAKART_INSTALLER_FULL_PATH=${SHARE_FOLDER_PATH}/${KONAKART_INSTALLER_FILE_NAME}
KONAKART_COMMUNITY_DOWNLOAD_URL="https://www.konakart.com/kits/9.2.0.0/KonaKart-9.2.0.0-Linux-Install-64"

echo "${SHARE_FOLDER_PATH}"
echo "${KONAKART_INSTALLER_FULL_PATH}"
echo "${KONAKART_COMMUNITY_DOWNLOAD_URL}"

echo -e "$YELLOW = = = = Starting software provisioning... = = = = $NC"
apt-get update
apt-get upgrade -y
apt-get install -y curl
apt-get install -y mysql-server
apt-get install -y openjdk-8-jre

echo -e "$YELLOW Creating database and users $NC"
mysql -e "CREATE DATABASE konakart_db;"
mysql -e "GRANT USAGE ON *.* TO 'konakart'@'%' IDENTIFIED BY 'konakart';"
mysql -e "GRANT ALL PRIVILEGES ON konakart_db.* TO 'konakart'@'%';"
if [ $? -ne 0 ]
then
  echo -e "$RED Provisioning Process Failed while creating MySql DataBase and User! $NC"
  exit -2
fi

if [ ! -f "${KONAKART_INSTALLER_FULL_PATH}" ]; then
    echo -e "$YELLOW KonaKart Installer file NOT PRESENT. Downloading community edition 9.2.0.0 from ${KONAKART_COMMUNITY_DOWNLOAD_URL} $NC"
    curl ${KONAKART_COMMUNITY_DOWNLOAD_URL} --output ${KONAKART_INSTALLER_FULL_PATH} --silent
    if [ $? -ne 0 ]
    then
      echo -e "$RED Konakart download failed, try to download it manually and place it in the shared_files folder, under the name ${KONAKART_INSTALLER_FILE_NAME} $NC"
      exit -2
    fi
fi

echo -e "$YELLOW Running KonaKart installer... $NC"
chmod +x ${KONAKART_INSTALLER_FULL_PATH}
${KONAKART_INSTALLER_FULL_PATH} -S -DLoadDB 1 -DJavaJRE "/usr/lib/jvm/java-8-openjdk-amd64/" -DDatabaseUsername konakart -DDatabasePassword konakart -DDatabaseUrl jdbc:mysql://localhost:3306/konakart_db
if [ $? -ne 0 ]
then
  echo -e "$RED KonaKart Installation Failed! $NC"
  exit -2
fi


echo -e "$YELLOW Launching KonaKart $NC"
/usr/local/konakart/bin/startkonakart.sh
echo -e "$YELLOW = = = = Provisioning Finished = = = = $NC"
