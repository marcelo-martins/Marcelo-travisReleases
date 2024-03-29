github_version=$(cat github_version.txt)
ftp_version=$(cat ftp_version.txt)
status=$(curl -s --head -w %{http_code} https://oplab9.parqtec.unicamp.br/pub/test/marcelo/restic/latest/restic-$github_version -o /dev/null)
 
if [$status -eq "404"]
then
    echo "CLONING"
    git clone https://github.com/restic/restic/
    cd restic
    
    echo "BUILDING"
    go run build.go -T
    mv restic restic-$github_version
    
    echo "MOVING BINARY"

    if [[ $github_version > $ftp_version ]]
    then
        lftp -c "open -u $USER,$PASS ftp://oplab9.parqtec.unicamp.br; put -O /test/marcelo/restic/latest restic-$github_version"
    fi
    lftp -c "open -u $USER,$PASS ftp://oplab9.parqtec.unicamp.br; put -O /test/marcelo/restic restic-$github_version"
fi
