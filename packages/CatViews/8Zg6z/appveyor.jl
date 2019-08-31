environment:
  matrix:
  - julia_version: 0.7
  - julia_version: 1
  - julia_version: nightly

platform:
  - x86 # 32-bit
  - x64 # 64-bit

# # Uncomment the following lines to allow failures on nightly julia
# # (tests will run but not make your overall status red)
# matrix:
#   allow_failures:
#   - julia_version: nightly

branches:
  only:
    - master
    - /release-.*/

notifications:
  - provider: Email
    on_build_success: false
    on_build_failure: false
    on_build_status_changed: false

install:
  - ps: iex ((new-object net.webclient).DownloadString("https://raw.githubusercontent.com/JuliaCI/Appveyor.jl/version-1/bin/install.ps1"))

build_script:
  - echo "%JL_BUILD_SCRIPT%"
  - C:\julia\bin\julia -e "%JL_BUILD_SCRIPT%"

test_script:
  - echo "%JL_TEST_SCRIPT%"
  - C:\julia\bin\julia -e "%JL_TEST_SCRIPT%"

# # Uncomment to support code coverage upload. Should only be enabled for packages
# # which would have coverage gaps without running on Windows
# on_success:
#   - echo "%JL_CODECOV_SCRIPT%"
#   - C:\julia\bin\julia -e "%JL_CODECOV_SCRIPT%"
