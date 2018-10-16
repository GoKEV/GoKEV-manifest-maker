[![GoKEV](http://GoKEV.com/GoKEV200.png)](http://GoKEV.com/)

<div style="position: absolute; top: 40px; left: 200px;">

# GoKEV-manifest-maker

This project is an Ansible role to deploy to a local ESXi server or VCenter.
  - This role assumes you're feeding credentials through an Ansible Tower credential type
  - This role saves the newly provisioned VM to a temporary inventory name defined in the `defaults/main.yml`
  - localhost.target (inventory)


## Example Playbooks
Here's an example of how you could launch this role


<pre>---
- name: Back up a system with GoKEV-manifest-maker
  hosts: servers-to-backup

  roles:
    - GoKEV.manifest-maker

</pre>

## With a hosts file that looks sort of like this:

<pre>
[servers-to-backup]
myserver001

[servers-to-backup:vars]
server_instance: myFriendlyServerName
dirs_to_backup:
  - name: MyWebDir
    path: /var/www/html
  - name: ApacheConf
    path: /etc/http/conf
</pre>

## With a requirements.yml that looks as such:

<pre>
---
- name: GoKEV.manifest-maker
  version: latest
  src: https://github.com/GoKEV/GoKEV-manifest-maker.git
</pre>

## Manifest files look like this:
<pre>

manifest_files: 
  - fullpath: /var/www/MyWebSitePath/GoKEV-meme.png
    relative: GoKEV-meme.png
    user: kevin
    group: kevin
    perms: 644 
  - fullpath: /var/www/MyWebSitePath/index.html
    relative: index.html
    user: kevin
    group: kevin
    perms: 644 
  - fullpath: /var/www/MyWebSitePath/Kev-sings-the-blues.mp3
    relative: Kev-sings-the-blues.mp3
    user: kevin
    group: kevin
    perms: 644 

</pre>

## Troubleshooting & Improvements

- Not enough testing yet

## Notes

  - Not enough testing yet

## Author

This project was created in 2018 by [Kevin Holmes](http://GoKEV.com/).


