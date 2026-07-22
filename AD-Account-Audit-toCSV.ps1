# 1. Fetch all Domain Admins upfront for fast lookup
$domainAdmins = Get-ADGroupMember -Identity "Domain Admins" -Recursive | Select-Object -ExpandProperty SamAccountName

# 2. Query users, calculate Days since last login, OU & Domain Admin status, and export to CSV
Get-ADUser -Filter * -Properties Created, LastLogonDate | Select-Object Name, 
    SamAccountName, 
    UserPrincipalName,
    Created, 
    Enabled,
    LastLogonDate,
    @{
        Name       = 'DaysSinceLastLogin'
        Expression = { 
            if ($_.LastLogonDate) { 
                [math]::Floor(((Get-Date) - $_.LastLogonDate).TotalDays) 
            } else { 
                'Never' 
            } 
        }
    },
    @{Name = 'OU'; Expression = { ($_.DistinguishedName -split '(?<!\\),', 2)[1] }},
    @{Name = 'IsDomainAdmin'; Expression = { $_.SamAccountName -in $domainAdmins }} |
Export-Csv -Path "C:\AD-userAccount-Audit.csv" -NoTypeInformation
