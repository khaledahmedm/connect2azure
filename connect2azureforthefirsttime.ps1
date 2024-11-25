# Set the execution policy to allow running scripts
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Force

# Install the latest version of PowerShellGet if not already installed
Install-Module -Name PowerShellGet -Force -AllowClobber

# Install the Az module (which is the recommended module for Azure interaction)
Install-Module -Name Az -Repository PSGallery -Force

# Import the Az module
Import-Module Az

# Verify that the AzureRM module is not loaded, and remove it if it exists
if (Get-Module -Name AzureRM -ListAvailable) {
    Remove-Module -Name AzureRM -Force
}

# Try connecting to Azure account
try {
    # Attempt to login interactively
    Connect-AzAccount
} catch {
    Write-Host "Interactive login failed. Attempting Device Code login..."

    # If interactive login fails (e.g., due to MFA or browser issues), use device code login
    Connect-AzAccount -UseDeviceAuthentication
}

# If you need to specify a Tenant ID
# Connect-AzAccount -TenantId "your-tenant-id-here"

# After successful login, you can retrieve information such as subscriptions
Get-AzSubscription
