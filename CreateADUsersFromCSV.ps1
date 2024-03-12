# The script will creat bulk users once through powershell.
# For security reason, place password in a right location. 

# Import the AD Module
Import-Module ActiveDirectory

# Get the path to our target CSV file
$filepath = Read-Host -Prompt "Please enter the path to the CSV file that contains the new user accounts"

# Import the CSV as an array
$users = Import-CSV $filepath
$password = get-content -path "C:\password.txt"

# Complete an action for each user in the CSV file
ForEach ($user in $users) {
    # Do this for each user
    New-ADUser `
        -Name ($user.'First Name' + " " + $user.'Last Name') `
        -GivenName $user.'First Name' `
        -Surname $user.'Last Name' `
        -UserPrincipalName ($user.'First Name' + "." + $user.'Last Name') `
        -AccountPassword (ConvertTo-SecureString $password -AsPlainText -Force) `
        -Description $user.Description `
        -EmailAddress $user.'Email Address' `
        -Title $user.'Job Title' `
        -OfficePhone $user.'Office Phone' `
        -Path $user.'Organizational Unit' `
        -ChangePasswordAtLogon 1 `
        -Enabled ([System.Convert]::ToBoolean($user.Enabled))
}
