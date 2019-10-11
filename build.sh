github_version=$(cat github_version.txt)
ftp_version=$(cat ftp_version.txt)
status=$(curl -s --head -w %{http_code} https://oplab9.parqtec.unicamp.br/pub/test/marcelo/restic/latest-$github_versions -o /dev/null)

if [  $status == 404 ] 
then
    echo "CLONING"
    git clone https://github.com/restic/restic/
    cd restic
    
    echo "BUILDING"
    - go build ./cmd/restic
    
    echo "RESTIC VERSION"
    - ./restic version
    
    echo "TESTING"
    - go test ./...
    
    echo "MOVING BINARY"
    lftp -c "open -u $USER,$PASS ftp://oplab9.parqtec.unicamp.br; put -O /test/marcelo/restic/latest restic-$github_version"
    lftp -c "open -u $USER,$PASS ftp://oplab9.parqtec.unicamp.br; rm /test/marcelo/restic/latest restic-$ftp_version" 
fi