This project contains two PowerShell scripts designed for use in Microsoft Endpoint Configuration Manager (SCCM) to detect and resolve issues related to dual installations of Microsoft Edge on Windows systems.
Certain Edge installations may result in a secondary executable (typically named msedge.exe) being deployed alongside the standard version. This is indicated by the presence of a specific registry key (opv) and a command (cmd) registered under the EdgeUpdate client registry path. This issue can lead to conflicts, user confusion, or undesired behavior in enterprise environments.
These scripts are intended to automate the detection and remediation of that scenario.

https://answers.microsoft.com/en-us/microsoftedge/forum/all/edge-not-showing-correct-installed-version/9a3fbae0-c6ed-44a2-8e0b-cab367ed8444
