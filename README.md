# Hardening CentOS



---
## Logging and Auditing 

### Configure auditd & syslog-ng - Red Hat and Debian

**Rationale**: If the syslog-ng service is not activated the system may default to the syslogd service or lack logging instead.

### Ensure auditing for processes that start prior to auditd is enabled

**Rationale**: Audit events need to be captured on processes that start up prior to auditd , so that potential malicious activity cannot go undetected. During boot if audit=1, then the backlog will hold 64 records. If more that 64 records are created during boot, auditd records will be lost and potential malicious activity could go undetected.

### Ensure audit logs are not automatically deleted

**Rationale**: In high security contexts, the benefits of maintaining a long audit history exceed the cost of storing the audit history.

### Ensure audit log storage size is configured

**Rationale**: It is important that an appropriate size is determined for log files so that they do not impact the system and audit data is not lost.

### Ensure system is disabled when audit logs are full

**Rationale**: In high security contexts, the risk of detecting unauthorized access or nonrepudiation exceeds the benefit of the system's availability.

### Ensure journald is configured to send logs to rsyslog

**Rationale**: Storing log data on a remote host protects log integrity from local attacks. If an attacker gains root access on the local system, they could tamper with or remove log data that is stored on the local system.

## Ensure unsuccessful unauthorized file access attempts are collected

**Rationale**: Failed attempts to open, create or truncate files could be an indication that an individual or process is trying to gain unauthorized access to the system.

## Ensure successful file system mounts are collected

