Ansible playbooks to manage my non-nixos machines.

Windows playbooks are chaos at the moment, with redundant tasks, tasks not relevant to the current OS, and tasks that I likely don't want to keep at all.
Big work in progress for computers that I mostly don't rely on. 

Goal for the windows playbooks is to:
- clean and slim down windows defaults
- set it up as a remote gaming server
- setup nixos on wsl

Plan to manage VyOS through these as well once I switch over to it.


<details>
  <summary>Windows Setup</summary>

Run the following command to install ssh + tailscale. Configure ssh service and auth keys. (in progress not tested yet)

`Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force; iex (iwr 'https://raw.githubusercontent.com/yomaq/homelab-ansible/main/windows/init.ps1').Content`

Sign into tailscale and tag appropriately.

Add tailscale address to ansible inventory and run the init playbook.
</details>