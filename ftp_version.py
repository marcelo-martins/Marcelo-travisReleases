import requests
# find and save the current Github release
html = str(
           requests.get('https://github.com/restic/restic/releases/latest')
           .content)
index = html.find('Release ')
github_version = html[index + 15:index + 20]
print("Latest: ", github_version)

file = open('github_version.txt', 'w')
file.writelines(github_version)
file.close()

# find and save the current Docker version on FTP server
html = str(
             requests.get(
                        'https://oplab9.parqtec.unicamp.br/pub/test/marcelo/restic/latest'
                        ).content)
index = html.rfind('restic-')
ftp_version = html[index + 7:index + 12]
file = open('ftp_version.txt', 'w')
file.writelines(ftp_version)
file.close()
