# Full list of operating systems that ansible is able to detect

Ansible has a list of distributions that is detectable by default documented on the [ansible website]. Unfortunately this is not an exhaustive list.

- Alpine
- Altlinux
- Amazon
- Archlinux
- CentOS
- ClearLinux
- Coreos
- Debian
- Fedora
- Gentoo
- MacOSX
- Mandriva
- NA
- OpenWrt
- OracleLinux
- RedHat
- SLES
- SMGL
- SUSE
- Slackware
- Ubuntu
- VMwareESX

In order to get access to one of these variables see the below table.

| Node     | Description            |
| -------- | ---------------------- |
| Host     |                        |
| Remote   | `ansible_distribution` |
| Delegate |                        |

Here is an example snippet of

```yaml
- name: Install homebrew
  import_tasks: homebrew
  when: ansible_distribution == "MacOSX"
```

[ansible website]: https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_conditionals.html#ansible-distribution
