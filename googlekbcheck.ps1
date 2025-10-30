# To use (with Unity)
# 1. Build the Android APK
# 2. Unzip the apk to a folder
# 3. Locate the libs folder, normally - "\lib\arm64-v8a"
# 4. run script in the folder, a .csv will be generated
# 5. Check the last entry for each .so entry:
#  - 1000 - NOT compliant
#  - 4000 - 16kb Compliant

param(
    [Parameter(Mandatory = $true)]
    [string]$ReadElfPath
)

# Pass path to your local llvm-readelf.exe, e.g.
#$ReadElfPath = 'Unity\Editors\6000.0.59f2\Editor\Data\PlaybackEngines\AndroidPlayer\NDK\toolchains\llvm\prebuilt\windows-x86_64\bin\llvm-readelf.exe'

Get-ChildItem -Recurse -Filter *.so | ForEach-Object {
    $file = $_.FullName
    & $ReadElfPath -l $file |
        Select-String 'LOAD' | ForEach-Object {
            $line = $_.Line.Trim()
            # try to extract the Align token (last hex/decimal token)
            $tokens = ($line -split '\s+') | Where-Object { $_ -ne '' }
            $align = ($tokens | Select-String -Pattern '^(0x[0-9a-fA-F]+|\d+)$' -AllMatches).Matches |
                     Select-Object -Last 1 | ForEach-Object { $_.Value }
            [PSCustomObject]@{
                Filename = $file
                LineText = $line
                Align    = $align
            }
        }
} | Export-Csv -Path align-readelf.csv -NoTypeInformation -Encoding UTF8