[CmdletBinding(DefaultParameterSetName = "Build")]
param(
  [parameter(Mandatory=$true, HelpMessage="Enter name and key values")]$DepsDir,
  [Parameter(ParameterSetName="Build")][switch]$Build,
  [Parameter(ParameterSetName="BuildDeps")][switch]$BuildDeps,
  [Parameter(ParameterSetName="Package")][switch]$Package
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
$ProgressPreference = 'SilentlyContinue'

$projectDir = [System.IO.Path]::GetFullPath("$(Get-Location)")
$buildDir = Join-Path -Path $projectDir -ChildPath "build"

Write-Host "############################################################"
$env:DEPS_BUILD_DIR = [System.IO.Path]::GetFullPath($DepsDir)
$buildDir = Join-Path -Path $projectDir -ChildPath "release"
Write-Host "env:DEPS_BUILD_DIR" $env:DEPS_BUILD_DIR
Write-Host "buildDir" $buildDir
Write-Host "############################################################"

$cmakeBuildType = 'Release'
$depsCmakeVars = @{
  CMAKE_BUILD_TYPE=$cmakeBuildType;
}
$nvimCmakeVars = @{
  CMAKE_BUILD_TYPE=$cmakeBuildType;
  BUSTED_OUTPUT_TYPE = 'nvim';
}
if ($null -eq $env:DEPS_BUILD_DIR) {
  $env:DEPS_BUILD_DIR = Join-Path -Path $projectDir -ChildPath ".deps"
}

function exitIfFailed() {
  if ($LastExitCode -ne 0) {
    exit $LastExitCode
  }
}

function convertToCmakeArgs($vars) {
  return $vars.GetEnumerator() | ForEach-Object { "-D$($_.Key)=$($_.Value)" }
}

function BuildDeps {
  if (Test-Path -PathType container $env:DEPS_BUILD_DIR) {
    $cachedBuildTypeStr = $(Get-Content $env:DEPS_BUILD_DIR\CMakeCache.txt `
                            | Select-String -Pattern "CMAKE_BUILD_TYPE.*=($cmakeBuildType)")
    if (-not $cachedBuildTypeStr) {
      Write-Warning " unable to validate build type from cache dir $env:DEPS_BUILD_DIR"
    }
  }

  # we currently can't use ninja for cmake.deps, see #19405
  $depsCmakeGenerator = "Visual Studio 16 2019"
  $depsCmakeGeneratorPlf = "x64"
  cmake -S "$projectDir\cmake.deps" -B $env:DEPS_BUILD_DIR -G $depsCmakeGenerator -A $depsCmakeGeneratorPlf $(convertToCmakeArgs($depsCmakeVars)); exitIfFailed

  $depsCmakeNativeToolOptions= @('/verbosity:normal', '/m')
  cmake --build $env:DEPS_BUILD_DIR --config $cmakeBuildType -- $depsCmakeNativeToolOptions; exitIfFailed
}

function Build {
  cmake -S $projectDir -B $buildDir $(convertToCmakeArgs($nvimCmakeVars)) -G Ninja; exitIfFailed
  cmake --build $buildDir --config $cmakeBuildType; exitIfFailed
}

function Package {
  cmake -S $projectDir -B $buildDir $(convertToCmakeArgs($nvimCmakeVars)) -G Ninja; exitIfFailed
  cmake --build $buildDir --target package; exitIfFailed
}

if ($PSCmdlet.ParameterSetName) {
  & (Get-ChildItem "Function:$($PSCmdlet.ParameterSetName)")
  exit
}
