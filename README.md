# Active Directory User Audit Script

A lightweight, efficient PowerShell script designed to audit Active Directory user accounts. It collects essential user attributes, calculates security metrics like inactive account duration, determines domain admin status, and exports the findings to a clean CSV report.

---

## Features

* **Domain Admin Detection:** Pre-fetches recursive group membership to quickly flag accounts with privileged `Domain Admins` rights without slowing down individual queries.
* **Inactivity Tracking:** Calculates the exact number of whole days since a user's last logon (`DaysSinceLastLogin`), cleanly handling accounts that have never logged in.
* **OU Extraction:** Automatically extracts the parent Organizational Unit (OU) path from each user's `DistinguishedName`.
* **Performance Optimized:** Queries Active Directory efficiently by pulling only required attributes (`Created`, `LastLogonDate`) rather than loading heavy unused properties.
* **Cross-Version Compatible:** Runs smoothly on both Windows PowerShell 5.1 and PowerShell 7+.

---

## Output Overview

The script generates a CSV file saved at `C:\AD-userAccount-Audit.csv` containing the following attributes:

| Column Header | Description |
| --- | --- |
| **Name** | Display name of the user. |
| **SamAccountName** | Pre-Windows 2000 logon name (username). |
| **UserPrincipalName** | User Principal Name (e.g., `user@domain.com`). |
| **Created** | Date and time the account was created in Active Directory. |
| **Enabled** | Boolean state (`True`/`False`) indicating if the account is active. |
| **LastLogonDate** | Last recorded interactive logon timestamp. |
| **DaysSinceLastLogin** | Whole number of days since last logon (or `'Never'`). |
| **OU** | Immediate parent Organizational Unit path. |
| **IsDomainAdmin** | Boolean (`True`/`False`) indicating recursive Domain Admin membership. |

---

## Prerequisites

Before running the script, ensure you have:

1. **Active Directory PowerShell Module** installed (included with Remote Server Administration Tools / RSAT).
2. **Read Permissions** in the Active Directory domain you are auditing.
3. **Execution Policy** set to allow script execution (e.g., `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process`).

---

## Usage

1. **Clone or Download** this repository:
```bash
git clone https://github.com/dksmithcybertog/ActiveDirectory-UserAccount-Audit.git

```


2. **Open PowerShell** as an Administrator (or as a domain user with AD read privileges).
3. **Navigate to the directory** and run the script:
```powershell
.\AD-UserAudit.ps1

```


4. **Retrieve your results** from `C:\AD-userAccount-Audit.csv`.

---


## License

This project is licensed under the [MIT License](https://www.google.com/search?q=LICENSE).
