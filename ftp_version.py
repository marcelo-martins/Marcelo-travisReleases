import requests as res

# find and save the current Github release
html = str(
    res.get('https://github.com/restic/restic/releases/latest')
    .content
)
i = html.find('Release')
github_version = html[i:i+20].split()[2]
file = open('github_version.txt', 'w')
file.writelines(github_version)
file.close()
print("Latest: ", github_version)

html = str(
    res.get(
    'https://oplab9.parqtec.unicamp.br/pub/test/marcelo/restic/latest'
    ).content
)
i = html.find('restic-')
ftp_version = html[i:i+20].split('-')[1].split('"')[0]
file = open('ftp_version.txt', 'w')
file.writelines(ftp_version)
file.close()
print("Current: ", ftp_version)
