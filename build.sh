  
github_version=$(cat github_version.txt)
ftp_version=$(cat ftp_version.txt)
del_version=$(cat delete_version.txt)
status=$(curl -s --head -w %{http_code} https://oplab9.parqtec.unicamp.br/pub/test/marcelo/restic/latest/restic-$github_version -o /dev/null)

addr="ftp://oplab9.parqtec.unicamp.br"
path="test/marcelo/restic/latest/"

   
if [ [$status==404] ] #talvez um ponto e virgula aqui
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
        lftp -c "open -u $USER,$PASS ftp://oplab9.parqtec.unicamp.br; rm /test/marcelo/restic/latest/restic-$ftp_version"
    fi
    lftp -c "open -u $USER,$PASS ftp://oplab9.parqtec.unicamp.br; put -O /test/marcelo/restic restic-$github_version"
    lftp -c "open -u $USER,$PASS ftp://oplab9.parqtec.unicamp.br; rm /test/marcelo/restic/restic-$del_version"

    # lftp -c "open -u $USER,$PASS $addr; cd $path; mv restic-$ftp_version ../"

    # mv restic restic-$github_version
    # lftp -c "open -u $USER,$PASS $addr; cd $path; put restic-$github_version"
fi