**Rationale** : It is highly unusual for a non privileged user to mount file systems to the system. While tracking mount commands gives the system administrator evidence that external media may have been mounted (based on a review of the source of the mount and confirming it's an external media type), it does not conclusively indicate that data was exported to the media. System administrators who wish to determine if data were exported, would also have to track successful open , creat and truncate system calls requiring write access to a file under the mount point of the external media file system. This could give a fair indication that a write occurred. The only way to truly prove it, would be to track successful writes to the external media. Tracking write system calls could quickly fill up the audit log and is not recommended. Recommendations on configuration options to track data export to media is beyond the scope of this document.



### Ensure file deletion events by users are collected

**Rationale**: Monitoring these calls from non-privileged users could provide a system administrator with evidence that inappropriate removal of files and file attributes associated with protected files is occurring. While this audit option will look at all events, system administrators will want to look for specific privileged files that are being deleted or altered.

### Ensure kernel module loading and unloading is collected

**Rationale**: Monitoring the use of insmod , rmmod and modprobe could provide system administrators with evidence that an unauthorized user loaded or unloaded a kernel module, possibly compromising the security of the system. Monitoring of the init_module and delete_module system calls would reflect an unauthorized user attempting to use a different program to load and unload modules.

In immutable mode, unauthorized users cannot execute changes to the audit system to potentially hide malicious activity and then put the audit rules back. Users would most likely notice a system reboot and that could alert administrators of an attempt to make unauthorized audit changes.

### Ensure journald is configured to compress large log files

**Rationale**: Uncompressed large files may unexpectedly fill a filesystem leading to resource unavailability. Compressing logs prior to write can prevent sudden, unexpected filesystem impacts.

### Ensure journald is configured to write logfiles to persistnent disk

**Rationale**: Writing log data to disk will provide the ability to forensically reconstruct events which may have impacted the operations or security of a system even after a system crash or reboot.

### Ensure permissions on all log files are configured

**Rationale**: It is important to ensure that log files have the correct permissions to ensure that sensitive data is archived and protected.



---
## File Integrity Checking

### Check if AIDE is installed and present.
AIDE is known as Advanced Intrusion Detection Environment which basically runs a scan on newly created files.

**Rationale**: By monitoring the filesystem state compromised files can be detected to prevent or limit the exposure of accidental or malicious misconfigurations or modified binaries.

### Ensure the AIDE is configured to check the file integrity.

**Rationale**: Periodic file checking allows the system administrator to determine on a regular basis if critical files have been changed in an unauthorized fashion.

---
## File System Hardening

### Disable Cramfs file system

**Description** : The vFAT filesystem format is primarily used on older windows systems and portable USB drives or flash modules. It comes in three types FAT12 , FAT16 , and FAT32 all of which are supported by the vfat kernel module.

**Rationale**: Removing support for unneeded filesystem types reduces the local attack surface of the system. If this filesystem type is not needed, disable it.

### Disable Frevfs file system

**Description** : Freevxfs filesystem should be disabled - Debian specific

**Rationale**: Removing support for unneeded filesystem types reduces the local attack surface of the system. If this filesystem type is not needed, disable it.

### Disable jffs2 file system

Ensure jffs2 filesystem is disabled - Ubuntu distributions only

**Rationale**: Removing support for unneeded filesystem types reduces the local attack surface of the system. If this filesystem type is not needed, disable it.

### Disable Squashfs file system

Squashfs filesystems is disabled.

**Rationale** : Removing support for unneeded filesystem types reduces the local attack surface of the system. If this filesystem type is not needed, disable it.

### Disable HFS file system.

Ensure hfs filesystem is disabled 

**Rationale**: Removing support for unneeded filesystem types reduces the local attack surface of the system. If this filesystem type is not needed, disable it.

### Disable HFS plus file system.

Ensure hfsplus filesystem is disabled

**Rationale**: Removing support for unneeded filesystem types reduces the local attack surface of the system. If this filesystem type is not needed, disable it.

### Disable UDF file system.

UDF Filesystems to be disabled

**Rationale**: Removing support for unneeded filesystem types reduces the local attack surface of the system. If this filesystem type is not needed, disable it.

### Ensure Sticky Bit is set on all world writable directories.

Ensure Sticky Bit is set on all world writable directories

**Rationale**: This feature prevents the ability to delete or rename files in world writable directories (such as /tmp ) that are owned by another user.

### Disable Automounting

Disable Automounting (Need to Troubleshoot)

**Rationale**: With automounting enabled anyone with physical access could attach a USB drive or disc and have its contents available in system even if they lacked permissions to mount it themselves.

### Disable USB Storage

Disable USB Storage

**Rationale**: Restricting USB access on the system will decrease the physical attack surface for a device and diminish the possible vectors to introduce malware.

--
## Mandatory Access Control Hardening

### Ensure SELinux is installed

Ensure SELinux is installed / Ensure AppArmor is installed

**Rationale**: Without a Mandatory Access Control system installed only the default Discretionary Access Control system will be available.

### Ensure SELinux is not disabled in bootloader configuration

SELinux or AppArmor should not be disabled on boot.

**Rationale**: SELinux must be enabled at boot time in your grub configuration to ensure that the controls it provides are not overridden.

### Ensure SELinux state is enforcing

**Rationale**: SELinux must be enabled at boot time in to ensure that the controls it provides are in effect at all times.

### Ensure Apparmour profiles are enforcing

**Rationale**: Run the following command and verify that profiles are loaded, no profiles are in complain mode, and no processes are unconfined.

### Ensure no unconfined daemons exist

**Rationale**: Since daemons are launched and descend from the init process, they will inherit the security context label initrc_t . This could cause the unintended consequence of giving the process more permission than it requires.


### Service Clients and SE Troubleshoot

**Rationale**: Unusable Service clients that are insecure should be uninstalled to prevent accidental or intentional misuse.

--
## Warning Banners

### Ensure message of the day is configured properly

**Rationale**: Warning messages inform users who are attempting to login to the system of their legal status regarding the system and must include the name of the organization that owns the system and any monitoring policies that are in place. Displaying OS and patch level  information in login banners also has the side effect of providing detailed system information to attackers attempting to target specific exploits of a system. Authorized users can easily get this information by running the " uname -a " command once they have logged in.

