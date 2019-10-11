import requests
# find and save the current Github release
html = str(
           requests.get('https://github.com/restic/restic/releases/latest')
           .content)
index = html.find('Release ')
print(str(html))
github_version = html[index + 8:index + 15]
file = open('github_version.txt', 'w')
file.writelines(github_version)
file.close()

# find and save the current Docker version on FTP server
html = str(
             requests.get(
                        'https://oplab9.parqtec.unicamp.br/pub/test/marcelo/restic/latest'
                        ).content)
index = html.rfind('version-')
ftp_version = html[index + 8:index + 15]
file = open('ftp_version.txt', 'w')
file.writelines(ftp_version)
file.close()

# find and save the oldest Bazel version on FTP server
index = html.find('version-')
delete = html[index + 8:index + 15]
file = open('delete_version.txt', 'w')
file.writelines(delete)
file.close()

# find and save the oldest Bazel version on FTP server
index = html.find('ddddw')
file = open('create_dir.txt', 'w')
file.writelines(str(index))
file.close()