if [ "$(uname)" == 'Darwin' ]; then

    printf '\e[32m 【VirtualBox downloading ...】 \n \e[m'
    download_url=https://download.virtualbox.org/virtualbox/5.2.8/VirtualBox-5.2.8-121009-OSX.dmg
    dmg_file=${download_url##*/}
    curl -LO $download_url
    mount_dir=`hdiutil attach $dmg_file | awk -F '\t' 'END{print $NF}'`
    sudo installer -pkg $mount_dir/VirtualBox.pkg -target /
    hdiutil detach $mount_dir
    rm $dmg_file

    printf '\e[32m 【Vagrant downloading ...】 \n \e[m'
    download_url=https://releases.hashicorp.com/vagrant/2.0.3/vagrant_2.0.3_x86_64.dmg
    dmg_file=${download_url##*/}
    curl -LO $download_url
    mount_dir=`hdiutil attach $dmg_file | awk -F '\t' 'END{print $NF}'`
    sudo installer -pkg $mount_dir/Vagrant.pkg -target /
    hdiutil detach $mount_dir
    rm $dmg_file

    vagrant plugin install vagrant-vbguest
    vagrant plugin install vagrant-proxyconf

else
    echo "Your platform ($(uname -a)) is not supported."
    exit 1
fi


