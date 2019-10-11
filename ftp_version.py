import requests
# find and save the current Github release
html = str(
           requests.get('https://github.com/restic/restic/releases/latest')
           .content)
index = html.find('Release')
print(html)
print(str(index))
github_version = html[index:index+20].split()[2]
file = open('github_version.txt', 'w')
file.writelines(github_version)
file.close()

# find and save the current Docker version on FTP server
html = str(
             requests.get(
                        'https://oplab9.parqtec.unicamp.br/pub/test/marcelo/restic/latest'
                        ).content)
index = html.find('restic-')
ftp_version = html[index:index+20].split('-')[1].split('"')[0]
file = open('ftp_version.txt', 'w')
file.writelines(ftp_version)
file.close()
