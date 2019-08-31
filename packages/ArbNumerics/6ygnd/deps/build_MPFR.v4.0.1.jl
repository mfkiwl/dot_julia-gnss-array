using BinaryProvider # requires BinaryProvider 0.3.0 or later

# Parse some basic command-line arguments
const verbose = "--verbose" in ARGS
const prefix = Prefix(get([a for a in ARGS if a != "--verbose"], 1, joinpath(@__DIR__, "usr")))
products = [
    LibraryProduct(prefix, String["libmpfr"], :libmpfr),
]

# Download binaries from hosted location
bin_prefix = "https://github.com/JuliaMath/MPFRBuilder/releases/download/v4.0.1-3"

# Listing of files generated by BinaryBuilder:
download_info = Dict(
    Linux(:aarch64, :glibc) => ("$bin_prefix/MPFR.v4.0.1.aarch64-linux-gnu.tar.gz", "4feeff7ad0dbf9fe3e18bc2aa36cfb9b71ef503a63a9d1e6c454d0cbbd3f7e3c"),
    Linux(:aarch64, :musl) => ("$bin_prefix/MPFR.v4.0.1.aarch64-linux-musl.tar.gz", "e5dcecbea0d731e5bcb63637b7cff1118916f0b14df7cb95f2c54a495ead9e27"),
    Linux(:armv7l, :glibc, :eabihf) => ("$bin_prefix/MPFR.v4.0.1.arm-linux-gnueabihf.tar.gz", "526829b5ffbc58c9a4fc62317f26af43c2ad31e254e40184559af8cb0eb37418"),
    Linux(:armv7l, :musl, :eabihf) => ("$bin_prefix/MPFR.v4.0.1.arm-linux-musleabihf.tar.gz", "83b1f9e74f65bd71e1eae273bbb1da250600834167e0ef15f0fa3284aa7d33a4"),
    Linux(:i686, :glibc) => ("$bin_prefix/MPFR.v4.0.1.i686-linux-gnu.tar.gz", "16654cbc08414620792f47a62315f63799dbdc2461b76defa96ead4290c0c12e"),
    Linux(:i686, :musl) => ("$bin_prefix/MPFR.v4.0.1.i686-linux-musl.tar.gz", "f71c5a381966e266ff8c4bf3a50fed2e4cb8e52850fa2c26aea916c414b20f9b"),
    Windows(:i686) => ("$bin_prefix/MPFR.v4.0.1.i686-w64-mingw32.tar.gz", "206c7f91a5884077c1f59d3700b0a779558a1626de4e80aded13b2d9a601abda"),
    Linux(:powerpc64le, :glibc) => ("$bin_prefix/MPFR.v4.0.1.powerpc64le-linux-gnu.tar.gz", "3cb00d1ce50296d8f3de7fd31f74e15eb687fc524366e5f956ca1def7ab0256d"),
    MacOS(:x86_64) => ("$bin_prefix/MPFR.v4.0.1.x86_64-apple-darwin14.tar.gz", "949e1ac49d36cb17efa788f6d2f1d0f6c59d238a9b16bdb267e384cc199ce5db"),
    Linux(:x86_64, :glibc) => ("$bin_prefix/MPFR.v4.0.1.x86_64-linux-gnu.tar.gz", "ad6e86bab37dbe513783c8bfffbefe536d1fdfca253b0c4b204c8c4ce050e035"),
    Linux(:x86_64, :musl) => ("$bin_prefix/MPFR.v4.0.1.x86_64-linux-musl.tar.gz", "67d1eb4044b8a688ff768722e2ed29fc22f17723191539d769f0c81e0d02f2cc"),
    FreeBSD(:x86_64) => ("$bin_prefix/MPFR.v4.0.1.x86_64-unknown-freebsd11.1.tar.gz", "19b126869e6e725e4110f0d23a1443fc0a839d39e3c1f8f47324b0068a52d656"),
    Windows(:x86_64) => ("$bin_prefix/MPFR.v4.0.1.x86_64-w64-mingw32.tar.gz", "c5634e4fad9d2d85799634c50767efcbb9b9eb72f3d29508fe8d98d50314aa6b"),
)

# Install unsatisfied or updated dependencies:
unsatisfied = any(!satisfied(p; verbose=verbose) for p in products)
if haskey(download_info, platform_key())
    url, tarball_hash = download_info[platform_key()]
    if unsatisfied || !isinstalled(url, tarball_hash; prefix=prefix)
        # Download and install binaries
        install(url, tarball_hash; prefix=prefix, force=true, verbose=verbose)
    end
elseif unsatisfied
    # If we don't have a BinaryProvider-compatible .tar.gz to download, complain.
    # Alternatively, you could attempt to install from a separate provider,
    # build from source or something even more ambitious here.
    error("Your platform $(triplet(platform_key())) is not supported by this package!")
end

# Write out a deps.jl file that will contain mappings for our products
write_deps_file(joinpath(@__DIR__, "deps.jl"), products)
