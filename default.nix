{ stdenv, lib, fetchpatch, fetchurl,
    libdvdread, intltool, glib, libtool, pkg-config }:

let
  pname = "dvdbackup";
  version = "0.4.2";
  debianRev = "4.1";

  fetchPatchFromDebian = { patch, sha256 }:
    fetchpatch {
      inherit sha256;
      url = "http://sources.debian.net/data/main/d/${pname}/${version}-${debianRev}/debian/patches/${patch}";
    };

in stdenv.mkDerivation {

  name = "${pname}-${version}";
  inherit version;

  src = fetchurl {
    url = "https://sourceforge.net/projects/${pname}/files/${pname}/${pname}-${version}/${pname}-${version}.tar.xz";
    sha256 = "1rl3h7waqja8blmbpmwy01q9fgr5r0c32b8dy3pbf59bp3xmd37g";
  };

  patches = map fetchPatchFromDebian [
    { patch = "ignore-automake-warnings.patch";
      sha256 = "18mw4ydpzfq9niqscb2ak00rw5b470fcpzf7hjx9ky12pi1l7sli"; }
    { patch = "remove-path_max-limitation.patch";
      sha256 = "1f7lyp9b3ny25lhnfaxq1xdydgfc63g9ax4j4mhm19f640k9n8gx"; }
    { patch = "libdvdread6.1.0.patch";
      sha256 = "1c1j799bz1ln3qa4hi4i2nibvjy1lhc12y4izj5mws8xz5naaklg"; }
  ];

  buildInputs = [
    libdvdread  intltool  glib  libtool  pkg-config
  ];

  meta = with lib; {
    homepage = "http://${pname}.sourceforge.net/";
    description = "A tool to rip video DVDs from the command line";
    license = licenses.gpl3;
    maintainers = with maintainers; [ neilmayhew ];
    platforms = platforms.linux;
  };
}
